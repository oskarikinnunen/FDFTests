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
	mkdir $mypath/output/$filename
	rm -rf $mypath/output/$filename/*
	#run program and wake up the terminal with applescript
	osascript $mypath/applescript.applescript
	./FDF $filepath > $mypath/output/$filename/out 1>&1 &
	lastpid=$(echo "$!")
	#leaks output
	sleep 1
	leaks $lastpid > $mypath/output/$filename/leaks1
	echo "$filename" >> $mypath/output/summary
	leaks $lastpid | grep "leaks for\|malloc" >> $mypath/output/summary
	sleep 1
	leaks $lastpid > $mypath/output/$filename/leaks2
	leaks $lastpid | grep "leaks for\|malloc" >> $mypath/output/summary
	#kill the process
	kill $lastpid
	#osascript applescript.SCPT $filepath
	#"tell application "Terminal"
	#	set currentTab to do script (\"cd FDF && ./FDF \"$filepath\" input/42\")
	#	activate
	#end tell"
	#$fillit $filepath > "$mypath/their_res/$filename"
done
