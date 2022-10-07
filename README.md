# mailcow-dockerized-aarch64

run mailcow on raspi4 or oracle a1

# build and run 

```
git clone 
./build.sh
cd mailcow-dockerized
./generate_config.sh
docker compose up -d 
```
# run x86 on arm 


```sh
sudo apt-get install qemu binfmt-support qemu-user-static
```

