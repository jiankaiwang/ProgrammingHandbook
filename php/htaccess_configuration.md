# htaccess configuration

<script type="text/javascript" src="../js/general.js"></script>

* Apache Server as the service

```bash
# not to listing the directory
Options -Indexes   
```

* Apache Server Configuration Setting，**/etc/apache2/apache2.conf**

```ini
# not to listing the directory
# notice AllowOverride can not be None
<Directory /var/www/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
```