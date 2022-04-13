FDFPATH=~/FDF #CHANGE THIS TO THE EVALUATEES PATH

FDF=$FDFPATH/FDF
mypath=$(pwd)

echo "SUMMARY" > $mypath/output/summary
for filepath in $mypath/input/*; do
	filename=$(basename "$filepath")
	echo "FILE FOUND UNDER INPUT $filename"
	echo "FILE PATH $filepath"
	cd $FDFPATH
	
	#staging
	mkdir $mypath/output/$filename >/dev/null 2>&1
	rm -rf $mypath/output/$filename/*
	#run program and wake up the terminal with applescript
	osascript $mypath/applescript.applescript
	./FDF $filepath &> $mypath/output/$filename/out &
	lastpid=$(echo "$!")
	#leaks output@
	sleep 1
	leaks $lastpid > $mypath/output/$filename/leaks1
	echo "$filename" >> $mypath/output/summary
	leaks $lastpid | grep "leaks for" >> $mypath/output/summary
	sleep 1
	leaks $lastpid > $mypath/output/$filename/leaks2
	leaks $lastpid | grep "leaks for" >> $mypath/output/summary
	#kill the process
	kill $lastpid
done

echo "TESTING FINISHED!"