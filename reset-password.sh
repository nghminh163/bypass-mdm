#!/bin/bash
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
