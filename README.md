# install apache2

```bash
ssh -i your-key.pem username@ip_address
sudo apt update
sudo apt install -y apache2
```

# How to Enable Password Authentication in AWS ec2 Instances

```bash
ssh -i your-key.pem username@ip_address
sudo passwd ubuntu
sudo nano /etc/ssh/sshd_config
```
Find the Line containing 'PasswordAuthentication' parameter and change its value from 'no' to 'yes'
PasswordAuthentication yes

If you want to set up 'root' login, find  'PermitRootLogin' parameter and change its value from 'prohibit-password' to 'yes'
PermitRootLogin yes

After this changes save file and exit.

Restart the SSH service.
```bash
  sudo service ssh restart
```
