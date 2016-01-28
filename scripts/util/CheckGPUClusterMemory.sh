#!/bin/bash
# Check for input
if [ $# -gt 2 ]; then
    echo "[ USAGE ]:" $0 "[<isShowOnlyFree=1, Default: 0>]"
    exit
fi

isShowOnlyFree=$1
BaseServerName="srv-12-4"

for i in {5..16}
do
    # if [[ $i -eq 9 || $i -eq 10 ]]; then
    # 	continue
    # fi
   
    if [[ ${isShowOnlyFree} -eq 1 ]]; then
	# The idle RAM usage number below might change depending on the CUDA version
	# ssh -tt ${BaseServerName}$i nvidia-smi | grep 22MiB

	HostName=$(ssh -q -tt ${BaseServerName}$i hostname)
	nGPUs=$(ssh -q -tt ${BaseServerName}$i nvidia-smi -L | wc -l)
	echo "[ ${BaseServerName}$i ]: ${HostName}"
	if [[ ${nGPUs} -gt 0 && ${nGPUs} -lt 3 ]]; then
	    for (( GPUIdx=0; GPUIdx<${nGPUs}; GPUIdx++ )); do
		# Reset values to prevent false detections
		UsedMemory=10000
	    	UsedMemory=$(ssh -q -tt ${BaseServerName}$i nvidia-smi --id=${GPUIdx} --query-gpu=memory.used --format=csv,noheader,nounits)
		UsedMemory=$(echo ${UsedMemory} | xargs)
		echo ${UsedMemory}
		UsedMemory=1000
	    	UsedCompute=$(ssh -q -tt ${BaseServerName}$i nvidia-smi --id=${GPUIdx} --query-gpu=utilization.gpu --format=csv,noheader,nounits)
		UsedCompute=$(echo ${UsedCompute} | xargs)
		echo ${UsedCompute}
	    	if [[ "${UsedMemory}" -lt 100 ]] && [[ "${UsedCompute}" -lt 10 ]]; then
	    	    echo "[[ GPU ${GPUIdx} ]]: *free*"
		else
	    	    echo "[[ GPU ${GPUIdx} ]]: *used*"
	    	fi
	    done
	else
	    echo "No GPUs or too many GPUs found or there was an error."
	fi
    else
	ssh -tt ${BaseServerName}$i nvidia-smi | grep 11519MiB
    fi
done
