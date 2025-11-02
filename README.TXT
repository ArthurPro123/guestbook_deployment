
---------------------------
   Guestbook Application   
---------------------------

Welcome to the Guestbook Application! This is a simple web application
built with Go that allows users to leave messages in a guestbook. The
application is containerized using Docker and deployed on Kubernetes,
with Redis used for caching.


Features
--------

- **Leave Messages**: Users can leave messages in the guestbook.

- **View Messages**: Users can view all the messages left in the
	guestbook.

- **Scalable**: The application is designed to be scalable and can
	handle multiple users simultaneously.

- **Containerized**: The application is containerized using Docker,
	making it easy to deploy and manage.

- **Kubernetes Deployment**: The application is deployed on
	Kubernetes, ensuring high availability and scalability.

- **Redis Caching**: Redis is used for caching to improve performance.



How to Run It   
-------------

```sh

export MY_NAMESPACE=sn-labs-$USERNAME

# Build and push the Docker image:
docker build . -t us.icr.io/$MY_NAMESPACE/guestbook:v1
docker push us.icr.io/$MY_NAMESPACE/guestbook:v1

ibmcloud cr images

# Apply Redis deployment and service manifests:
kubectl apply -f 'k8s/redis/*.yaml' # Optional, to add persistence.

# Apply the base deployment manifest:
kubectl apply -f k8s/base/deployment.yaml

# Port-forward the guestbook deployment to access it locally:
kubectl port-forward deployment.apps/guestbook 3000:3000


# ... Launch Appliication -> port 3000 ...

kubectl run -i --tty load-generator \
  --rm \
  --image=busybox:1.36.0 \
  --restart=Never \
  -- /bin/sh -c "\
    while sleep 0.01; do \
      wget -q -O- https://arthurssl-3000.theiaopenshiftnext-0-labs-prod-theiaopenshift-4-tor01.proxy.cognitiveclass.ai/; \
    done\
  "

```
