#!/bin/bash
RED='\033[0;31m'
GRN='\033[0;32m'
BLU='\033[0;34m'
NC='\033[0m'
echo ""
echo -e "Auto Tools for MacOS"
echo ""
PS3='Please enter your choice: '
options=("Bypass on Recovery" "Disable Notification (SIP)" "Disable Notification (Recovery)" "Check MDM Enrollment" "Thoát")
select opt in "${options[@]}"; do
	case $opt in
	"Bypass on Recovery")
		echo -e "${GRN}Bypass on Recovery"
		if [ -d "/Volumes/Macintosh HD - Data" ]; then
   			diskutil rename "Macintosh HD - Data" "Data"
		fi
		echo -e "${GRN}Tạo người dùng mới"
        echo -e "${BLU}Nhấn Enter để chuyển bước tiếp theo, có thể không điền sẽ tự động nhận giá trị mặc định"
  		echo -e "Nhập tên người dùng (Mặc định: Macbook), có thể có dấu cách"
		read realName
  		realName="${realName:=Macbook}"
    	echo -e "${BLUE}Nhận username ${RED}VIẾT LIỀN KHÔNG DẤU ${GRN} (Mặc định: macbook)"
      	read username
		username="${username:=macbook}"
  		echo -e "${BLUE}Nhập mật khẩu (mặc định: 4 dấu cách)"
    	read passw
      	passw="${passw:=    }"
		dscl_path='/Volumes/Data/private/var/db/dslocal/nodes/Default' 
        echo -e "${GREEN}Đang tạo user"
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
     dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" dsAttrTypeNative:_writers_AvatarRepresentation $username
     dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" dsAttrTypeNative:_writers_hint $username
     dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" dsAttrTypeNative:_writers_inputSources $username
     dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" dsAttrTypeNative:_writers_jpegphoto $username
     dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" dsAttrTypeNative:_writers_passwd $username
     dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" dsAttrTypeNative:_writers_picture $username
     dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" dsAttrTypeNative:_writers_unlockOptions $username
     dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" dsAttrTypeNative:_writers_UserCertificate $username
     dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" dsAttrTypeNative:unlockOptions 0
     dscl -f "$dscl_path" localhost -delete "/Local/Default/Users/$username" JPEGPhoto
     # dscl -f "$dscl_path" localhost -create "/Local/Default/Users/$username" Picture dsAttrTypeNative:unlockOptions 0


		echo "0.0.0.0 deviceenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
		echo "0.0.0.0 mdmenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
		echo "0.0.0.0 iprofiles.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
        echo -e "${GREEN}Chặn host thành công"
		# echo "Remove config profile"
  		touch /Volumes/Data/private/var/db/.AppleSetupDone
		echo "----------------------"
		break
		;;
    "Disable Notification (SIP)")
    	echo -e "${RED}Please Insert Your Password To Proceed${NC}"
        sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
        sudo rm /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
        sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
        sudo touch /var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound
        break
        ;;
    "Disable Notification (Recovery)")
        rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
		rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
		touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
		touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound

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
