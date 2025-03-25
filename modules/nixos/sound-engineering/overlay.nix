self: super: {
  reaper = super.reaper.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        wrapProgram $out/opt/REAPER/reaper --set GDK_SCALE "2.0"
      '';
  });
}
