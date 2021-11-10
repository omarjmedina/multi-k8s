docker build -t omarjmedina/multi-client:latest -t omarjmedina/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t omarjmedina/multi-server:latest -t omarjmedina/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t omarjmedina/multi-worker:latest -t omarjmedina/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push omarjmedina/multi-client:latest
docker push omarjmedina/multi-server:latest
docker push omarjmedina/multi-worker:latest

docker push omarjmedina/multi-client:$SHA
docker push omarjmedina/multi-server:$SHA
docker push omarjmedina/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=omarjmedina/multi-server:$SHA
kubectl set image deployments/client-deployment client=omarjmedina/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=omarjmedina/multi-worker:$SHA
