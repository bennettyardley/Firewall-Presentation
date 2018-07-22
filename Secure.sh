iptables -A INPUT -p tcp -m connlimit --connlimit-above 60 -j REJECT --reject-with tcp-reset
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
iptables -A INPUT -p tcp -m conntrack --ctstate NEW -j DROP
iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j DROP
iptables -A INPUT -m state --state INVALID -j DROP 
iptables -A FORWARD -m state --state INVALID -j DROP 
iptables -A OUTPUT -m state --state INVALID -j DROP
iptables -t mangle -A PREROUTING -p icmp -j DROP
iptables -A INPUT -s 10.0.0.0/8 -j DROP 
iptables -A INPUT -s 169.254.0.0/16 -j DROP 
iptables -A INPUT -s 172.16.0.0/12 -j DROP 
iptables -A INPUT -s 127.0.0.0/8 -j DROP 
iptables -A INPUT -s 224.0.0.0/4 -j DROP 
iptables -A INPUT -d 224.0.0.0/4 -j DROP 
iptables -A INPUT -s 240.0.0.0/5 -j DROP 
iptables -A INPUT -d 240.0.0.0/5 -j DROP 
iptables -A INPUT -s 0.0.0.0/8 -j DROP 
iptables -A INPUT -d 0.0.0.0/8 -j DROP 
iptables -A INPUT -d 239.255.255.0/24 -j DROP 
iptables -A INPUT -d 255.255.255.255 -j DROP
iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --set
iptables -A INPUT -p tcp --dport ssh -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP
arptables -P INPUT DROP
arptables -A INPUT --source-mac MACADDRESS -j ACCEPT
