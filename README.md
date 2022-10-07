# mailcow-dockerized-aarch64

Run mailcow on raspi4 or oracle A1 / arm64

# build and run 

```
git clone 
./build.sh
cd mailcow-dockerized
./generate_config.sh
docker compose up -d 
```
## run x86 docker on arm 

no arm binary or build failed, run via qemu 

```sh
sudo apt-get install qemu binfmt-support qemu-user-static
```
## prepare docker 
```
### install docker 

sudo curl -sSL https://get.docker.com/ | CHANNEL=stable sh
sudo systemctl enable --now docker
sudo apt update
sudo apt install docker-compose-plugin
sudo usermod -aG docker $USER


## iptables open ports 
sudo iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 25 -j ACCEPT
sudo iptables -I INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
sudo iptables-save  | sudo tee /etc/iptables/rules.v4

```


## sogo issue 

Mailcow use `sogo.nu nightly builts`, but no arm binary on sogo.nu site.   
Debian/Sid has Arm binary. so we can use it.  
id:sogo homedir is differ from sogo.nu nightly, `GNUStep Default ` and symbolic link should be fixed  

## dovoecot issue 

Mailcow use dovecot official release, but no arm binary available.   
Debian/Sid has Arm binary. so we can use it.   

## rspamd issue 

Mailcow use rspamd official release repos, but no arm binary in that repo.   
We can use Debian/Sid Instead, but some error will occure in SA_RULE(/etc/../sa_rule)   
  
` truncate -s0 data/conf/rspamd/custom/sa-rules ` for  quick-fix.

## clamd

I have not tried , yet.



