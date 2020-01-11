# Python development example using the Docker and Kubernetes

This project is an example of python application development in a cluster of kubernetes created using vagrant and ansible in a local development environment.

## Installation
  * [Docker](https://docs.docker.com/install/) - for install Docker Desktop
  * [Virtualbox](https://www.virtualbox.org/wiki/Downloads) - for install Virtualbox
  * [Vagrant](https://www.vagrantup.com/docs/installation/) - for install Vagrant
  * [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) - for install kubectl client

## Preparing environment
Clone the git repository and install the K8s cluster using vagrant on local environment.

Run this command to clone the git repo of project
```sh
$ git clone https://github.com/koseburak/hello-py.git
```

Run this command to install local environment in the same directory as Vagrantfile
```sh
$ vagrant up
```

Copy the kube config file inside the .kube/ directory of under your local user directory after the above command completed the successfully. ( You need this for manage your k8s cluster from the client side )
 ```sh
$ cp ../devops/ansible-playbooks/config ~/.kube/config
```

## Development and Deployment

### 1. Development
1.1. Develop the new changes on your application in your local repository

### 2. Build docker image
2.1. Build the new docker image of application after the completed the development. ( run this command  in the same directory as Dockerfile )
 ```sh
$ docker build -t 192.168.50.10:30001/hello-py:0.0.1 .
```

2.2. Push the new docker image of your application to private docker registry running on the local k8s cluster.
 ```sh
$ docker push 192.168.50.10:30001/hello-py:0.0.1
```

### 3. Deployment
Deploy the new version of application to k8s cluster running on your local environment.

3.1. If you are deploying your application the first time run this command;
```sh
$ kubectl apply -f ../devops/k8s/hello-py-deployment.yaml
```

3.2. If you want to re-deploy your application after the completed your new changes on your application run this command; ( you have to run the again 2. steps with the new  version tag before the run this command  )
```sh
$ kubectl set image deployment/hello-py hello-py=127.0.0.1:30001/hello-py:0.0.2
```
3.3. Check the status of your deployment and pods is ready.
 ```sh
$ kubectl get deploy -n default
```
 ```sh
$ kubectl get pods -n default
```
3.4. Now, try to access your application via the browser using the address below.
 ```sh
http://192.168.50.10:30100/
```
