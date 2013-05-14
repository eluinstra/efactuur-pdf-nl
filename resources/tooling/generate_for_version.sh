#/bin/sh
usage="Usage : generate_for_version.sh [UBL|SETU] [VERSION]"

if [ $# -lt 2 ]
	then 
		echo $usage
		exit 0
fi

messagetype=$1
messageversion=$2

if [ "$messagetype" = "UBL" ] && [ "$messagetype" = "SETU" ]
	then
		echo $usage
		exit 0

fi

genericodeDir="$messagetype $messageversion Genericode generatie"
schematronDir="$messagetype $messageversion Schematron generatie"

if [ ! -d "$schematronDir" ]
	then
		echo "Schematron directory \"$schematronDir\" cannot be found !"
		echo $usage
		exit 0
fi

echo Generating Schematron for $messagetype $messageversion ...
cd "$schematronDir"
./generate.sh
cd ..

if [ "$messagetype" = "UBL" ]; then
	echo Check that dir $genericodeDir exists...
	if [ ! -d "$genericodeDir" ]; then
		echo "Genericode directory \"$genericodeDir\" cannot be found !"
		echo $usage
		exit 0
	fi


	echo Generating Genericode for $messagetype $messageversion ... 
	cd "$genericodeDir" 
	./generate.sh
	cd ..
fi

