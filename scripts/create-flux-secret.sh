kubectl create secret generic extrakeys \
  --from-file=..\sops\flux.private.asc \
  --from-file=..\sops\flux.public.asc -n flux
