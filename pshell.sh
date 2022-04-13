#filecontent=$(cat testfile)
FDF="/home/oskari/FDFREPO"
mypath=$(pwd)

#timeout 1s ./FDF $mypath/$1 &>> $mypath/outputs.log
FILEPATH=$mypath/perm_$2
echo "$1" > $FILEPATH
cd $FDF
timeout 1s ./FDF $FILEPATH &> /dev/null
#./FDF $FILEPATH &> /dev/null
if [ $? -ne 0 ]; then
	timeout 1s ./FDF $FILEPATH &>> $FILEPATH
	mv $FILEPATH $mypath/fails/perm_$2_FAIL
else
	rm -rf $FILEPATH
fi
