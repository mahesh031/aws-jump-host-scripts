#!/usr/bin/env bash
parse_git_user() {
    git config --get user.email
}

USER_NAME=$(echo $(parse_git_user) | cut -d@ -f1)

echo "git user name="${USER_NAME}

export AWS_ACCESS_KEY_ID=$(aws --profile=$1 configure get aws_access_key_id)
export AWS_SECRET_ACCESS_KEY=$(aws --profile=$1 configure get aws_secret_access_key)
export AWS_SESSION_TOKEN=$(aws --profile=$1 configure get aws_session_token)

echo "Getting public EC2 instance IP for a given cluster or instance name"
JUMP_HOST_IP_ADDR=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=*$2*" --output text --query 'Reservations[*].Instances[*].[PublicIpAddress,InstanceId,State.Name,Tags[?Key==`Name`].Value]' --region $4 | grep running | cut -f 1)
echo "Public IP="${JUMP_HOST_IP_ADDR}

echo "Getting private EC2 instance IP for a given cluster or instance name"
EC2_IP_ADDR=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=*$3*" --output text --query 'Reservations[*].Instances[*].[PrivateIpAddress,InstanceId,State.Name,Tags[?Key==`Name`].Value]' --region $4 | grep running | cut -f 1 )  
echo "Private IPs="${EC2_IP_ADDR}

IP_COUNT=$(echo "${EC2_IP_ADDR}" | wc -w | awk '{$1=$1};1')
if [ ${IP_COUNT} > 2 ];  then
    PRIVATE_IP_ADDR=$(echo $EC2_IP_ADDR | cut -d" " -f 1)
else
    PRIVATE_IP_ADDR=$EC2_IP_ADDR
fi

echo "Private IP="$PRIVATE_IP_ADDR

ssh -At ${USER_NAME}@$JUMP_HOST_IP_ADDR ssh -At $PRIVATE_IP_ADDR   "$5"