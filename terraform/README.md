Instructions
---
- Install AWS CLI 
- Install Terraform
- Configure ~/.aws/credentials
- Copy envSetup.sh.template and save to `production/envSetup.sh`, then configure
  * `export TF_VAR_profile="wag"` dictates which AWS Profile to use
- Create ssh key and modify/add public key to envSetup.sh
- Copy ssl private key to `production/files/key.pem`
- Copy ssl cert to `production/files/cert.cert`
- `cd production` to environment 
- source the env shell script
  `source envSetup.sh`
- `terraform init`
- `terraform plan -out plan`
- `terraform apply plan`
- wait up 10 minutes
- visit ELB dns output to see table with instances
```
lynx `terraform output -module=app_elb dns`
lynx https://`terraform output -module=app_elb dns`
(ssl cert won't be valid since it's pointing to elb dns, press y)
```

Templates:
---
- `templates/user.data`
  - contains php/mysql setup and scripts use for cloud-init 
    - Creates /tmp/connect.php
      - Connects to DB, creates `servers` Table, inserts entry containing server_di
    - Creates /tmp/index.php
      - Script that connects to DB, loads `servers` table entries and outputs as an HTML table
      - Index.php so that it can be accessed by ELB
    - templatizes DB credentials for php scripts
    - Runs /tmp/connect.php once
    - Servers php standalone web server in /tmp directory (unsafe i know.)

Files:
---

- autoscaling_lc.tf
  - Uses modules ASG (autoscaling group) and LAUNCHCONFIGURATION
  - Set var.desired_capacity in variables.tf to update number of desired instances

- database.tf
  - Uses Module RDS
  - Has its own subnet
  - Creates single mysql instance db
  - Configures Security Group for DB allowing 3306 traffic from the SG used by app instances referenced in the launch configuration
  - Snapshot before delete is disabled for testing

- ec2.tf
  - Maintains/creates security groups for app instances

- elb.tf
  - Creates Classic ELB 
  - Creates Security group allowing port 80/443 from world and referenced by app ec2 SG
  - Associated with 

- main.tf
  - Configures provider and templates

- ssh.tf
  - Creates security group to allow SSH access from specified origins

- subnets.tf
  - Creates Database subnet
  - Creates Application subnet
  - Creates ELB subnet
  - Creates VPC Public subnet

- variables.tf
  - `my_ip_address` to create SSH SG to allow port 22 only from your ip address

- vpc.tf
  - Creates key pair for SSH access
  - Creates VPC
  - Creates IGW
  - Creates NAT Gateway
  - Creates associated network interfaces and EIP
  - Creates Route table
  - Creates Route Table Associations
  - Creates NACL
- iam.tf
  - Creates IAM Role for app
  - Creates IAM instance profile for ec2 autoscaled instances
  - Creates/uploads key/cert for use by ELB

Possible Improvements
---
- Fix naming conventions
- Use APP LB instead of Classic LB
- Not use /tmp directory for scripts
- Use KMS for RDS traffic
- Not hardcode DB Credentials, maybe set as ENV Variable or use vault
- Use IAM for RDS authentication (though this limits number of connections to RDS and would remove the need to use templates for userdata)
- Disable direct SSH access to EC2 (implemented for testing)

