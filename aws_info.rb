require 'aws-sdk'
require 'optparse'
require 'yaml'
require_relative 'ec2_info'
require_relative 'rds_info'


curr_path = File.expand_path(File.dirname(__FILE__))
aws_config = YAML::load_file(File.join(curr_path, 'aws_configuration.yml' ))

aws_credentials = aws_config['credentials']

credentials = Aws::Credentials.new(aws_credentials['access_key_id'], aws_credentials['secret_access_key'])

# read regions from config
regions =  aws_config['regions'] || []

#Get User info
iam_client = Aws::IAM::Client.new(region: regions[0], credentials: credentials)
user = iam_client.get_user().data.user

optparse = OptionParser.new do|opts|
  opts.on( '-e', '--ec2info', 'Output ec2 Information' ) do
    ec2_info = Ec2Info.new(regions,credentials,user)
    ec2_info.print_ec2info
  end
  opts.on( '-r', '--rdsinfo', 'Output rds Information' ) do
    rds_info = RdsInfo.new(regions,credentials,user)
    rds_info.print_rdsinfo
  end
  opts.on( '-h', '--help', 'Display this screen' ) do
    puts opts
    exit
  end
end
optparse.parse!

