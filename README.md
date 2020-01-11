# Python development example using Docker and Kubernetes

This project is an example of python application development in a Kubernetes cluster which is created using vagrant and ansible in a local development environment.

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

Copy created "config" file into the "$HOME/.kube/" folder to manage provisioned K8s cluster
 ```sh
$ cp devops/ansible-playbooks/config ~/.kube/config
```

## Development and Deployment

### 1. Development
1.1. Make changes on your python application in local repository.

### 2. Build docker image
Run this command to define the private docker registry address as a env variable on your local environment
 ```sh
$ export $REGISTRY="192.168.50.10:30001"
```

2.1. Build new docker image for the developed code of application  ( run this command  in the same directory as Dockerfile )
 ```sh
$ docker build -t $REGISTRY/hello-py:0.0.1 .
```

2.2. Push the new docker image of your application to private docker registry running on the local k8s cluster
 ```sh
$ docker push $REGISTRY/hello-py:0.0.1
```

### 3. Deployment
Deploy the new version of application to K8s cluster.

3.1. If you are deploying your application for the first time, run this command
```sh
$ kubectl apply -f devops/k8s/hello-py-deployment.yaml
```

3.2. After each new development you make, you have to create a new docker image with new version tag ( by running commands in the 2.step ) and update the K8s deployment file in a way that it uses the new docker image with the following command
```sh
$ kubectl set image deployment/hello-py hello-py=127.0.0.1:30001/hello-py:0.0.2
```

3.3. Check of your deployment and pods if they are is ready
 ```sh
$ kubectl get deploy -n default

$ kubectl get pods -n default
```

3.4. Now, try to access your application via the browser using the address below
 ```sh
http://192.168.50.10:30100/
```
