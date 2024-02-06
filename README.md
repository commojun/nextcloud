# nextcloud
自宅用nextcloud

### セキュリティ関連
参考: https://docs.nextcloud.com/server/27/admin_manual/installation/harden_server.html#enable-http-strict-transport-security

nextcloudルートディレクトリの `.htaccess` に以下の記述を追加
```
  <IfModule mod_env.c>
    # Add security and privacy related headers

+    Header always set Strict-Transport-Security "max-age=15552000; includeSubDomains"
~~
```

`config/config.php` にはこんな設定を追加している(環境変数で追加できているものもあるかも)

```
  'trusted_domains' => 
  array (
    0 => '192.168.10.30:58888',
    1 => 'nextcloud.commojun.com',
  ),
  'trusted_proxies' => 
  array (
    0 => '192.168.10.30',
  ),
  'overwritehost' => 'nextcloud.commojun.com',
  'overwriteprotocol' => 'https',
  'overwrite.cli.url' => 'https://nextcloud.commojun.com',
```

### リダイレクト関連

cloudflareを使うときは、appに直接つないでいたのでこんな感じの設定をルートディレクトリの `.htaccess` に追加した

だいたいこんな感じに変更や追加

```
-  RewriteRule ^\.well-known/carddav /remote.php/dav/ [R=301,L]
-  RewriteRule ^\.well-known/caldav /remote.php/dav/ [R=301,L]
+  RewriteRule ^\.well-known/carddav https://%{SERVER_NAME}/remote.php/dav/ [R=301,L]
+  RewriteRule ^\.well-known/caldav https://%{SERVER_NAME}/remote.php/dav/ [R=301,L]
+  RewriteRule ^\.well-known/webfinger https://%{SERVER_NAME}/index.php/.well-known/webfinger [R=301,L]
+  RewriteRule ^\.well-known/nodeinfo https://%{SERVER_NAME}/index.php/.well-known/nodeinfo [R=301,L]
~~
-  RewriteRule ^\.well-known/(?!acme-challenge|pki-validation) /index.php [QSA,L]
+  RewriteRule ^\.well-known/(?!acme-challenge|pki-validation) https://%{SERVER_NAME}/index.php [QSA,L]
```

## 2024-02-06メモ

cloudflareとの相性が良くない。100MB以上のファイルがクライアントアプリで同期できないなどの問題がある

https://github.com/nextcloud/desktop/issues/4278
