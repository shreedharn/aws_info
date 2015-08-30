# AwsInfo

AWSInfo outputs the count of EC2, EBS, RDS and Snapshots across regions.

AWS services such as EC2, EBS, RDS and Snapshots accrue cost on usage basis. Users can use the AwsInfo Output to terminate/delete any unintented EC2, EBS, RDS or Snapshot instances.

## Command line options
 ruby aws_info.rb -h prints available command line options

## Configuration

aws_configuration.yml is a required configuration files to use the tool. You can copy aws_configuration.yml.example as aws_configuration.yml and update the credentials section with valid credentials. The Policy associated with the credential should have atleast read permissions to IAM, EC2 and RDS. 












