self: super: {
  # Increases the size of the text in kdenlive by 100%
  kdePackages = super.kdePackages // {
    kdenlive = super.kdePackages.kdenlive.overrideAttrs (oldAttrs: {
      postInstall =
        (oldAttrs.postInstall or "")
        + ''
          wrapProgram $out/bin/kdenlive --set QT_SCALE_FACTOR "2.0"
        '';
    });
  };
}
