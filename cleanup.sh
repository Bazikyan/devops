#!/bin/bash -ex

#source set_up.sh

region="eu-north-1"

aws ec2 terminate-instances --instance-ids --region="$region" $(aws ec2 describe-instances --query "Reservations[?!(Instances[0].Tags && Instances[0].Tags[?Key=='usage' && Value=='permanent'])].Instances[*].InstanceId" --output text --region="$region")
