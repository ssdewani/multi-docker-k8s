docker build -t salimdewani/multi-client:latest -t salimdewani/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t salimdewani/multi-server:latest -t salimdewani/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t salimdewani/multi-worker:latest -t salimdewani/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push salimdewani/multi-client:latest 
docker push salimdewani/multi-server:latest
docker push salimdewani/multi-worker:latest

docker push salimdewani/multi-client:$SHA 
docker push salimdewani/multi-server:$SHA
docker push salimdewani/multi-worker:$SHA

kubectl apply -f k8s

docker set image deployments/client-deployment client=salimdewani/multi-client:$SHA
docker set image deployments/server-deployment server=salimdewani/multi-server:$SHA
docker set image deployments/worker-deployment worker=salimdewani/multi-worker:$SHA