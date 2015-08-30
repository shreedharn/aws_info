require 'aws-sdk'
require 'yaml'
require_relative 'ec2_info'


curr_path = File.expand_path(File.dirname(__FILE__))
aws_config = YAML::load_file(File.join(curr_path, 'aws_configuration.yml' ))

aws_credentials = aws_config['credentials']

credentials = Aws::Credentials.new(aws_credentials['access_key_id'], aws_credentials['secret_access_key'])

# READ the config files from a
regions =  aws_config['regions'] || []

ec2_info = Ec2Info.new(regions,credentials)
ec2_info.print_ec2info
