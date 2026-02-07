{ lib, ... }: {
  # return true if elm.enable is not set or elm.enable is true
  isEnable = elm : !( lib.hasAttr "enable" elm ) || elm.enable;
  # return executable path from elm.pkg if defined or elm.exe
  getExe = elm : if elm ? pkg then lib.getExe elm.pkg else elm.exe;
}
