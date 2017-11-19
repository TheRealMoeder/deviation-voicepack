#!/bin/bash
for INFILE in *.zip
do
	echo "- [$INFILE](${INFILE})" >> index.md
done
echo
echo "* * *" >> index.md
echo "This page was generated at " >> index.md
echo `date` >> index.md
