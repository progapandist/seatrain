#!/bin/bash 
set -euxo pipefail

# Call from Rails root with `generate.sh APP_NAME SSL_HOST `pwd``, e.g. `generate.sh forms forms.lewagon.co `pwd`` 

name=$1
host=$2
rails_root=$3

sed -i "" "s/APP_NAME/$name/g" $rails_root/seatrain/step1-ssl/templates/ingress.yaml 
sed -i "" "s/APP_NAME/$name/g" $rails_root/seatrain/step1-ssl/templates/_helpers.tpl 
sed -i "" "s/SSL_HOST/$host/g" $rails_root/seatrain/step1-ssl/values.yaml

mkdir $rails_root/helm
mv $rails_root/seatrain/step1-ssl $rails_root/helm
cd $rails_root

rm -rf seatrain

helm dep build /helm