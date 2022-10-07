

function clone_repo(){
 cd $(dirname $0);
 if [[ ! -e mailcow-dockerized ]] ;then 
  git clone  https://github.com/mailcow/mailcow-dockerized.git
 else
   echo clean up 
   cd mailcow-dockerized
   git clean -f 
   git checkout -f 
   cd ..
  fi
}
function apply_patch(){
  src/sogo-patch.sh
  src/dovecot-patch.sh
  src/disable-v6.sh

}
function build_docker(){

  cd mailcow-dockerized 

  list=("
    acme
    clamd
    dockerapi
    netfilter
    olefy
    phpfpm
    postfix
    solr
    unbound
    watchdog
    dovecot
    sogo
  ")
  for service in $list; do
    echo $service
    docker build data/Dockerfiles/$service -t mailcow/$service:aarch64_build
  done
  for service in $list; do
    echo $service
    grep "mailcow/$service" docker-compose.yml
    sed -i -E "s|mailcow/$service:[0-9.]+|mailcow/$service:aarch64_build|" docker-compose.yml
    grep "mailcow/$service" docker-compose.yml
  done

}

function main(){

  clone_repo
  apply_patch
  build_docker 
}

main;
