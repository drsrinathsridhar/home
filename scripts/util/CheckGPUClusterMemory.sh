#!/bin/bash
BaseServerName="srv-12-4"

for i in {5..16}
do
    # if [[ $i -eq 9 || $i -eq 10 ]]; then
    # 	continue
    # fi
    ssh -tt ${BaseServerName}$i nvidia-smi | grep 11519MiB
done
