#!/bin/bash

maxWarningTemp=90
middleWarningTemp=70

#command nvidia-smi -q -d TEMPERATURE | grep 'GPU Current Temp' | cut -d ':' -f 2 | cut -d ' ' -f 2 | cat >> ~/.scripts/gpu_temp
curTemp=$(nvidia-smi -q -d TEMPERATURE | grep 'GPU Current Temp' | cut -d ':' -f 2 | cut -d ' ' -f 2)

temperature="echo -e "

if [[ $curTemp -gt $maxWarningTemp ]]; then
	temperature="${temperature}'\033[0;31m'"
elif [[ $curTemp -gt $middleWarningTemp ]]; then
	temperature="${temperature}'\033[1;33m'" 
else
	temperature="${temperature}'\033[1;32m'" 
fi

temperature="${temperature}${curTemp}"

eval $temperature
