#Primeiro passo:
#		 - Configure the FailOver
# FailOver/01-netcfg.yaml

#Segundo passo:
#	- Instalar e configurar iproute2
	  apt install iproute2 -y
	  echo "100 rt_eht0" | tee -a /etc/iproute2/rt_tables
	  echo "101 rt_eht1" | tee -a /etc/iproute2/rt_tables
	  echo "102 rt_eht2" | tee -a /etc/iproute2/rt_tables	  

#Terceiro passo:
#	- Configurar rotas e regras para interface(s):
# Para eth0
ip route add 192.168.0.0/24 dev eth0 src 192.168.0.100 table rt_eth0
ip route add default via 192.168.0.1 dev eth0 table rt_eth0

# Para eth1
ip route add 192.168.1.0/24 dev eth1 src 192.168.1.100 table rt_eth1
ip route add default via 192.168.1.1 dev eth1 table rt_eth1

# Para eth2 (backup)
ip route add 192.168.2.0/24 dev eth2 src 192.168.2.100 table rt_eth2
ip route add default via 192.168.2.1 dev eth2 table rt_eth2

#Quarto passo:
#	- Definir qual tabela usar com base no ip de origem:
ip rule add from 192.168.0.100 table rt_eth0
ip rule add from 192.168.1.100 table rt_eth1
ip rule add from 192.168.2.100 table rt_eth2

#------------------------------	  
#Quarto passo:
#    - Configurar loadBalance
	ip route add default scope global\
	nexthop via 192.168.0.100 dev eth0 weight 1\
	nexthop via 192.168.1.100 dev eth1 weight 1

#Ultimo passo:
#    - Testar
	  ip route show ; ip rule show
	  curl --interface eth0 ifconfig.me
	  
