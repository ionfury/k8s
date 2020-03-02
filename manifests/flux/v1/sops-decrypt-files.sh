#!/bin/bash
#
# Decrypt all files ending with the .enc suffix in the repository. 

usage()
{
  echo ""
  echo "usage: sops-decrypt-files.sh [-h] [--folder s]"
  echo ""
  echo "description: Decrypt all files ending with the .enc suffix in the repository."  
  echo ""
  echo "Where:"
  echo "  -h, --help  shows this [h]elp text"
  echo "  --folder    folder containing files to encrypt"  
}

# Main
while [ "$1" != "" ]; do
  case $1 in
    --folder )       shift
                        FOLDER=$1
                        ;;        
    -h | --help)        usage
                        exit
                        ;;
    -v | --verbose)     shift
                        echo "Verbose mode"
                        VERBOSE_MODE=1
                        ;;
    * )                 echo "Unknown option"
                        usage
                        exit 1
  esac
  shift
done

# Show all private keys
echo ""
echo "You have the following private keys in your keychain:"
gpg -K

# Show all public keys
echo ""
echo "You have the following public keys in your keychain:"
gpg -k

echo "FOLDER *$FOLDER*"
if [ -z "$FOLDER" ]; then
  #  Default to the current directory:
  echo "Defaulting."
  FOLDER=$(pwd)
fi

SOPSCMD=$(which sops)
if [ -z "$SOPSCMD" ]; then
  SOPSCMD="/utils/sops"
fi

for src_file in $(find $FOLDER -name '*.enc.*'); do
  target_file="${src_file/.enc./.dec.}"
  temp_file="$(mktemp)"
  
  echo "Decrypting file '$src_file' to '$target_file'" >&2
  $SOPSCMD --verbose --decrypt "$src_file" > "$temp_file" 
  if [ $? -eq 0 ]; then
    mv $temp_file $target_file    
  else
    exit $?
  fi
done