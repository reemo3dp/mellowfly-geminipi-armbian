#!/bin/bash

set -euxo pipefail

insert() {
	sleep 30s
	rmmod rtw88_8821cs || true
	sleep 30s
	modprobe rtw88_8821cs
	sleep 5s
	dmesg | tail -n 10
}

insert || true
insert
