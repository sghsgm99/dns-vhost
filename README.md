# install apache2

ssh -i your-key.pem username@ip_address
sudo su
apt update
apt install -y apache2

# How to Enable Password Authentication in AWS ec2 Instances

1. ssh -i your-key.pem username@ip_address
2. sudo passwd ubuntu
3. sudo nano /etc/ssh/sshd_config
  Find the Line containing 'PasswordAuthentication' parameter and change its value from 'no' to 'yes'
  PasswordAuthentication yes

  If you want to set up 'root' login, find  'PermitRootLogin' parameter and change its value from 'prohibit-password' to 'yes'
  PermitRootLogin yes

  After this changes save file and exit.
4. Restart the SSH service.
  service ssh restart
