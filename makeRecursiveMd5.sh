#! /bin/bash

# This function generates .md5 files for all regular files in a directory.
# When it comes across a directory it calls itself on the directory, which recursively
# generates .md5 files for everything in that directory. And so on.
function makeMd5SignaturesForDirectory() {
  echo "Generating files for $1"
  cd "$1"
  
  for file in *
  do
    if [ -d "$file" ] # check if the file is a directory
    then
      makeMd5SignaturesForDirectory "$file"
    else
      if [[ "$file" != *.md5 ]] # don't create .md5 files for .md5 files
      then
        md5 -q "$file" > "${file}.md5" # generates the md5 signature for the file and writes it to <filename>.md5
      fi
    fi
  done

  cd ..
}

makeMd5SignaturesForDirectory .

