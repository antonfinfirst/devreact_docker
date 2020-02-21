version=$1
docker stop reactcontainer
docker rm reactcontainer
docker build . -t react
docker run -p 80:80 --name reactcontainer -itd react

sleep 5
curl -LI http://localhost:80 -o /dev/null -w '%{http_code}\n' -s

if [ $(curl -LI http://localhost:80 -o /dev/null -w '%{http_code}\n' -s) -eq 200 ]; then

    echo "deployment is successfull"

    else

    echo "deployment is not successfull"

fi

docker tag react:latest react:$version

#validation and send notification 

if curl -s --head --request GET http://localhost | grep "200 OK" > /dev/null; then

	echo "react application is UP"

	curl -X POST -H 'Content-type: application/json' --data '{"text":"react application is up"}' https://hooks.slack.com/services/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
else

	echo "react application is DOWN"

	curl -X POST -H 'Content-type: application/json' --data '{"text":"react application is DOWN"}' https://hooks.slack.com/services/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

fi

