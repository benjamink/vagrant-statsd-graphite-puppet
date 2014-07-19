#!/bin/bash

curtime=$(date +%s)
myhost=$(hostname -s)

read cpu_load1 cpu_load5 cpu_load15 <<<$(uptime | awk '{print $8,$9,$10}')
read en0_ipkts en0_ierrs en0_opkts en0_oerrs en0_coll <<<$(netstat -i | awk '/14:10:9f:ce:4d:19/ {print $5,$6,$7,$8,$9}')

for metric in cpu_load1 cpu_load5 cpu_load15 en0_ipkts en0_ierrs en0_opkts en0_oerrs en0_coll; do
  eval value=\$$metric
  echo "${myhost}.mystats.${metric} $value ${curtime}" | nc localhost 2003
done
