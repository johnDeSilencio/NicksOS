self: super: {
  # Polyfill to allow Discord to do screensharing on Wayland through xwaylandbridge
  discord = super.discord.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        wrapProgram $out/opt/Discord/Discord --set XDG_SESSION_TYPE x11
      '';
  });
}
