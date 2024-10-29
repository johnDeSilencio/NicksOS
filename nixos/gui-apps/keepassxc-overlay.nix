self: super: {
  # Polyfill to allow Discord to do screensharing on Wayland through xwaylandbridge
  discord = super.keepassxc.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        wrapProgram $out/bin/keepassxc --set QT_SCALE_FACTOR "1.5"
      '';
  });
}
