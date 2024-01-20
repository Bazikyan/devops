#!/bin/bash -ex

#source set_up.sh

region="eu-north-1"

# delete instances
ec2_ids=$(aws ec2 describe-instances --query "Reservations[?!(Instances[0].Tags && Instances[0].Tags[?Key=='usage' && Value=='permanent'])].Instances[*].InstanceId" --output text --region="$region")

if [ -n "$ec2_ids" ]; then
    aws ec2 terminate-instances --instance-ids $ec2_ids --region="$region"
    aws ec2 wait instance-terminated --instance-ids $ec2_ids --region="$region"
fi

# delete security groups
sg_ids=$(aws ec2 describe-security-groups --query "SecurityGroups[?!(Tags && Tags[?Key=='usage' && Value=='permanent']) && GroupName!='default'].GroupId" --region="$region" --output text)

for sg_id in $sg_ids; do
    aws ec2 delete-security-group --region="$region" --group-id="$sg_id"
done

## delete route table
#aws ec2 disassociate-route-table --association-id $(aws ec2 describe-route-tables --filters "Name=vpc-id,Values=$vpc_id" --region="$region" --query "RouteTables[?Associations[0].SubnetId!=''].Associations[0].RouteTableAssociationId" --output text) --region="$region"
#aws ec2 delete-route-table --route-table-id="$route_table_id" --region="$region"
#
## delete subnet
#aws ec2 delete-subnet --subnet-id="$subnet_id" --region="$region"
#
## detach and delete internet gateway
#aws ec2 detach-internet-gateway --vpc-id="$vpc_id" --internet-gateway-id="$igw_id" --region="$region"
#aws ec2 delete-internet-gateway --internet-gateway-id="$igw_id" --region="$region"
#
## delete VPC
#aws ec2 delete-vpc --vpc-id="$vpc_id" --region="$region"

## delete route tables
#route_table_ids=$(aws ec2 describe-route-tables --query "RouteTables[?!(Tags && Tags[?Key=='usage' && Value=='permanent'])].RouteTableId" --region="$region" --output text)
#
#for route_table_id in $route_table_ids; do
#    aws ec2 delete-route-table  --region="$region" --route-table-id="$route_table_id"
#done
