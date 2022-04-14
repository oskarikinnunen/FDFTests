#filecontent=$(cat testfile)
FDF="/home/oskari/FDFREPO"
mypath=$(pwd)

#timeout 1s ./FDF $mypath/$1 &>> $mypath/outputs.log
FILEPATH=$mypath/perm_$2
echo "$1" > $FILEPATH
echo "$1" > $mypath/babel/m3_$2
cd $FDF
timeout 1s ./FDF $FILEPATH &>> /dev/null
#./FDF $FILEPATH &> /dev/null
if [ $? -ne 0 ]; then
	echo "Exitcode: $?" >> $FILEPATH
	stupid=$(cat $FILEPATH | grep "Exitcode: 0")
	if [ stupid != "" ]; then
		rm $FILEPATH
	else
		mv $FILEPATH $mypath/fails/perm_$2_FAIL
	fi
else
	rm -rf $FILEPATH
fi
