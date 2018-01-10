#! /bin/bash

function compareMd5Files() {
  local filename="$1"
  local filepath="$2"

  echo "  Compare"
  echo "  $sourceDirectory/$filepath/$file"
  echo "  $compareDirectory/$filepath/$file" 
}

function compareMd5FilesInDirectory() {
  local currentDirectory="$1"
  local previousPath="$2"

  if [[ -z "$previousPath" ]]
  then
    local currentPath="$previousPath/$currentDirectory"
  else
    local currentPath="$currentDirectory"
  fi

  echo "Comparing files in $currentPath"
  cd "$currentDirectory"
  
  for file in *
  do
    if [ -d "$file" ] # check if the file is a directory
    then
      compareMd5FilesInDirectory "$file" "$currentDirectory" 
    else
      if [[ "$file" == *.md5 ]]
      then
        compareMd5Files "$file" "$currentPath"
      fi
    fi
  done

  cd ..
}

sourceDirectory="$1"
compareDirectory="$2"

if [ ! -d "$sourceDirectory" ]
then
  echo "First argument must be a directory"
  exit 1
fi

if [ ! -d "$compareDirectory" ]
then
  echo "Second argument must be a directory"
  exit 1
fi

cd "$sourceDirectory"
compareMd5FilesInDirectory .
 
