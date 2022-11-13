#!/bin/bash

#parse vars with getopt. 
# NOTE: This requires GNU getopt.  On Mac OS X and FreeBSD, you have to install this
# separately; see below.
TEMP=$(getopt -o vda: --long verbose,debug,flagtakesargument:,noarguments \
              -n 'bashbasescript' -- "$@")

if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi

# Note the quotes around '$TEMP': they are essential!
eval set -- "$TEMP"

#declare variables and defaults. 
VERBOSE=false
DEBUG=false
FLAGTAKESARGUMENT=
JAVA_MISC_OPT=
while true; do
  case "$1" in
    -v | --verbose ) VERBOSE=true; shift ;;
    -d | --debug ) DEBUG=true; shift ;;
    -a | --flagtakesargument ) FLAGTAKESARGUMENT="$2"; echo "mandatory argument was supplied with $FLAGTAKESARGUMENT"; shift 2 ;;
    --noarguments)
      echo "the noarguments switch parameter was supplied"; shift 2 ;;
    -- ) shift; break ;;
    * ) break ;;
  esac
done

# -- catches long flags without anything after them and move to next.
# * catches all flags given that are not supported. 