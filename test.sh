# if [ -d "/Volumes/Macintosh HD - Data" ]
# then
#     ls /Volumes/Macintosh\ HD\ -\ Data/
#     echo "Directory /path/to/dir exists."
# else
#     echo "Error: Directory /path/to/dir does not exists."
# fi

# /Volumes/Macintosh HD/etc/hosts
# /Volumes/Macintosh HD/var/db/ConfigurationProfiles/Settings
# cd /Volumes/Macintosh\ HD/private/

#!/bin/bash
# Bash Menu Script Example
RED='\033[0;31m'
GRN='\033[0;32m'
BLU='\033[0;34m'
NC='\033[0m'
echo ""
echo -e "Auto Tools for MacOS"
echo ""
PS3='Please enter your choice: '
options=("Bypass on Recovery" "Bypass Setup" "Check MDM Enrollment" "Quit")
select opt in "${options[@]}"; do
	case $opt in
	"Bypass on Recovery")
		echo "Bypass on Recovery"
		pathSys=""
		if [ -d "/Volumes/Macintosh HD - Data" ]; then
			pathSys="/Volumes/Macintosh\ HD\ -\ Data"
		else
			pathSys="/Volumes/Data"
		fi
		echo "Setup root account"
  		dscl -f ${pathSys}/private/var/db/dslocal/nodes/Default localhost -passwd /Local/Default/Users/root '    '
		echo "Block host"
		echo "0.0.0.0 deviceenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
		echo "0.0.0.0 mdmenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
		echo "0.0.0.0 iprofiles.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
		echo "Remove config profile"
		rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
		rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
		touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
		touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound
		echo "----------------------"
		break
		;;
	"Bypass Setup")
		echo "Bypass Setup"
		su
		echo -e "${RED}Please Insert Your Password To Proceed${NC}"
		echo ""
  		sudo touch /private/var/db/.AppleSetupDone
    		sudo dsenableroot -d -u root
		break
		;;
	"Check MDM Enrollment")
		echo ""
		echo -e "${GRN}Check MDM Enrollment. Error is success${NC}"
		echo ""
		echo -e "${RED}Please Insert Your Password To Proceed${NC}"
		echo ""
		sudo profiles show -type enrollment
		break
		;;
	"Quit")
		break
		;;
	*) echo "Invalid option $REPLY" ;;
	esac
done
