#!/bin/bash

##############################################################################
# Author: Abhinav Pratap
# Version: v0.0.1
#
# Description:
# This script automates the process of listing all resources within an AWS account.
# It supports multiple AWS services and prompts the user to specify a region
# and a service for which resources need to be listed.
#
# Supported AWS Services:
# - EC2
# - RDS
# - S3
# - CloudFront
# - VPC
# - IAM
# - Route 53
# - CloudWatch
# - CloudFormation
# - Lambda
# - SNS
# - SQS
# - DynamoDB
# - EBS
#
# Usage:
# ./aws_resource_list.sh <aws_region> <aws_service>
#
# Example:
# ./aws_resource_list.sh us-east-1 ec2
##############################################################################

# Check if the correct number of arguments is provided
if [ $# -ne 2 ]; then 
   echo "Usage: ./aws_resource_list.sh <aws_region> <aws_service>"
   echo "Example: ./aws_resource_list.sh us-east-1 ec2"
   exit 1
fi

# Assigning arguments to variables (no spaces around '=')
aws_region=$1
aws_service=$2

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
   echo "AWS CLI is not installed. Please install the AWS CLI and try again."
   exit 1
fi 

# Check if AWS CLI is configured
if [ ! -d ~/.aws ]; then 
   echo "AWS CLI is not configured. Please configure the AWS CLI and try again."
   exit 1
fi 

# Listing resources based on the provided service
case $aws_service in
    ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region
        ;;
    rds)
        echo "Listing RDS Instances in $aws_region"
        aws rds describe-db-instances --region $aws_region
        ;;
    s3)
        echo "Listing S3 Buckets in $aws_region"
        aws s3api list-buckets --region $aws_region
        ;;
    cloudfront)
        echo "Listing CloudFront Distributions in $aws_region"
        aws cloudfront list-distributions --region $aws_region
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    iam)
        echo "Listing IAM Users in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    route53)
        echo "Listing Route53 Hosted Zones in $aws_region"
        aws route53 list-hosted-zones --region $aws_region
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $aws_region"
        aws cloudformation describe-stacks --region $aws_region
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        echo "Listing SNS Topics in $aws_region"
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        echo "Listing SQS Queues in $aws_region"
        aws sqs list-queues --region $aws_region
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $aws_region"
        aws dynamodb list-tables --region $aws_region
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
        ;;
    *)
        echo -e "Invalid service. Please enter a valid service from the list below:\n\
----------------------------------\n\
Supported AWS Services:\n\
----------------------------------\n\
- EC2\n\
- RDS\n\
- S3\n\
- CloudFront\n\
- VPC\n\
- IAM\n\
- Route 53\n\
- CloudWatch\n\
- CloudFormation\n\
- Lambda\n\
- SNS\n\
- SQS\n\
- DynamoDB\n\
- EBS\n\
----------------------------------"
       exit 1
       ;;
esac

