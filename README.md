# GCP-Project

### Build a docker image and upload it to your gcr:

#### -run these commands while you are in app directory:
  ```
  docker build -t gcp-python .
  ```
  ```
  docker tag gcp-python gcr.io/able-starlight-375707/gcp-python
  ```
  ```
  docker push gcr.io/able-starlight-375707/gcp-python
  ```

### Pull redis image and upload it to your gcr:
  
  ```
  docker pull redis
  ```
  ```
  docker tag redis gcr.io/able-starlight-375707/redis-gcr
  ```
  ```
  docker push gcr.io/able-starlight-375707/redis-gcr
  ```
  
  
### Create a bucket and upload yaml files to your gcr:
  ```
  gsutil mb -p able-starlight-375707 gs://k8s-yaml-files
  ```
  ```
  gsutil cp -r /home/abdelkhalek97/Desktop/GCP-Project/k8s_files gs://k8s-yaml-files
  ```
  
### Apply Terraform code :
  
  ```
  terraform init
  ```
  ```
  terraform plan
  ```
  ```
  terraform apply
  ```