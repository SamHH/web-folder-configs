{ config, pkgs, ... }:

{
  home-manager.users.${config.username}.programs.git = {
    # GPG signing
    extraConfig = {
      user.signingkey = "4667250BD56735A8";
      commit.gpgSign = true;
      tag.gpgSign = true;
    };

    # send-email
    package = pkgs.gitFull;
    extraConfig = {
      sendemail = {
        smtpserver = "smtp.migadu.com";
        smtpuser = config.email.address;
        smtpencryption = "ssl";
      };
      credential."smtp://hello%40samhh.com@smtp.migadu.com%3a465".helper =
        let
          script = pkgs.writeShellScriptBin "pass-git-credential" ''
            echo "password=$(pass show "$1")"
          '';
        in
        "!${script}/bin/pass-git-credential ${config.email.pass.path}";
    };
  };
}
