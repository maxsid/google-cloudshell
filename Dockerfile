FROM gcr.io/cloudshell-images/cloudshell:latest

RUN curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh \
    && chmod 700 get_helm.sh \ 
    && ./get_helm.sh \
    && rm ./get_helm.sh \
    && curl -L https://github.com/kubernetes/kompose/releases/download/v1.17.0/kompose-linux-amd64 -o kompose \ 
    && chmod +x kompose \ 
    && sudo mv ./kompose /usr/local/bin/kompose
# Add your content here

# To trigger a rebuild of your Cloud Shell image:

# 1. Commit your changes locally: git commit -a
# 2. Push your changes upstream: git push origin master

# This triggers a rebuild of your image hosted at https://gcr.io/sidorov-210003/mycloudshell
# You can find the Cloud Source Repository hosting this file at https://source.developers.google.com/p/sidorov-210003/r/mycloudshell