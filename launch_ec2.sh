#!/bin/bash -e

source set_up.sh

# Launch an EC2 instance
aws ec2 run-instances \
    --image-id ami-0fe8bec493a81c7da \
    --count 1 \
    --instance-type t3.micro \
    --key-name devops \
    --security-group-ids sg-00b3e7fbc304ce07f \
    --subnet-id subnet-02389efc947bb6d09

