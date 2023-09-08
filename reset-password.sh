#!/bin/bash
# Bash Menu Script Example
RED='\033[0;31m'
GRN='\033[0;32m'
BLU='\033[0;34m'
NC='\033[0m'
echo ""
echo -e Reset password"
echo ""
pathSys=""
if [ -d "/Volumes/Macintosh HD - Data" ]; then
  pathSys="/Volumes/Macintosh HD - Data"
else
			pathSys="/Volumes/Data"
fi
dscl -f "${pathSys}/private/var/db/dslocal/nodes/Default" localhost -passwd /Local/Default/Users/root '    '
done
