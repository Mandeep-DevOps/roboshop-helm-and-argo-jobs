aws eks update-kubeconfig --name dev-eks
argocd login argocd-dev.rdevopsb73.online --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure --grpc-web

for i in cart catalogue user payment shipping frontend ; do

  argocd app create $i --repo https://github.com/raghudevopsb77/roboshop-helm-and-argo-jobs.git --path helm --dest-namespace default --dest-server https://kubernetes.default.svc --grpc-web --values dev/$i.yaml
  argocd app sync $i

done


aws eks update-kubeconfig --name prod-eks
argocd login argocd-prod.rdevopsb73.online --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure --grpc-web

for i in cart catalogue user payment shipping frontend ; do

  argocd app create $i --repo https://github.com/raghudevopsb77/roboshop-helm-and-argo-jobs.git --path helm --dest-namespace default --dest-server https://kubernetes.default.svc --grpc-web --values prod/$i.yaml
  argocd app sync $i

done
