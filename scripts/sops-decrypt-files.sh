#!/bin/bash

script_dir=`dirname "$0"`
pushd "$script_dir/.." > /dev/null
for src_file in $(find . -name '*.enc.*'); do
  target_file="${src_file/.enc./.dec.}"
  temp_file="$(mktemp)"
  
  echo "Decrypting file '$src_file' to '$target_file'"
  sops --decrypt "$src_file" > "$temp_file"
  if [ $? -eq 0 ]; then
    mv $temp_file $target_file    
  else
    exit $?
  fi
done
popd > /dev/null