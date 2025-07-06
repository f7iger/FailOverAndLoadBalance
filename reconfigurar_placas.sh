# Clear previous configuration
sudo ip addr flush dev eth0
sudo ip addr flush dev eth1
sudo ip addr flush dev eth2

# Set the new ip addresses
sudo ip addr add 192.168.0.x dev eth0
sudo ip addr add 192.168.1.x dev eth1
sudo ip addr add 192.168.2.x dev eth2

# Up interfaces
ip link set eth0 up
ip link set eth1 up
ip link set eth2 up

