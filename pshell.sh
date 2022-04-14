#filecontent=$(cat testfile)
FDF="/home/oskari/Projects/FDF"
mypath=$(pwd)

#timeout 1s ./FDF $mypath/$1 &>> $mypath/outputs.log
FILEPATH=$mypath/perm_$2
echo "$1" > $FILEPATH
cd $FDF
timeout 1s ./FDF $FILEPATH &> /dev/null
#./FDF $FILEPATH &> /dev/null
if [ $? -ne 0 ]; then
	echo "Exitcode: $?" >> $FILEPATH
	stupid=$(cat $FILEPATH | grep "Exitcode: 0")
	if [ stupid != "" ]; then
		rm $FILEPATH
	else
		timeout 1s ./FDF $FILEPATH &>> $FILEPATH
		mv $FILEPATH $mypath/fails/perm_$2_FAIL
	fi
else
	rm -rf $FILEPATH
fi
