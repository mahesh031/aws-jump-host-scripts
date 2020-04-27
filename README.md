# aws-jump-host-scripts
Scripts provide easy way getting access to provate EC2 instances behind Jump host server

Purpose
--------------
Most of the deployments on AWS includes public and private subnets. </br>
On public subnets, jump host server will be running
in the form of EC2 instance and are publicly accessible using pre-built trust mechanisms such as by using SSH key pairs. </br>
On private subnets, all the services will be running inside the docker containers on EC2 instance.</br>

While troubleshooting the issue, most of the times, one has to get into this machines and run few commands to check if the
containers are up or check the docker logs. Since this is mundane task, having the script which does this in an automated
way using the script would be desirable.

Hence, come up with the script which does this for us. 

Pre-requisites:
---------------
AWS Profile with valid access and secret key created under "./aws/credentials" file.</br>
SSH public key on the Jump host and private EC2 instance.</br>

Usage:
--------------
./jump-host.sh "profile-name" "ec2-public-instance-tag-value" "ec2-private-instance-tag-value" "aws-region" "command" </br>

Parameters:
--------------
"profile-name": Name of the profile stored in "aws/credentials or aws/config" file </br>
"ec2-public-instance-tag-value": Publicly accessible EC2 instance tag value </br>
"ec2-private-instance-tag-value": Private EC2 instance tag value </br>
"aws-gerion": AWS account Region </br>
"Command": COmmand to be executed such as "ls" "grep" "docker ps" etc.. </br>




