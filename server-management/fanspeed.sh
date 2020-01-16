#!/usr/bin/env bash
set +e
set -x

user=root
password=Jeffkim121
ip=192.168.20.181
fanSpeed=5
fanSpeedHex="0x$(echo "obase=16;$fanSpeed"|bc)"

echo "Checking temperatures and fan settings"
ipmitool -H $ip -U $user -P $password -I lanplus sensor | grep -i -E 'fan|temp'

echo "Setting manual fan control"
ipmitool -H $ip -U $user -P $password -I lanplus raw 0x30 0x30 0x01 0x00

echo "Setting fans to $fanSpeed% ($fanSpeedHex)"
ipmitool -H $ip -U $user -P $password -I lanplus raw 0x30 0x30 0x02 0xff "$fanSpeedHex"
