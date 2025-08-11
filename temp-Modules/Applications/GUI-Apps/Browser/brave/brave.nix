{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.brave-and-extension;
in {
  options.brave-and-extension.enable = mkEnableOption "Enable Brave with extensions and flags";

  config = mkIf cfg.enable {
    programs.brave = {
      package = pkgs.brave;
      enable = true;
      extensions = [
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
        
      ];

      commandLineArgs = [
        "--disable-features=AutofillSavePaymentMethods"
        "--disable-features=PasswordManagerOnboarding"
        "--disable-features=AutofillEnableAccountWalletStorage"
      ];
    };
  };
}
