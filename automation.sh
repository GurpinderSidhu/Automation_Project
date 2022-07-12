#sudo su
apt-get update
apt-get install apache2
sudo systemctl start apache2
timestamp=$(date '+%d%m%Y-%H%M%S')
myname="Gurpinder"
s3_bucket="upgrad-gurpinder47"
cd /tmp
tar -cvf ${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/*.log
cd ..
sudo apt update
sudo apt install awscli
aws s3 ls
aws s3 cp /tmp/${myname}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
echo "Script is running"
#Bookeeping
cd /var/www/html/
if [ -f "inventory.html" ]
then
echo "Inventory File found"
else
   sudo touch inventory.html
   sudo chmod 777 inventory.html
   sudo echo $'Log Type\t\tTime Created\t\tType\t\tSize' > inventory.html
fi
sudo touch new.html
sudo chmod 777 new.html
sudo echo $'Log Type\t\tTime Created\t\tType\t\tSize' > new.html
aws s3 ls s3://$s3_bucket --recursive --human-readable | awk  '{printf "\n%s %s %s", $3, $4, $5} END {print ""}' | awk -F'[-. ]' '{printf "\n%s-%s\t\t%s-%s\t\t%s\t\t%s%s", $5, $6, $7, $8, $9, $1, $3} END {print ""}' >> /var/www/html/new.html
sudo rm -rf new.html
#Cron Job
cd /etc/cron.d/
if [ -f "automation" ]
then
echo "Automation File Found"
else
echo $'39 13 * * * root /root/Automation_Project/automation.sh' > automation
fi
