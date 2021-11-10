docker build -t omarjmedina/multi-client:latest -t omarjmedina/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t omarjmedina/multi-server:latest -t omarjmedina/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t omarjmedina/multi-worker:latest -t omarjmedina/multi-worker:$SHA -f ./worker/Dockerfile ./worker

doker push omarjmedina/multi-client:latest
doker push omarjmedina/multi-server:latest
doker push omarjmedina/multi-worker:latest

doker push omarjmedina/multi-client:$SHA
doker push omarjmedina/multi-server:$SHA
doker push omarjmedina/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=omarjmedina/multi-server:$SHA
kubectl set image deployments/client-deployment client=omarjmedina/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=omarjmedina/multi-worker:$SHA
