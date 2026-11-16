# AWS Infrastructure Provisioning with Terraform Modules

Hi, I'm Bhavesh Patil. I built this project while learning how real-world AWS infrastructure is structured and automated using reusable Terraform modules. Instead of putting all resources in a single large configuration file, I organized the setup into a root module and three separate child modules.

## What I Built

Using a single `terraform apply` workflow in the Mumbai region (`ap-south-1`), this setup provisions:

- **Networking (`modules/vpc`)**: A custom VPC (`10.0.0.0/16`), a public subnet (`10.0.1.0/24`), an Internet Gateway, a public route table, and a security group allowing SSH (port 22) and HTTP (port 80) traffic.
- **Compute (`modules/ec2-instances`)**: An Amazon Linux 2023 `t3.micro` EC2 instance configured with an Apache web server (`httpd`) hosting a simple status webpage.
- **Storage (`modules/s3-bucket`)**: A private S3 bucket with versioning, AES256 server-side encryption, and public access blocks enabled.

## Project Structure

```text
terraform-modules/
├── main.tf
├── variables.tf
├── terraform.tfvars
├── locals.tf
├── data.tf
├── provider.tf
├── versions.tf
├── outputs.tf
└── modules/
    ├── vpc/
    ├── ec2-instances/
    └── s3-bucket/


## Architecture Diagram

```text
+-----------------------------------------------------------------------------------+
|                                  DEVELOPER (Bhavesh)                              |
|                             Terraform CLI + MobaXterm SSH                         |
+-----------------------------------------+-----------------------------------------+
                                          |
                                          | terraform apply
                                          v
+-----------------------------------------------------------------------------------+
|                               TERRAFORM ROOT MODULE                               |
|                (main.tf | variables.tf | terraform.tfvars | data.tf)              |
+------------------+----------------------+-----------------------+-----------------+
                   |                      |                       |
      +------------+                      |                       +------------+
      | (1) VPC Module                    | (2) EC2 Module                     | (3) S3 Module
      v                                   v                                    v
+-----------------------------------------------------------------------------------+
|                              AWS CLOUD (ap-south-1 / Mumbai)                      |
|                                                                                   |
|  +-----------------------------------------------------------------------------+  |
|  | VPC: brave-vpc (10.0.0.0/16)                                                |  |
|  |                                                                             |  |
|  |   +-----------------------------+      +--------------------------------+   |  |
|  |   | Internet Gateway: brave-igw |<---->| Route Table: brave-public-rt   |   |  |
|  |   +-----------------------------+      | (0.0.0.0/0 -> brave-igw)       |   |  |
|  |                                        +---------------+----------------+   |  |
|  |                                                        |                    |  |
|  |   +----------------------------------------------------v----------------+   |  |
|  |   | Public Subnet: brave-public-subnet (10.0.1.0/24 | ap-south-1a)      |   |  |
|  |   |                                                                     |   |  |
|  |   |   +-------------------------------------------------------------+   |   |  |
|  |   |   | Security Group: brave-sg                                    |   |   |  |
|  |   |   |  - Inbound: Port 22 (SSH) & Port 80 (HTTP)                  |   |   |  |
|  |   |   |  - Outbound: All Traffic                                    |   |   |  |
|  |   |   |                                                             |   |   |  |
|  |   |   |   +-----------------------------------------------------+   |   |   |  |
|  |   |   |   | EC2 Instance: brave (t3.micro | Amazon Linux 2023)  |   |   |   |  |
|  |   |   |   | Public IP: 13.207.188.118                           |   |   |   |  |
|  |   |   |   | Web Server: Apache (httpd) -> index.html            |   |   |   |  |
|  |   |   |   +-----------------------------------------------------+   |   |   |  |
|  |   |   +-------------------------------------------------------------+   |   |  |
|  |   +---------------------------------------------------------------------+   |  |
|  +-----------------------------------------------------------------------------+  |
|                                                                                   |
|  +-----------------------------------------------------------------------------+  |
|  | S3 Bucket: brave-terraform-demo-bhavesh-20261116                            |  |
|  | (Versioning Enabled | AES256 Encryption | Public Access Blocked)            |  |
|  +-----------------------------------------------------------------------------+  |
+-----------------------------------------------------------------------------------+
                                          ^
                                          | HTTP (Port 80) / SSH (Port 22)
                                          |
                                 End Users / Browser
                              ([http://13.207.188.118](http://13.207.188.118))
```
