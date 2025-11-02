
export MY_NAMESPACE=sn-labs-$USERNAME

docker build . -t us.icr.io/$MY_NAMESPACE/guestbook:v1
docker push us.icr.io/$MY_NAMESPACE/guestbook:v1

ibmcloud cr images


kubectl apply -f deployment.yml
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

