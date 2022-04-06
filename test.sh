FDFPATH=~/Projects/FDF #CHANGE THIS TO THE EVALUATEES PATH

FDF=$FDFPATH/FDF
mypath=$(pwd)


for filename in $mypath/input/*; do
	file=$(basename "$filename")
	echo "FILE FOUND UNDER INPUT $file"
	#$fillit $filename > "$mypath/their_res/$file"
done
