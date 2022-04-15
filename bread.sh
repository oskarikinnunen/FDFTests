#filecontent=$(cat testfile)
FDF="/Users/okinnune/FDF"
mypath=$(pwd)

#timeout 1s ./FDF $mypath/$1 &>> $mypath/outputs.log
FILEPATH=$1

cd $FDF
#touch $1_output
#gtimeout --preserve-status 1s ./FDF $FILEPATH &>> $1_output
output=$(gtimeout --preserve-status 1s ./FDF $FILEPATH 2>&1)
exitcode=$?
if [ $exitcode != '0' ] && [ $exitcode != '143' ]; then
	echo "$FILEPATH non 0 exitcode" >> $mypath/fails/babel_fails
	echo $output >> $mypath/fails/babel_fails
	cat $FILEPATH >> $mypath/fails/babel_fails
	echo "ENDOFFILE exit code: '$exitcode'" >> $mypath/fails/babel_fails
fi
#rm -rf $1_output

