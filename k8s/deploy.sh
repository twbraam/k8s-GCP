docker build -t twbraam/multi-client:latest -t twbraam/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t twbraam/multi-server:latest -t twbraam/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t twbraam/multi-worker:latest -t twbraam/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push twbraam/multi-client:latest
docker push twbraam/multi-server:latest
docker push twbraam/multi-worker:latest

docker push twbraam/multi-client:$SHA
docker push twbraam/multi-server:$SHA
docker push twbraam/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=twbraam/multi-client:$SHA
kubectl set image deployments/server-deployment server=twbraam/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=twbraam/multi-worker:$SHA