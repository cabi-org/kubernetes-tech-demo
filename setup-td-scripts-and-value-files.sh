username=$1

echo
echo Set scripts to be executable
chmod +x td/showall.sh
chmod +x td/redeploy.sh
chmod +x td/kill.sh
chmod +x td/apply-configs.sh
chmod +x td/refresh.sh
chmod +x td/nrp.sh
chmod +x td/active-pod-count.sh
chmod +x td/bashpod.sh
chmod +x td/wp-sftp.sh
chmod +x td/db-creds.sh
chmod +x td/activate.sh

echo
echo Replacing your-name with $username in value files
sed -i "s/your-name/$username/g" td/*.yaml

echo
echo Replacing your-name with $username in showall.sh script
sed -i "s/your-name/$username/g" td/showall.sh

echo
echo Replacing your-name with $username in refresh.sh script
sed -i "s/your-name/$username/g" td/refresh.sh
