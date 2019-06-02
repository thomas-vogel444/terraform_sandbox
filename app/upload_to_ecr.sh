$(aws ecr get-login --no-include-email --region eu-west-1 --profile personal)
docker build -t upscan_app .
docker tag upscan_app:latest 773209191623.dkr.ecr.eu-west-1.amazonaws.com/upscan_app:latest
docker push 773209191623.dkr.ecr.eu-west-1.amazonaws.com/upscan_app:latest