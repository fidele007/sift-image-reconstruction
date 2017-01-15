#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 INPUT_FILE OUTPUT_FILE" >&2
  exit 1
fi

if ! [ -e "$1" ]; then
  echo "$1 not found" >&2
  exit 1
fi

djpeg $1 | ppmtopgm | pnmnorm -bpercent=0.01 -wpercent=0.01 -maxexpand=400 | pamscale -pixels $[1024*768] > 7mp

./compute_descriptors_mac -i 7mp -o4 $2 -hesaff -sift
# ./compute_descriptors_linux64 -i 7mp -o4 $2 -hesaff -sift

rm -r 7mp
