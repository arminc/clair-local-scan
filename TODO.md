- Run dit thuis en kijk hoe lang het duurt om klaar te zijn
- Configureer travis om dit te bouwen
- Configureer travis om image te pushen naar docker hub
- Configureer travis om elke dag te bouwen: https://docs.travis-ci.com/user/cron-jobs/

- Hoe werkt het scanen van een image?
- Hoe kan je omgaan met white listing?

drun -p 6060-6061:6060-6061 -v /Users/armin/projects/armin/clair/clair_config:/config quay.io/coreos/clair:v2.0.0-rc.0 -config=/config/config.yaml

drun -e POSTGRES_PASSWORD=password postgres:9.6.2

