/**
* For now this just hard copies the config file.
* This can be improved by allowing users to define there own task bar config
*/
{ config, lib, pkgs, ... }: let 
  cfg = config.nixos95.taskbar;
  user = config.nixos95.user;
  t = lib.types;
  slib = pkgs.callPackage ./util/lib.nix { };

in {

  options.nixos95.taskbar = {

    homeIcon = lib.mkOption {
      description = ''
        Home icon used in the lefter corner of the taskbar

        Can be either a `path` to an icon to use,
        or the name (string) of an icon in the current theme.
        This will be the `Win95_plus` theme by default.
        You can check for existing icons inside `/Ressources/Icons/Win95_plus`.
      '';
      default = "whisker-menu-button";
      type = t.either t.str t.path;
      example = "world";
    };

    battery-plugin = {
      enable = lib.mkOption {
        description = ''
          Enable the battery plugin in the taskbar.

          This will show the charging status in the right corner.
          On hover it will show the excat percentage.
        '';
        default = true;
        example = false;
        type = t.bool;
      };
      power_bar = let 
        mkColor = state : default : lib.mkOption {
          description = "Color to show while ${state}";
          type = t.str;
          inherit default;
        };
      in {
        enable = lib.mkOption {
          description = ''
            Enable the power bar, which shows the charging level.
          '';
          type = t.bool;
          default = true;
          example = false;
        };
        critical_at = lib.mkOption {
          description = ''
            Set the maximum battery percentage of the "critical" state
          '';
          type = t.int;
          default = 10;
          example = 20;
        };
        warning_at = lib.mkOption {
          description = ''
            Set the maximum battery percentage of the "warning" state
          '';
          type = t.int;
          default = 20;
          example = 30;
        };
        color_warning = mkColor "in a warning state" "rgb(248,228,92)";
        color_critical = mkColor "in a critical state" "rgb(237,51,59)";
        color_loading = mkColor "charging" "rgb(119,118,123)";
        color_default = mkColor "discharging" "rgb(143,240,164)";
      };
    };

    applications = lib.mkOption {
      description = ''
        (in order) list of applications to pin in the taskbar.

        Applications must be defined as a set each with the following name-value paris:
        {
          enable = bool;        [optional; default = true]
          name = string;        [application name shown on hover; optional]
          description = string; [text shown on hover; optional]
          icon = string | path; [icon shown in the task bar]
          terminal = bool;      [start the program inside a terminal; optional; default = false]
          [either pkg or exe must be defined]
          pkg = package;        [use mainProgramm of a nix package; e.g. pkgs.firefox]
          exe = string;         [provide a program name directly; e.g. firefox]
        }

        The `icon` can be specified as an icon name (in the current Iocn pack)
        or as a `path` to an image directly.
        See `/Ressources/Icons/Win95_plus` for the default icons.

      '';
      default = [
        {
          name = "Files";
          description = "View and manage local files";
          icon = "folder_open";
          exe = "exo-open --launch FileManager";
        }
        {
          name = "Terminal";
          description = "Run commands";
          icon = "xfce4-terminal";
          pkg = pkgs.xfce.xfce4-terminal;
        }
        {
          name = "Browser";
          description = "Access the world wide web";
          icon = "firefox";
          exe = "exo-open --launch WebBrowser";
        }
      ];
      type = t.listOf t.attrs;
    };

  };

  config = lib.mkIf config.nixos95.enable {

    environment.systemPackages = [
      pkgs.xfce.xfce4-whiskermenu-plugin
      (lib.mkIf cfg.battery-plugin.enable pkgs.xfce.xfce4-battery-plugin)
    ];

    home-manager.users.${user} = {
      
      xdg.configFile = {

        "xfce4/panel/battery-7.rc" = {
          force = true;
          enable = cfg.battery-plugin.enable;
          text = let 
            bar = cfg.battery-plugin.power_bar;
          in ''
            display_label=false
            display_icon=true
            display_power=false
            display_percentage=false
            display_bar=${if bar.enable then "true" else "false"}
            display_time=false
            tooltip_display_percentage=true
            tooltip_display_time=false
            low_percentage=${builtins.toString bar.warning_at}
            critical_percentage=${builtins.toString bar.critical_at}
            action_on_low=1
            action_on_critical=1
            hide_when_full=0
            colorA=${bar.color_loading}
            colorH=${bar.color_default}
            colorL=${bar.color_warning}
            colorC=${bar.color_critical}
            command_on_low=
            command_on_critical=
          '';
        };

        "xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml" = let 

          ifBattery = str : if cfg.battery-plugin.enable then str else "";
          battery_id = ifBattery '' <value type="int" value="7" /> '';
          battery_xml = ifBattery '' <property name="plugin-7" type="string" value="battery" /> '';

          applications_cfg = cfg.applications
            |> lib.filter slib.isEnable
            |> lib.imap0 ( ptr : elm : rec {
              # we start IDs in the 20 range to not get confilics with other plugins
              plugin_id = "2" + builtins.toString ptr; 
              plugin_desktop = let 
                desc = if elm ? description then elm.description else "";
                term = if elm ? terminal && elm.terminal then "true" else "false";
                exec = slib.getExe elm;
              in pkgs.writeTextFile {
                name = "${elm.name}.desktop";
                text = ''
                  [Desktop Entry]
                  Version=1.0
                  Type=Application
                  Name=${elm.name}
                  Icon=${elm.icon}
                  Exec=${exec}
                  Comment=${desc}
                  Terminal=${term}
                '';
              };
              plugin_xml = ''
                <property name="plugin-${plugin_id}" type="string" value="launcher">
                  <property name="show-label" type="bool" value="false" />
                  <property name="items" type="array">
                    <value type="string" value="${plugin_desktop}" />
                  </property>
                </property>
              '';
            });

          app_ids = applications_cfg
            |> lib.map ( elm : '' <value type="int" value="${elm.plugin_id}"/> '' )
            |> lib.concatStringsSep "\n";
          app_xml = applications_cfg
            |> lib.map ( elm : elm.plugin_xml )
            |> lib.concatStringsSep "\n";

        in {
          force = true;
          text = ''
            <?xml version="1.1" encoding="UTF-8"?>
            <channel name="xfce4-panel" version="1.0">
              <property name="configver" type="int" value="2"/>
              <property name="panels" type="array">
                <value type="int" value="1"/>
                <property name="dark-mode" type="bool" value="true"/>
                <property name="panel-1" type="empty">
                  <property name="position" type="string" value="p=8;x=1368;y=1810"/>
                  <property name="length" type="double" value="100"/>
                  <property name="position-locked" type="bool" value="true"/>
                  <property name="icon-size" type="uint" value="0"/>
                  <property name="size" type="uint" value="42"/>
                  <property name="plugin-ids" type="array">
                    <value type="int" value="1"/>
                    ${app_ids}
                    <value type="int" value="3"/>
                    <value type="int" value="4"/>
                    <value type="int" value="5"/>
                    <value type="int" value="6"/>
                    ${battery_id}
                  </property>
                  <property name="mode" type="uint" value="0"/>
                  <property name="background-style" type="uint" value="0"/>
                </property>
              </property>
              <property name="plugins" type="empty">
                <property name="plugin-1" type="string" value="whiskermenu">
                  <property name="button-icon" type="string" value="${cfg.homeIcon}"/>
                  <property name="recent" type="array">
                  </property>
                </property>
                ${app_xml}
                <property name="plugin-3" type="string" value="tasklist">
                  <property name="grouping" type="uint" value="1"/>
                </property>
                <property name="plugin-4" type="string" value="separator">
                  <property name="expand" type="bool" value="true"/>
                  <property name="style" type="uint" value="0"/>
                </property>
                <property name="plugin-5" type="string" value="systray">
                  <property name="square-icons" type="bool" value="true"/>
                  <property name="known-legacy-items" type="array">
                    <value type="string" value="networkmanager applet"/>
                  </property>
                </property>
                <property name="plugin-6" type="string" value="clock">
                  <property name="mode" type="uint" value="2"/>
                  <property name="digital-layout" type="uint" value="3"/>
                  <property name="digital-time-font" type="string" value="Sans 12"/>
                </property>
                ${battery_xml}
              </property>
            </channel>
          '';
        };

      };

    };
  };

}
