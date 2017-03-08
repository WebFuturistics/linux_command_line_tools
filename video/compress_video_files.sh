#!/bin/bash
# Filename: compress_video_files.sh
# Description: Seed production database with preset data
#
# Parameters:
# $1 - Path to folder that contains videos to convert
# $2 - Name of the directory which will contain converted files
#
# Codes:
# TODO: need path rewriting and testing
source "$PWD/library/fs.sh"


if checkIfDirectoryExist 'videos' $1 && checkIfDirectoryIsWritable 'videos' $1
then
    cd $1

    if ! checkIfDirectoryExist 'converted videos' $2
    then
        makeDirectory 'converted videos' $2
    fi

    for file in $(ls )
    do
        echo "Converting $file"
        $(ffmpeg -i $file -strict -2 -vcodec libx264 -crf 20 $2/$file)
    done

    exit 0
else
    exit 1
fi
