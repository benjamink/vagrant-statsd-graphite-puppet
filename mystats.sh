#!/bin/bash

curtime=$(date +%s)
myhost=$(hostname -s)

read cpu_load1 cpu_load5 cpu_load15 <<<$(uptime | awk '{print $10,$11,$12}')
read en0_ipkts en0_ierrs en0_opkts en0_oerrs en0_coll <<<$(netstat -i | awk '/(10\.|192\.168\.1)/ {print $5,$6,$7,$8,$9}' | sed s/-/0/g)

for metric in cpu_load1 cpu_load5 cpu_load15 en0_ipkts en0_ierrs en0_opkts en0_oerrs en0_coll; do
  eval value=\$$metric
  echo "${myhost}.mystats.${metric} $value ${curtime} > localhost:2003"
  echo "${myhost}.mystats.${metric} $value ${curtime}" | nc localhost 2003
done
