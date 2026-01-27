{
  lib,
  config,
  ...
}:
{
  options = {
    custom.home.firefox.enable = lib.mkEnableOption "Feature complete browser alternative to Chrome";
  };

  config = lib.mkIf config.custom.home.firefox.enable {
    home-manager.users.nicholas.programs.firefox = {
      enable = true;

      profiles = {
        nick = {
          id = 0;
          name = "nick";
          search = {
            force = true;
            default = "Kagi";

            engines = {
              "Kagi" = {
                urls = [
                  {
                    template = "https://kagi.com/search?";
                    params = [
                      {
                        name = "q";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
              };
            };
          };
        };
      };

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = true;
        DisableAccounts = true;
        DisableFirefoxScreenshots = true;

        ExtensionSettings = {
          # Blocks all extensions except the ones below
          "*".installation_mode = "blocked";

          "privacypass@kagi.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/kagi-privacy-pass/latest.xpi";
            installation_mode = "force_installed";
          };

          "{04188724-64d3-497b-a4fd-7caffe6eab29}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/rust-search-extension/latest.xpi";
            installation_mode = "force_installed";
          };

          "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
            installation_mode = "force_installed";
          };

          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };
        };

        Preferences = {
          "browser.newtabpage.activity-stream.feeds.section.topstories" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.feeds.snippets" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.section.highlights.includePocket" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.showSponsored" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.system.showSponsored" = {
            Value = false;
            Status = "locked";
          };

          "browser.newtabpage.activity-stream.showSponsoredTopSites" = {
            Value = false;
            Status = "locked";
          };
        };
      };

    };
  };
}
