# Deploy a Highly Available Webapp Using Cloudformation
This code deploys a highly avalialble dummy web app to Apache Web Server running on ec2 instance using cloudformation template. Working on this project will give you he hands-on experience to work on cloudformation.

You will find starter code for the project in this [Github repository](https://github.com/udacity/nd9991-c2-Infrastructure-as-Code-v1)
<br>

# Technology Stack
* Amazon EC2
* AWS Cloudformation
* AWS S3
* AWS IAM
* Apache
* HTML, JS, CSS
<br>
## Summary
<br>

# Content
- [**Project Scenario**](#ps)
- [**Insight**](#ins)
- [**Project Requirements**](#pr)
- [**Via-Cloudformation**](#cfn)
- [**Resources**](#res)
<br>

# Project Scenario <a id='ps'></a>
Your company is creating an Instagram clone called Udagram. Developers want to deploy a new application to the AWS infrastructure.

You have been tasked with provisioning the required infrastructure and deploying a **dummy application**, along with the necessary supporting software.This needs to be automated so that the infrastructure can be discarded as soon as the testing team finishes their tests and gathers their results.

**Optional** - To add more challenge to the project, once the project is completed, you can try deploying sample website files located in a public S3 Bucket to the Apache Web Server running on an EC2 instance. Though, it is not the part of the project rubric.

<br>

# Insight <a id='ins'></a>

**Amazon EC2:**Amazon Elastic Compute Cloud (Amazon EC2) offers the broadest and deepest compute platform, with over 500 instances and choice of the latest processor, storage, networking, operating system, and purchase model to help you best match the needs of your workload. Use cases includes
- Run cloud-native and enterprise apps
- Scale for HPC apps
- Develop for Apple platforms, etc.

**AWS Cloudformation:**AWS CloudFormation is a service that helps you model and set up your AWS resources so that you can spend less time managing those resources and more time focusing on your applications that run in AWS. You create a template that describes all the AWS resources that you want (like Amazon EC2 instances or Amazon RDS DB instances), and CloudFormation takes care of provisioning and configuring those resources for you.
<br>

# Project Requirements <a id='pr'></a>
**Server Specs**
- You'll need two vCPUs and at least 4GB of RAM, Ubuntu Opearing system (Ubuntu 18 or higher) and a launch configuration which will be used by the auto-scaling group. You need to allocate at least, 10GB of disk space. 

**Security Groups and Roles**
- The default security group for the dummy app is `HTTP Port: 80`, therefore, your servers need this inbound port open since you'll use it with the **Load Balancer** and the **Load Balancer Health Check**. You'll need unrestricted internet access for your servers.
- The load balancer should allow all public traffic `0.0.0.0/0` on `port 80` inbound. Outbound should only use `port 80` to reach the internal servers.
- You'll need to create an IAM role that allows your instances to read the S3 bucket. 
- You'll also need `SSH port 22` for access, incase you need to troubleshoot your instances.
- The [UserData](./scripts/userdata.sh) script should help you install all the required dependencies.
- The [Cloudformation](./cfn_template/nested_stack.yaml) script will set up or destroy the entire infrastructure without any manual steps, other than running the script.


# Via Cloudformation <a id='cfn'></a>
<details>
<summary> Expand to see Details </summary>

- Run `aws configure` to set up your CLI
- Deploy this [CloudFormation template](./cfn_template/nested_stack.yaml) to AWS and save the outputs asn env variables. You can use the provided [`create-stack`](./scripts/create.sh) script

  export STACK_NAME=webapp
  ```

  ```
  aws cloudformation create-stack \
  --stack-name $STACK_NAME \
  --template-body file://cloudformation/template.yaml
  ```

- Describe the stack to get the outputs (Bucket name and url, CDN ID and domain name )

  - [`describe-stacks`](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/describe-stacks.html)

  ```
  aws cloudformation describe-stacks --stack-name $STACK_NAME
  ```

  ```
  aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[].Outputs"
  ```

  ```
  export BUCKET_NAME=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[0].OutputValue" --output text)
  ```

  ```
  export CDN_ID=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[1].OutputValue" --output text)
  ```

  ```
  export BUCKET_URL=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[2].OutputValue" --output text)
  ```

  ```
  export CDN_DOMAIN=$(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[*].Outputs[3].OutputValue" --output text)
  ```

- Access the site via the cloudfromation URL under `Outputs`


- Clean Up & Delete All Resources
[`Delete-stack`](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/delete-stack.html)

  ```bash
  #empty s3 bucket
  aws s3 rm s3://$BUCKET_NAME --recursive
  ```

  ```bash
  # delete-stack
  aws cloudformation delete-stack --stack-name $STACK_NAME
  ```

</details>
<br>

# Recources <a id='res'></a>
- [Amazon EC2 resource type reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/AWS_EC2.html)
- [Amazon EC2 auto-scaling](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/AWS_AutoScaling.html)
- [Amazon Load Balancing V2 refernce](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/AWS_ElasticLoadBalancingV2.html)
- [Create an auto-scaling group using launch configuration](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-launch-configuration.html)
- [Amazon Resource Names(ARN)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
- [Create-stack](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/cloudformation/create-stack.html)