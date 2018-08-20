#!/usr/bin/env bash
. ./Variables/VPC.sh

# User Variables
export TF_VAR_organization="wag"
export TF_VAR_module_name="awsinfra"
export TF_VAR_provider="aws"
export TF_VAR_profile="HomeSite"
export TF_VAR_aws_region="us-west-2"
export AWS_REGION="${TF_VAR_aws_region}"
export AWS_PROFILE="${TF_VAR_profile}"
export TF_VAR_availability_zone="us-west-2a"
export TF_VAR_ami="ami-79873901" # ubuntu 16.04 LTS (hvm:ebs)
export TF_VAR_internal_dns_main_zone_domain="${TF_VAR_module_name}.internal"
export TF_VAR_internal_subdomain="prod"
export TF_VAR_aws_key_name="${TF_VAR_module_name}"
export TF_VAR_instance_type="t2.micro"
export TF_VAR_my_ip_address="76.175.31.192"

export TF_VAR_ssh_public_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCK9HlOVUChRjlKbSJC0eLsw8nZnDkOr0FqHxpLKbEZCGXLA9QZ7mfX3l4iGJL7vpPTJDSMKuRg3gWesNx3wSx1uAH8QYSIAoikxSTM1vntXY1sHMNUlZyrCLZnSF2icn7/Lu7rd4pyEy98RawDJytJTylJ0GvdGCffWDOsIxVjww+w24zc5Pmdqg2I8k5hTiCFtxYuFoIA0UZZAyT3fXrzrOEas5H/gi9DJhV+1NbPtwPljqz42lFwlZxEYkx08IuZWQHPOv0X7tdmAyZndx/MJSfCplNIXBj2f0R2v+2zgHXN6kuuMNaV/ZMyCjyUmHMgL/b8ZTNyJfFbPnb2pjjV"
export TF_VAR_destination_ansible_hosts_file="${PWD}/../ansible/hosts/inventory"
export TF_VAR_public_subnet_cidr="10.0.0.0/24"
export TF_VAR_domain="*.domain.com" # Used for ACM
export TF_VAR_ec2_iam_instance_profile="${TF_VAR_organization}_${TF_VAR_module_name}_ec2_iam_instance_profile"
export TF_VAR_iam_role="${TF_VAR_organization}_${TF_VAR_module_name}_ec2_role"
export TF_VAR_server_name="${TF_VAR_organization} - ${TF_VAR_module_name}"

