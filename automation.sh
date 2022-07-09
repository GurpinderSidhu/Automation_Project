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
