#!/usr/bin/env bash
# User Variables
export TF_VAR_organization="wag"
export TF_VAR_module_name="awsinfra"
export TF_VAR_provider="aws"
export TF_VAR_profile="wag"
export TF_VAR_aws_region="us-west-2"
export AWS_REGION="${TF_VAR_aws_region}"
export AWS_PROFILE="${TF_VAR_profile}"
export TF_VAR_availability_zone="us-west-2a"
export TF_VAR_ami="ami-79873901" # ubuntu 16.04 LTS (hvm:ebs)
export TF_VAR_internal_dns_main_zone_domain="${TF_VAR_module_name}.internal"
export TF_VAR_internal_subdomain="prod"
export TF_VAR_aws_key_name="${TF_VAR_module_name}"
export TF_VAR_instance_type="t2.micro"
export TF_VAR_my_ip_address="`curl ifconfig.me`"
export TF_VAR_ssh_public_key="ssh-rsa AAA"
export TF_VAR_public_subnet_cidr="10.20.0.0/24"
export TF_VAR_domain="*.domain.com" # Used for ACM
export TF_VAR_ec2_iam_instance_profile="${TF_VAR_organization}_${TF_VAR_module_name}_ec2_iam_instance_profile"
export TF_VAR_iam_role="${TF_VAR_organization}_${TF_VAR_module_name}_ec2_role"
export TF_VAR_server_name="${TF_VAR_organization} - ${TF_VAR_module_name}"
export TF_VAR_vpc_name="Wag_Test_VPC"
export TF_VAR_vpc_cidr="10.20.0.0/16"
