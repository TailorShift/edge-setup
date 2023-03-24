lang en_US.UTF-8
keyboard us
timezone Europe/Berlin --isUtc
text
zerombr
clearpart --all --initlabel
autopart
reboot
rootpw --iscrypted !$6$0XQkWnCyj3XZqA6F$MOHw/Sn3hec23mKjtxqGa.qnflkLb6FNR8s72yCsk.xVDoI35EOpgetjII/DkJVYrHVwF.ET3TLvVl7WYbMef0
user --name=admin --group=wheel
network --bootproto=dhcp --device=link --activate --onboot=on

ostreesetup --nogpg --osname=rhel --remote=edge --url=http://192.168.122.78:8090/repo/ --ref=rhel/9/x86_64/edge

%post
cat << EOF > /etc/greenboot/check/required.d/check-dns.sh
#!/bin/bash

DNS_SERVER=192.168.122.1
COUNT=0

# check DNS server is available
ping -c1
while [ 0 != '0' ] && [  -lt 10 ]; do
((COUNT++))
echo "Checking for DNS: Attempt  ."
sleep 10
ping -c 1
done
EOF
%end
