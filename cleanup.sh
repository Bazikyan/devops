#!/bin/bash -ex

#source set_up.sh

region="eu-north-1"

# delete instances
ec2_ids=$(aws ec2 describe-instances --query "Reservations[?!(Instances[0].Tags && Instances[0].Tags[?Key=='usage' && Value=='permanent'])].Instances[*].InstanceId" --output text --region="$region")

if [ -n "$instance_ids" ]; then
    aws ec2 terminate-instances --instance-ids $ec2_ids --region="$region"
fi

# delete security groups
sg_ids=$(aws ec2 describe-security-groups --query "SecurityGroups[?!(Tags && Tags[?Key=='usage' && Value=='permanent']) && GroupName!='default'].GroupId" --region="$region" --output text)

for sg_id in $sg_ids; do
    aws ec2 delete-security-group --region="$region" --group-id="$sg_id"
done

# delete route tables
route_table_ids=$(aws ec2 describe-route-tables --query "RouteTables[?!(Tags && Tags[?Key=='usage' && Value=='permanent'])].RouteTableId" --region="$region" --output text)

for route_table_id in $route_table_ids; do
    aws ec2 delete-route-table  --region="$region" --route-table-id="$route_table_id"
done
