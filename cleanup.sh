#!/bin/bash -ex

#source set_up.sh

region="eu-north-1"

aws ec2 terminate-instances --instance-ids --region="$region" $(aws ec2 describe-instances --query "Reservations[?!(Instances[0].Tags && Instances[0].Tags[?Key=='usage' && Value=='permanent'])].Instances[*].InstanceId" --output text --region="$region")

sg_ids=$(aws ec2 describe-security-groups --query "SecurityGroups[?!(Tags && Tags[?Key=='usage' && Value=='permanent'])].GroupId" --region="$region" --output text)

for sg_id in $sg_ids; do
    aws ec2 delete-security-group --region="$region" --group-id="$sg_id"
done
