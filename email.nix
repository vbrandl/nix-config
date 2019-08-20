{ config, pkgs, ... }:

{
  accounts.email.accounts.vbrandlNet = {
    primary = true;
    passwordCommand = "pass Mail/MailVbrandlNet";
    offlineimap = {
      enable = true;
      extraConfig = {
        account = {
          quick = 10;
          autorefresh = 20;
        };
        local = {
          type = "Maildir";
          localfolders= "~/mail/MailVbrandlNet";
          filename_use_mail_timestamp = true;
        };
        remote = {
          type = "IMAP";
          remotehost = "mail.vbrandl.net";
          remoteuser = "mail@vbrandl.net";
          ssl = true;
          keepalive = 60;
          holdconnectionopen = true;
          #sslcacertfile	= /etc/ssl/certs/ca-certificates.crt
          #cert_finterprint = 1a8945e72f22772f35c0a5774cb9321ea0937a42df92ffd27314416d65b26494874d1250d63f622749323cf4af181913

          ssl_version = "tls1_2";
          tls_level = "tls_secure";
          auth_mechanisms = "PLAIN";
          usecompression = true;
          maxconnections = 2;
        };
        postSyncHookCommand = "notmuch new";
      };
    };
  };
}
