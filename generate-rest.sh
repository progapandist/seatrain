#!/bin/bash 
set -euxo pipefail

# Call from Rails root with `generate.sh APP_NAME SSL_HOST `pwd``, e.g. `generate.sh forms forms.lewagon.co `pwd`` 

name=$1
host=$2
rails_root=$3

cp -R "$rails_root"/seatrain/step2-rest/ "$rails_root"/helm

sed -i "" "s/APP_NAME/$name/g" "$rails_root"/helm/templates/deployments/rails.yaml
sed -i "" "s/APP_NAME/$name/g" "$rails_root"/helm/templates/deployments/sidekiq.yaml 
sed -i "" "s/SSL_HOST/$host/g" "$rails_root"/helm/values.yaml
sed -i "" "s/APP_NAME/$name/g" "$rails_root"/helm/values.yaml

cd "$rails_root"

rm -rf seatrain

helm dep build ./helm