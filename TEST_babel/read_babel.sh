#!/bin/zsh

#This is very important, trust me
bookanim=(" 
\\ 
=======" "\\
 \\
=======" " \\
  \\
=======" "   |
   |
=======" "    /
   /
=======" "     /
    /
=======" "     
     /
=======" "     
      /
=======")


mypath=$(pwd)
filecount=$(ls -l ../babel | wc -l | tr -d '[:space:]')
clear
echo "files = $filecount"
#echo "${bookanim[0]}"
babel=$mypath/../babel
echo "started reading babel mapfiles with FDF"
declare -i index=0
declare -i bookindex=0
for filename in $babel/*; do
	zsh bread.sh $filename &
	
	((index=index+1))
	if [ $((index%50)) -eq 0 ]; then
		clear
		echo "PROGRESS: $index/$filecount maps tested "
		echo " "
		((bookindex=bookindex+1))
		if [ $bookindex -gt 7 ]; then
			((bookindex=0))
		fi
		echo "${bookanim[$bookindex]}"
	fi
	#sleep 0.2
done

clear
echo "read final file: $index"
