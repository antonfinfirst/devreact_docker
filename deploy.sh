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

