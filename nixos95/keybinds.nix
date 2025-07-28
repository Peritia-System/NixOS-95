/**
* For now this just hard copies the config file.
* This can be improved by allowing users to define there own keybinds
*/
{ config, lib, pkgs, ... }: let
  cfg = config.nixos95.keybinds;
  t = lib.types;
  slib = pkgs.callPackage ./util/lib.nix { };
in {

  options.nixos95.keybinds = {
    commands = lib.mkOption {
      description = ''
        Keyboard shortcuts that should be made available.

        Each keyboard shortcut is defined as a set with the follwoing schema:
        {
          enable = bool; [optional; default = true]
          key = string; [key sequence to triggger the command]
          # to specify which command to execute use on of the following:
          pkg = package; [use mainProgramm of a nix package; e.g. pkgs.firefox]
          exe = string; [provide a program name directly; e.g. firefox]
        }

        > Modifier keys must be surrounded by angle brackets
      '';
      type = t.listOf t.attrs;
      default = [
        {
          key = "<Super>r";
          exe = "xfce4-appfinder --collapsed";
        }
        {
          key = "XF86WWW";
          exe = "exo-open --launch WebBrowser";
        }
        {
          key = "XF86Mail";
          exe = "exo-open --launch MailReder";
        }
        {
          key = "Print";
          exe = "xfce4-screenshooter";
        }
      ];
    };
    xfwm4 = lib.mkOption {
      description = ''
        Keyboard shortcuts to control xfwm4

        Each keyboard shortcut is defined as a set with the follwoing schema:
        {
          enable = bool; [optional; default = true]
          key = string; [key sequence to triggger the command]
          # to specify which command to execute use on of the following:
          pkg = package; [use mainProgramm of a nix package; e.g. pkgs.firefox]
          exe = string; [provide a program name directly; e.g. firefox]
        }

        > Modifier keys must be surrounded by angle brackets
      '';
      type = t.listOf t.attrs;
      default = [ ];
    };
  };

  config = lib.mkIf config.nixos95.enable {

    home-manager.users.${config.nixos95.user} = {

      xdg.configFile = let 
        to_xml = list : list
          |> lib.filter slib.isEnable
          |> lib.map ( elm : let 
            key = lib.escapeXML elm.key;
            exe = lib.escapeXML (slib.getExe elm);
          in '' <property name="${key}" type="string" value="${exe}"/> '')
          |> lib.concatStringsSep "\n";
        commands_xml = to_xml cfg.commands;
        xfwm4_xml = to_xml cfg.xfwm4;
      in {
        "xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml" = {
          force = true;
          text = ''
            <?xml version="1.1" encoding="UTF-8"?>

            <channel name="xfce4-keyboard-shortcuts" version="1.0">
              <property name="commands" type="empty">
                <property name="custom" type="empty">
                  <property name="override" type="bool" value="true" />
                  ${commands_xml}
                </property>
              </property>
              <property name="xfwm4" type="empty">
                <property name="custom" type="empty">
                  <property name="override" type="bool" value="true" />
                  ${builtins.readFile ./dotfiles/xfwm4-keybinds.xml}
                  ${xfwm4_xml}
                </property>
              </property>
              <property name="providers" type="array">
                <value type="string" value="commands" />
                <value type="string" value="xfwm4" />
              </property>
            </channel>
          '';
        };
      };

    };

  };

}
