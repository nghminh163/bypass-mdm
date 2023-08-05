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
options=("Bypass on Recovery" "Check MDM Enrollment" "Quit")
select opt in "${options[@]}"; do
	case $opt in
	"Bypass on Recovery")
		echo "Bypass on Recovery"
		if [ -d "/Volumes/Macintosh HD - Data" ]; then
   			diskutil rename "Macintosh HD - Data" "Data"
		fi
		echo "Setup account"
  		echo 'Nhap ten (Mac dinh: Macbook)'
		read realName
  		realName="${realName:=Macbook}"
    		echo "Nhap username VIET LIEN KHONG DAU (Mac dinh: macbook)"
      		read username
		username="${username:=macbook}"
  		echo 'Nhap password (mac dinh: 4 dau cach)'
    		read passw
      		passw="${passw:=    }"
		dscl_path='/Volumes/Data/private/var/db/dslocal/nodes/Default' 
		echo "Tao user"
  		# Create user
    		dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username"
      	    	dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UserShell "/bin/zsh"
	        dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" RealName "$realName"
	 	dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" RealName "$realName"
	        dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" UniqueID "501"
	        dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" PrimaryGroupID "20"
		mkdir "/Volumes/Data/Users/$username"
	        dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" NFSHomeDirectory "/Users/$username"
	        dscl -f "$dscl_path" localhost -passwd "/Local/Default/Users/$username" "$passw"
	        dscl -f "$dscl_path" localhost -append "/Local/Default/Groups/admin" GroupMembership $username
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
