echo "" > html/scripts.js
for i in $( ls html/*.coffee ); do
	echo "" >> html/scripts.js
	echo "// $i" >> html/scripts.js
	cat $i | coffee -scb >> html/scripts.js
done