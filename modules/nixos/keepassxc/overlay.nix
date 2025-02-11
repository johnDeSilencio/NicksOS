self: super: {
  # Increases the size of the text in KeePassXC by 50%
  keepassxc = super.keepassxc.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        wrapProgram $out/bin/keepassxc --set QT_SCALE_FACTOR "1.5"
      '';
  });
}
