#! /bin/bash

function isLangFile() {
  local _bool=false
  for lang in ${langs[*]}; do
    # _bool=[ "${$1/$lang }" = "$1" ] & $_bool
    if [[ "${1/.$lang.}" != "$1" ]]; then
      _bool=true || _bool
    fi
  done
  echo $_bool
}

langs=("en" "fr")

for file in $(find $(pwd)/content -name "*.md"); do
  echo $file
  
  filename=${file##*/}
  
  bool=$(isLangFile $filename)
  if $bool; then
    echo "Skipping $filename"
    continue
  fi

  fileroot=${filename%.md}  
  dir=$(dirname $file)
  cd $dir
  pwd
  for lang in ${langs[*]}; do
    filelang="$fileroot.$lang.md"
    [ ! -f $filelang ] && cp $filename $filelang
  done
done
