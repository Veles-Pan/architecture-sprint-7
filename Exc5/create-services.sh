kubectl run front-end-ap --image=nginx --labels role=front-end --expose --port 80 
kubectl run admin-front-end-ap --image=nginx --labels role=admin-front-end --expose --port 80
kubectl run back-end-ap --image=nginx --labels role=back-end-api --expose --port 80
kubectl run admin-back-end-ap --image=nginx --labels role=admin-back-end-api --expose --port 80
