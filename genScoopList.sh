#!/bin/bash
# Requirements for generation of miningInfo.php:
# - A scavenger mining log with more then 4000 blocks (else it doesn't make sense) -> variable scavengerLog
# - A wallet you can query, maybe your own? -> variable wallet
### Config
wallet=""
scavengerLog="/home/miner/miner.log"
### Don't touch from here
outFile="miningInfo.php"

# Write header to file
echo '<?php' > ${outFile}
echo '$infoPerScoop = [' >> ${outFile}
i=1
while [ ${i} -lt 4097 ]
do
	# search for scoop ${i}
	if [[ $(grep "scoop=${i}\$" "${scavengerLog}" |tail -1) =~ height=([0-9]+) ]]
	then
		# if found, search for blockinfo of ${height}
		height=${BASH_REMATCH[1]}
		if [[ $(curl "${wallet}/burst?requestType=getBlock&height=${height}" 2> /dev/null ) =~ \"generationSignature\":\"([a-z0-9]+)\" ]]
		then
			genSig=${BASH_REMATCH[1]}
		else
			genSig=""
			# didnt find blockinfo, writing a message to the file, that we werent successfull
			echo "	#genSig for ${scoop} @ height ${height} not found!" >> ${outFile}
		fi
	else
		# didnt find the scoop in the log, writing a message to the file, that we werent successfull
		height=""
		echo "	#scoop ${i} not found!" >> ${outFile}
	fi
	# if height and generationSignature is found, write to the file
	if [ "${height}" != "" ] && [ "${genSig}" != "" ]
	then
		echo "	${i} => ['generationSignature' => \"${genSig}\", 'height' => \"${height}\"]," >> ${outFile}
	fi
	# next scoop
	i=$(( ${i} + 1 ))
done
echo '];' >> ${outFile}
