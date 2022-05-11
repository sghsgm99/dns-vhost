#!/bin/bash

servn=$1
cname=$2
dir=$3
usr=""
listen="*"

if [ "$(whoami)" != 'root' ]; then
echo "You have to execute this script as root user"
exit 1;
fi

if [ -d "$dir$cname" ]; then
    echo "$dir$cname already exists! Try a different CNAME"
    exit 1;
else
echo "Web directory created with success !"
mkdir -p $dir$cname;
mkdir -p $dir$cname/html/;
mkdir -p $dir$cname/cgi-bin/;

echo "<h1>$cname $servn</h1>" > $dir$cname/html/index.html
chown -R $usr:$usr $dir$cname
chmod -R '755' $dir$cname
chmod -R '755' $dir$cname/cgi-bin/
chmod -R '555' $dir$cname/html/
mkdir /var/log/$cname

alias=$cname.$servn
if [[ "${cname}" == "" ]]; then
alias=$servn
fi

echo "#### $cname $servn
<VirtualHost $listen:80>
ServerName $alias
ServerAlias $alias
DocumentRoot $dir$cname/html/
<Directory $dir$cname>
Options Indexes FollowSymLinks MultiViews
AllowOverride All
Order allow,deny
Allow from all
Require all granted
</Directory>
</VirtualHost>" > /etc/apache2/sites-enabled/$cname.$servn.conf
if [ -e "/etc/apache2/sites-enabled/$cname.$servn.conf" ]; then
echo "Virtual host /etc/apache2/sites-enabled/$cname.$servn.conf created !"
else
echo "Virtual host /etc/apache2/sites-enabled/$cname.$servn.conf wasn't created !"
fi

echo "127.0.0.1 $servn" >> /etc/hosts
if [ "$alias" != "$servn" ]; then
echo "127.0.0.1 $alias" >> /etc/hosts
fi
echo "Testing configuration"
apachectl configtest
apachectl -t
echo "Would you like me to restart the server [y/n]? "
apache2ctl -k graceful
systemctl reload apache2 
echo "======================================"
echo "All work done! You should be able to see your website at http://$servn"
echo ""
echo "Share the love! <3"
echo "======================================"
fi