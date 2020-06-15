#!/bin/bash 
set -euxo pipefail

# Call from Rails root with `generate.sh APP_NAME SSL_HOST `pwd``, e.g. `generate.sh forms forms.lewagon.co `pwd`` 

name=$1
host=$2
rails_root=$3

mkdir "$rails_root"/helm
cp -R "$rails_root"/seatrain/step1-ssl/ "$rails_root"/helm

sed -i "" "s/APP_NAME/$name/g" "$rails_root"/helm/templates/ingress.yaml 
sed -i "" "s/APP_NAME/$name/g" "$rails_root"/helm/templates/_helpers.tpl 
sed -i "" "s/APP_NAME/$name/g" "$rails_root"/helm/templates/service-account.yaml
sed -i "" "s/APP_NAME/$name/g" "$rails_root"/helm/templates/service.yaml 
sed -i "" "s/SSL_HOST/$host/g" "$rails_root"/helm/values.yaml

cd "$rails_root"

rm -rf seatrain

helm dep build ./helm