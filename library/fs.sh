#!/bin/bash
# Filename: fs.sh
# Description: Filesystem related functions

#
# Function that checks if file exist and prints corresponding messages
#
# @access public
#
# @param string $1 path to file
# @param string $2 name of the file that will be used in messages
#
# @return number 0 if file exists and 64 if not
#

function checkIfFileExist()
{
    echo "Checking if $1 file exist..."

    if test -r $2
    then
        echo "$1 file exist..."
        return 0
    else
        echo "$1 file not exist..."
        return 64
    fi
}

#
# Function that checks if file is readable and prints corresponding messages
#
# @access public
#
# @param string $1 path to file
# @param string $2 name of the file that will be used in messages
#
# @return number 0 if is readable and 64 if not
#

function checkIfFileReadable()
{
    echo "Checking if $1 file is readable..."

    if test -e $2
    then
        echo "$1 file is readable..."
        return 0
    else
        echo "$1 file is readable..."
        return 64
    fi
}

#
# Function that checks if directory exist and prints corresponding messages
#
# @access public
#
# @param string $1 path to directory
# @param string $2 name of the directory that will be used in messages
#
# @return number 0 if directory exists and 64 if not
#

function checkIfDirectoryExist()
{
    echo "Checking if $1 directory exist..."

    if test -d $2
    then
        echo "$1 directory exist..."
        return 0
    else
        echo "$1 directory not exist..."
        return 64
    fi
}

#
# Function that checks if directory is writable and prints corresponding messages
#
# @access public
#
# @param string $1 path to directory
# @param string $2 name of the directory that will be used in messages
#
# @return number 0 if directory is writable and 64 if not
#

function checkIfDirectoryIsWritable()
{
    echo "Checking if $1 directory is writable..."

    if test -w $2
    then
        echo "$1 directory is writable..."
        return 0
    else
        echo "$1 directory is not writable..."
        return 64
    fi
}

#
# Function that creates directory and prints corresponding messages
#
# @access public
#
# @param string $1 path to directory
# @param string $2 name of the directory that will be used in messages
#
# @return number 0 if directory is created successfully and 64 if not
#

function makeDirectory()
{
    echo "Trying to create $1 directory..."
    mkdir $2

    if  [ "$?" -eq 0 ]
    then
        echo "Directory $1 created...";
        return 0
   else
        echo "Cannot create $1 directory...";
        return 64
   fi
}