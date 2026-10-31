echo 'net.mptcp.enabled = 0' > /etc/sysctl.d/99-no-mptcp.conf
sysctl -p /etc/sysctl.d/99-no-mptcp.conf
sysctl net.ipv4.tcp_migrate_req
command -v nft >/dev/null || apt install -y nftables
nft delete table ip cve_mitigation 2>/dev/null
nft add table ip cve_mitigation
nft add chain ip cve_mitigation prerouting '{ type filter hook prerouting priority -300 ; policy accept ; }'
nft add rule ip cve_mitigation prerouting ip protocol tcp ip hdrlength != 5 counter drop
nft list table ip cve_mitigation
