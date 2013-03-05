#!/bin/sh

caps_realm=XTESOFT.COM
lowe_realm=xtesoft.com
dot_realm=.xtesoft.com
domain_name=xtesoft
caps_domain_name=XTESOFT
domain_hostname=winserver.$lowe_realm
wins_server=$domain_hostname
kdc=192.168.1.110
caps_admin_user=ADMINISTRADOR
admin_user=administrador
caps_domain_hostname=WINSERVER.$caps_realm

pacman -S --noconfirm  samba ntp heimdal pam_pwcheck pam-krb5

#Hosts file config

echo "$kdc	$caps_domain_hostname" >> /etc/hosts

#Configuracion de daemons Samba
sambaconf_file=/etc/conf.d/samba

mv $sambaconf_file $sambaconf_file.orig


echo "##### /etc/conf.d/samba #####" >> $sambaconf_file
echo "#SAMBA_DAEMONS=(smbd nmbd)" >> $sambaconf_file
echo "SAMBA_DAEMONS=(smbd nmbd winbindd)" >> $sambaconf_file 

#Configuración Heimdal / Kerberos

hkerberos_file=/etc/krb5/krb5.conf

mv $hkerberos_file $hkerberos_file.orig

echo "##### /etc/krb5/krb5.conf ####" >> $hkerberos_file
echo "[libdefaults]" >> $hkerberos_file
echo "  default_realm 	= $caps_realm" >> $hkerberos_file
echo "	clockskew 	= 300" >> $hkerberos_file
echo "	ticket_lifetime	= 1d" >> $hkerberos_file
echo "	allow_weak_crypto = true" >> $hkerberos_file
echo "[realms]" >> $hkerberos_file
echo "	$caps_realm = {" >> $hkerberos_file
echo "	kdc 	= 	$kdc" >> $hkerberos_file
echo "	default_domain = $caps_realm" >> $hkerberos_file
echo "	}" >> $hkerberos_file
	
	
echo "[domain_realm]" >> $hkerberos_file
echo "	$dot_realm   = $caps_realm" >> $hkerberos_file
echo "	$lowe_realm  = $caps_realm" >> $hkerberos_file
echo "	$domain_name = $caps_realm" >> $hkerberos_file

echo "[appdefaults]" >> $hkerberos_file
echo "	pam = {" >> $hkerberos_file
echo "	ticket_lifetime 	= 1d" >> $hkerberos_file
echo "	renew_lifetime 		= 1d" >> $hkerberos_file
echo "	forwardable 		= true" >> $hkerberos_file
echo "	proxiable 		= false" >> $hkerberos_file
echo "	retain_after_close 	= false" >> $hkerberos_file
echo "	minimum_uid 		= 0" >> $hkerberos_file
echo "	debug 			= false" >> $hkerberos_file
echo "	}" >> $hkerberos_file

echo " [logging]" >> $hkerberos_file
echo "	default	= SYSLOG:NOTICE:DAEMON" >> $hkerberos_file
echo "	kdc = FILE:/var/log/kdc.log" >> $hkerberos_file

#Set Date-Time ntp
/usr/bin/ntpdate $domain_hostname

#Init process kdc

kinit $cap_admin_user@$caps_realm

#PAM configuration for login
login_file=/etc/pam.d/login

echo "#xtesoft_added" >> $login_file
echo "auth     sufficient     pam_unix2.so" >> $login_file
echo "auth     required       pam_winbind.so use_first_pass use_authtok" >> $login_file
echo "auth     required       pam_securetty.so" >> $login_file
echo "auth     required       pam_nologin.so" >> $login_file
echo "auth     required       pam_mail.so" >> $login_file
echo "account  sufficient     pam_unix2.so" >> $login_file
echo "account  sufficient     pam_winbind.so use_first_pass use_authtok" >> $login_file
echo "password required       pam_pwcheck.so" >> $login_file
echo "password sufficient     pam_unix2.so" >> $login_file
echo "password sufficient     pam_winbind.so use_first_pass use_authtok" >> $login_file
echo "session  required       pam_mkhomedir.so skel=/etc/skel/ umask=0022" >> $login_file
echo "session  sufficient     pam_unix2.so" >> $login_file
echo "session  sufficient     pam_winbind.so use_first_pass use_authtok" >> $login_file
echo "session  required       pam_limits.so" >> $login_file

#Samba configuration for shares

samba_file=/etc/samba/smb.conf

mv $samba_file $samba_file.orig

echo "#### /etc/samba/smb.conf ####" >> $samba_file
echo "[Global]" >> $samba_file
echo "netbios name = $HOSTNAME" >> $samba_file
echo "workgroup = $caps_domain_name" >> $samba_file
echo "realm = $caps_realm" >> $samba_file
echo "server string = $HOSTNAME" >> $samba_file
echo "map to guest = Bad User" >> $samba_file
echo "idmap uid = 10000-20000" >> $samba_file
echo "idmap gid = 10000-20000" >> $samba_file
echo "winbind enum users = yes" >> $samba_file
echo "winbind enum groups = yes" >> $samba_file
echo "winbind gid = 10000-20000" >> $samba_file
echo "winbind use default domain = Yes" >> $samba_file
echo "winbind separator =+" >> $samba_file
echo "os level = 20" >> $samba_file

echo "template shell = /bin/bash" >> $samba_file
 
echo "encrypt passwords = yes" >> $samba_file
echo "security = ads" >> $samba_file
echo "password server = $domain_hostname" >> $samba_file
echo "preferred master = no" >> $samba_file
echo "dns proxy = no" >> $samba_file
echo "wins server = $wins_server" >> $samba_file
echo "wins proxy = no" >> $samba_file

echo "#admin users = @\"NET+domain admins\"" >> $samba_file
echo "#force group = \"$caps_domain_name+domain admins\"" >> $samba_file
echo "inherit acls = Yes" >> $samba_file
echo "map acl inherit = Yes" >> $samba_file
echo "acl group control = yes" >> $samba_file


echo "load printers = no" >> $samba_file
echo "debug level = 3" >> $samba_file
echo "use sendfile = no" >> $samba_file
 
echo "#[homes]" >> $samba_file
echo "#comment = User´s homedirs" >> $samba_file
echo "#path =/home/%U" >> $samba_file
echo "#valid users = %S NET+%S" >> $samba_file
echo "#browseable = no" >> $samba_file
echo "#read only = no" >> $samba_file

##### /etc/nsswitch.conf ####

nsswitch_file=/etc/nsswitch.conf

mv $nsswitch_file $nsswitch_file.orig


echo "# Begin /etc/nsswitch.conf" >> $nsswitch_file

echo "passwd: files winbind" >> $nsswitch_file
echo "group: files winbind" >> $nsswitch_file
echo "shadow: files winbind" >> $nsswitch_file

echo "publickey: files" >> $nsswitch_file

echo "hosts: files dns" >> $nsswitch_file
echo "networks: files" >> $nsswitch_file

echo "protocols: files" >> $nsswitch_file
echo "services: files" >> $nsswitch_file
echo "ethers: files" >> $nsswitch_file
echo "rpc: files" >> $nsswitch_file

echo "netgroup: files" >> $nsswitch_file

echo "# End /etc/nsswitch.conf" >> $nsswitch_file

/etc/rc.d/samba restart

net ads join -U $admin_user

