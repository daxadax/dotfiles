# import photos into user specified directory
# sorted into sub-directories by date

function import_photos {
  echo 
  echo '     Photo Importer v0.1'
  echo
  read -e -p "Please enter target import directory: " -i $PWD FILEPATH
  if [ -d "$FILEPATH" ] ; then
    cd $FILEPATH
  else
    mkdir -p $FILEPATH
    cd $FILEPATH
  fi

  exiftool -r -o -d %Y_%m_%d__%H:%M:%S.%%e -directory=$FILEPATH "-FileName<CreateDate" /media/NIKON\ D40/DCIM/100NCD40/
  
  #exiftool -r -overwrite_original -all=*
}
