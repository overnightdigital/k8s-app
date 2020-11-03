SHA=$(git rev-parse HEAD)
docker build -t amilinko/client:latest -t amilinko/client:$SHA -f ./client/Dockerfile ./client
docker build -t amilinko/server:latest -t amilinko/server:$SHA -f ./server/Dockerfile ./server
docker build -t amilinko/worker:latest -t amilinko/worker:$SHA -f ./worker/Dockerfile ./worker

docker push amilinko/client:latest
docker push amilinko/server:latest
docker push amilinko/worker:latest

docker push amilinko/client:$SHA
docker push amilinko/server:$SHA
docker push amilinko/worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=amilinko/client:$SHA
kubectl set image deployments/server-deployment server=amilinko/server:$SHA
kubectl set image deployments/worker-deployment worker=amilinko/worker:$SHA