#!/usr/bin/bash
Help()
{
   # Display Help
   echo "Syntax: sudo Generate_SFTP_User.sh Username Password"
   echo "Where 'Username' and 'Password' are user defined arguments"
}
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
     \?) # incorrect option
         echo "Error: Invalid option"
         exit;;
   esac
done
# Check for 2 arguments
if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
	echo "Syntax: sudo Generate_SFTP_User.sh Username Password"
	echo "Where 'Username' and 'Password' are user defined arguments"
else
	echo "Generating user in SFTP_USERS group with the following credentials:"
	echo "Username: " $1
	echo "Password: " $2
	useradd -g SFTP_USERS -d /upload -s /sbin/nologin $1
	echo $1:$2 | chpasswd
	mkdir -p /data/$1/upload
	chown -R root:SFTP_USERS /data/$1
	chown -R $1:SFTP_USERS /data/$1/upload
fi