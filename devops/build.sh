git clone --single-branch --branch master https://github.com/koseburak/hello-py.git

cd hello-py/app

docker build -t 192.168.50.10:30001/hello-py:0.0.1 .

docker push 192.168.50.10:30001/hello-py:0.0.1

kubectl set image deployment/hello-py hello-py=127.0.0.1:30001/hello-py:0.0.1
