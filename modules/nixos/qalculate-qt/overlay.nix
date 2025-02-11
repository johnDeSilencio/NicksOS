self: super: {
  # Increases the size of the text in KeePassXC by 50%
  qalculate-qt = super.qalculate-qt.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        wrapProgram $out/bin/qalculate-qt --set QT_SCALE_FACTOR "2.0"
      '';
  });
}
