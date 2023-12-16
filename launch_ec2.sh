#!/bin/bash

# Load AWS credentials from .env file
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Install AWS CLI
sudo apt update
sudo apt install awscli -y

# Configure AWS CLI with credentials and default settings
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region eu-north-1
aws configure set default.output json

# Launch an EC2 instance
aws ec2 run-instances \
    --image-id ami-0fe8bec493a81c7da \
    --count 1 \
    --instance-type t3.micro \
    --key-name devops \
    --security-group-ids sg-00b3e7fbc304ce07f \
    --subnet-id subnet-02389efc947bb6d09

