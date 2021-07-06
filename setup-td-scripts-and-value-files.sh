username=$1

echo
echo Set scripts to be executable
chmod +x td/showall.sh
chmod +x td/redeploy.sh
chmod +x td/kill.sh
chmod +x td/apply-configs.sh
chmod +x td/refresh.sh

echo
echo Replacing your-name with $username in value files
sed -i "s/your-name/$username/g" td/*.yaml

echo
echo Replacing your-name with $username in showall.sh script
sed -i "s/your-name/$username/g" td/showall.sh
