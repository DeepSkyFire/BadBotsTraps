#!/bin/bash

NEW_GZIPFILE_PATH=$(dirname $(readlink -f "$0"))
GZIPFILE_SIZE=10
GENERATE_FAST_MODE=true

while getopts "s:m:h" arg; do
      case $arg in
      h)
        echo ""
        echo ""
        echo ""
        echo "==================================================================================================================="
        echo ""
        echo "Gzip File Generate Script"
        echo ""
        echo "-s <Size>  [Example:] '-s 10'                  Size of the file you want to generate (in GB). default 10GB."
        echo "-m <Mode>  [Example:] '-m fast' '-m normal'    Generate mode, 'normal' or 'fast'. fast mode is default setting."
        echo ""
        echo "==================================================================================================================="
        echo ""
        echo ""
        echo ""
        exit 1
      ;;

      s)
      if [ -n "$OPTARG" ]; then
          case $OPTARG in

          ''|*[!0-9]*)
               echo "Invalid size parameter."
               exit 1 
          ;;

          *) 
            GZIPFILE_SIZE=$OPTARG 
          ;;
          
          esac
      fi
      ;;

      m)
      if [ -n "$OPTARG" ]; then
            case "$OPTARG" in
              "normal" )
                  GENERATE_FAST_MODE=false
              ;;

              "fast" )
                  GENERATE_FAST_MODE=true
              ;;
            esac
      fi
      ;;

      ?)
        echo "Invalid parameter. You can using '-h' to check help information."
        exit 1
      ;;
      esac
done

if [ "$GENERATE_FAST_MODE" = true ]; then

      echo "Fast Mode. Please be waitting"
      dd if=/dev/zero bs=1M count=$((1*1024)) | gzip -9 > $NEW_GZIPFILE_PATH/fast.gzip
      du -sh $NEW_GZIPFILE_PATH/fast.gzip && md5sum $NEW_GZIPFILE_PATH/fast.gzip
      touch bomb.gzip && time -p sh -c "for f in \$(seq $GZIPFILE_SIZE); do cat $NEW_GZIPFILE_PATH/fast.gzip >> $NEW_GZIPFILE_PATH/bomb.gzip; echo \"Added \$f GB\" ; done;"
      du -sh $NEW_GZIPFILE_PATH/bomb.gzip && md5sum $NEW_GZIPFILE_PATH/bomb.gzip && \
      rm -rf $NEW_GZIPFILE_PATH/fast.gzip

else
      echo "Normal Mode. Please be waitting"
      time dd if=/dev/zero bs=1M count=$(($GZIPFILE_SIZE*1024)) | gzip -9 > $NEW_GZIPFILE_PATH/bomb.gzip
      du -sh $NEW_GZIPFILE_PATH/bomb.gzip && md5sum $NEW_GZIPFILE_PATH/bomb.gzip
fi
