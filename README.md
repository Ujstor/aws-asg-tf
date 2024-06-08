# Terraform: Up & Running Code

This repo contains my code implementation for the book *[Terraform: Up and Running](http://www.terraformupandrunning.com)* 

## Packer

To build the Amazon Machine Image (AMI):

```bash
packer build webserver.json
```

## Local k8s cluster:
[k3d](https://k3d.io/v5.6.3/usage/configfile/) is a lightweight wrapper to run [k3s](https://k3s.io/) (Rancher Lab’s minimal Kubernetes distribution) in docker.

```bash
k3d cluster create terraform \
  --servers 3 \
  --agents 3 \
  -p "80:80@loadbalancer" \
  -p "443:443@loadbalancer" \
  --k3s-node-label "type=control@server:0,1,2" \
  --k3s-node-label "type=worker@agent:0,1,2"
```

For local testing with k3d, comment out the 'loadbalancer' form in the service object.

```terraform
  spec {
    # type = "LoadBalancer"
    port {
      port        = var.ingress_port
      target_port = var.container_port
      protocol    = "TCP"
    }
    selector = local.pod_labels
  }
```

## kubectl AWS

```bash
aws eks update-kubeconfig --region <REGION> --name <EKS_CLUSTER_NAME>
```

## Dir structure

```bash
[4.0K]  ./
├── [4.0K]  global/
│   ├── [4.0K]  ghAction/
│   │   ├── [1.6K]  main.tf
│   │   ├── [ 535]  outputs.tf
│   │   ├── [ 337]  terraform.tf
│   │   ├── [ 992]  tf-apply.yml
│   │   └── [ 305]  variables.tf
│   ├── [4.0K]  iam/
│   │   ├── [1.2K]  main.tf
│   │   ├── [1.7K]  outputs.tf
│   │   ├── [ 375]  terraform.tf
│   │   └── [ 472]  variables.tf
│   └── [4.0K]  s3/
│       ├── [ 930]  main.tf
│       ├── [ 259]  outputs.tf
│       ├── [ 374]  terraform.tf
│       ├── [   0]  terraform.tfstate
│       ├── [6.7K]  terraform.tfstate.backup
│       └── [ 330]  variables.tf
├── [4.0K]  modules/
│   ├── [4.0K]  data-stores/
│   │   └── [4.0K]  mysql/
│   │       ├── [ 669]  main.tf
│   │       ├── [ 338]  outputs.tf
│   │       ├── [ 116]  terraform.tf
│   │       └── [1.3K]  variables.tf
│   └── [4.0K]  services/
│       ├── [4.0K]  eks-cluster/
│       │   ├── [ 233]  dependencies.tf
│       │   ├── [2.3K]  main.tf
│       │   ├── [ 517]  outputs.tf
│       │   ├── [ 116]  terraform.tf
│       │   └── [ 582]  variables.tf
│       ├── [4.0K]  k8s/
│       │   ├── [1.3K]  main.tf
│       │   ├── [ 368]  outputs.tf
│       │   ├── [ 129]  terraform.tf
│       │   └── [ 662]  variables.tf
│       └── [4.0K]  webserver-cluster/
│           ├── [ 348]  dependencies.tf
│           ├── [4.3K]  main.tf
│           ├── [ 395]  outputs.tf
│           ├── [ 116]  terraform.tf
│           ├── [ 168]  user-data.sh
│           └── [1.4K]  variables.tf
├── [4.0K]  packer/
│   ├── [ 576]  webserver.json
│   └── [ 724]  webserver.json.pkr.hcl
├── [4.0K]  prod/
│   ├── [4.0K]  data-stores/
│   │   └── [4.0K]  mysql/
│   │       ├── [ 524]  main.tf
│   │       ├── [ 783]  output.tf
│   │       ├── [ 669]  terraform.tf
│   │       └── [ 265]  variables.tf
│   └── [4.0K]  services/
│       ├── [4.0K]  eks-cluster/
│       │   ├── [  81]  dependencies.tf
│       │   ├── [ 528]  main.tf
│       │   ├── [ 257]  outputs.tf
│       │   └── [ 735]  terraform.tf
│       └── [4.0K]  webserver-cluster/
│           ├── [ 427]  main.tf
│           ├── [ 111]  outputs.tf
│           └── [ 497]  terraform.tf
├── [4.0K]  stage/
│   ├── [4.0K]  data-stores/
│   │   └── [4.0K]  mysql/
│   │       ├── [ 288]  main.tf
│   │       ├── [ 337]  output.tf
│   │       ├── [ 613]  terraform.tf
│   │       └── [ 266]  variables.tf
│   └── [4.0K]  services/
│       ├── [4.0K]  k8s/
│       │   ├── [ 341]  main.tf
│       │   ├── [ 127]  outputs.tf
│       │   └── [ 455]  terraform.tf
│       └── [4.0K]  webserver-cluster/
│           ├── [ 785]  main.tf
│           ├── [ 111]  outputs.tf
│           └── [ 616]  terraform.tf
├── [1.0K]  LICENSE.txt
└── [4.4K]  README.md
```

## License

This code is released under the MIT License.
