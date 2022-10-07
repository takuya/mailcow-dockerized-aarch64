# mailcow-dockerized-aarch64

run mailcow on raspi4 or oracle A1 / arm4

# build and run 

```
git clone 
./build.sh
cd mailcow-dockerized
./generate_config.sh
docker compose up -d 
```
# run x86 on arm 

Without arm binary or build failed, run via qemu 

```sh
sudo apt-get install qemu binfmt-support qemu-user-static
```

## sogo issue 

Mailcow use sogo.nu nightly builts, but no arm binary on sogo.nu site.
Debian/Sid has Arm binary. so we can use it.
id:sogo homedir is differ from sogo.nu nightly, `GNUStep Default ` and symbolic link should be fixed

## dovoecot isse 

Mailcow use dovecot official release, but no arm binary available.
Debian/Sid has Arm binary. so we can use it.

## rspamd issue 

Mailcow use rspamd official release repos, but no arm binary in that repo.
We can use Debian/Sid Instead, but some error will occure in SA_RULE(/etc/../sa_rule)

` truncate -S0 data/conf/rspamd/custom/sa-rules ` for  quick-fix.

## clamd

I have not tried , yet.



