#filecontent=$(cat testfile)
FDF="/Users/okinnune/FDF"
mypath=$(pwd)

#timeout 1s ./FDF $mypath/$1 &>> $mypath/outputs.log
FILEPATH=$mypath/perm_$2
echo "$1" > $FILEPATH
cd $FDF
gtimeout 1s ./FDF $FILEPATH &> /dev/null
#./FDF $FILEPATH &> /dev/null
if [ $? -ne 0 ]; then
	echo "ENDOFFILE exit code: '$?'" >> $FILEPATH
	gtimeout 1s ./FDF $FILEPATH &>> $FILEPATH
	stupid=$(cat $FILEPATH | grep "exit code: '0'")
	echo $stupid >> stupid.log
	if [ $stupid != "" ]; then
		rm $FILEPATH
	else
		mv $FILEPATH $mypath/fails/perm_$2_FAIL
	fi
else
	rm -rf $FILEPATH
fi
