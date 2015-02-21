#!/bin/bash

## open coca database and set up lexicon, sources, and corpus tables
echo ".open coca.db
create table lexicon(wordID integer, word text, lemma text, pos text);
create table sources(textID integer, year integer, genre text, subgenre text, source text, title text);
create table corpus(textID integer, ID integer, wordID integer);" > commands.txt

sqlite3 < commands.txt

## Import lexicon table in tab-delimited format.
FILE="shared_files/lexicon/lexicon.txt"

echo "Processing $FILE..."
echo ".separator \"\t\"
.import $FILE lexicon" > commands.txt

sqlite3 coca.db < commands.txt


## Import sources table in tab-delimited format
FILE="shared_files/sources/coca-sources.txt"

echo "Processing $FILE..."
echo ".separator \"\t\"
.import $FILE source" > commands.txt

sqlite3 coca.db < commands.txt


## Import corpus table in tab-delimited format
FILES="database/db_academic_rpe/*.txt"

for f in $FILES
do
	echo "Processing $f..."
	echo ".separator \"\t\"
.import $f corpus" > commands.txt
	sqlite3 coca.db < commands.txt
done

FILES="database/db_fiction_awq/*.txt"

for f in $FILES
do
	echo "Processing $f..."
	echo ".separator \"\t\"
.import $f corpus" > commands.txt
	sqlite3 coca.db < commands.txt
done

FILES="database/db_magazine_bwq/*.txt"

for f in $FILES
do
	echo "Processing $f..."
	echo ".separator \"\t\"
.import $f corpus" > commands.txt
	sqlite3 coca.db < commands.txt
done

FILES="database/db_newspaper_lsp/*.txt"

for f in $FILES
do
	echo "Processing $f..."
	echo ".separator \"\t\"
.import $f corpus" > commands.txt
	sqlite3 coca.db < commands.txt
done

FILES="database/db_spoken_kde/*.txt"

for f in $FILES
do
	echo "Processing $f..."
	echo ".separator \"\t\"
.import $f corpus" > commands.txt
	sqlite3 coca.db < commands.txt
done