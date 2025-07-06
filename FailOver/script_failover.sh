#!/bin/bash
while true; do
  if ! ping -c 1 -I eth0 8.8.8.8 >/dev/null && \
     ! ping -c 1 -I eth1 8.8.8.8 >/dev/null; then

    echo "Ambos links inativos. Ativando eth2 como default."
    ip route replace default via 192.168.2.1 dev eth2

  else
    # Garante que o balanceamento está ativo novamente
    ip route replace default scope global \
      nexthop via 192.168.0.1 dev eth0 weight 1 \
      nexthop via 192.168.1.1 dev eth1 weight 1
  fi
  sleep 10
done
