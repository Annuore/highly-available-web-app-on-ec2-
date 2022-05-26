# Summary
The URL for the stack is [URL](http://nest-udagra-15yfxboq8q1e7-250910444.us-east-1.elb.amazonaws.com/) 
I have included the parameters into the stack itself for readability and because I don't know JSON :)
<br>

# Content of the file
* **Nested_Stack:** as the name implies, it contains the nested code, all required resources as a single stack.
* **Infrastructure:** it contains the infrastructure (autoscaling, load balancer, bastion host) as a seperate stack. Required resources have been imported using the `Fn::ImportValue` function.
* **Network:** it contains configuration for the network as a seperate stack. Required properties have been exported.
<br>

# About the code
This code deploys a highly avalialble dummy web app to Apache Web Server running on ec2 instance using cloudformation template. Working on this project will give you the hands-on experience to work on cloudformation.
We have four subnets in our **virtual private cloud (VPC)**, two private and two public subnets. The public subnets houses our Nat Gateway and the bastion host (which would be used to ssh into our instances in the private subnet for troubleshooting), and, the private subnets where the autoscaling group of our instances is. 

# Nested Stack Breakdown
I sectioned the nested stacks according to the function of the codes.
* **Network Stack Config**
Here, we have the VPC (`udagramVPC`), the internet gateway (`UdagramIG`) and the gateway attachment (`myvpcGWA`)
- **Public Subnet Config:** under this, we have the private and public subnets, two NAT Elastic IPs (`NAt1EIP and Nat2EIP`) that are attached to the Nat Gateways in the public subnets (`pubNAT1`, `pubNAT2`), a default public route (`DefaultPubRoute`), the default public route table (`DefaultPubRT`) and two route table associations that are in the public subnet (`pubSubRTA1` and `pubSubRTA2`) 

* **Infrastructures Stack Config Breakdown**
Here, we have the security group configurations for the auto-scaling group (`udagramSG`) and load balancer (`udagramLBSecurityGrp`), the autoscaling policy and launch configurations, role and instance profiles, load balancer , listeners and target group.
 
Also, I have included an image of my output section.