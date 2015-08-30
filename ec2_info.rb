class Ec2Info
  INSTANCE_STATES =  ['pending','running', 'shutting-down', 'stopping', 'stopped']
  VOLUME_STATES =   ['creating','available','deleting','error']

  def initialize(regions, credentials, user)
    @regions = regions
    @credentials = credentials
    @user = user
  end

  def print_ec2info

    @regions.each { |region|
      ec2_client = Aws::EC2::Client.new(region: region, credentials: @credentials)
      puts "region: #{region}"
      print_instance_count region, ec2_client
      print_volume_count region, ec2_client
      print_snapshots_count region, ec2_client
    }
  end

  private
  def print_instance_count(region, ec2_client)
    describe_instances_results = ec2_client.describe_instances({filters: [{name: 'instance-state-name',values: INSTANCE_STATES}]}).data
    instance_count = describe_instances_results.reservations.count
    puts "\tEc2 Instance count: #{instance_count}"
  end
  def print_volume_count(region,ec2_client)
    describe_volume_results = ec2_client.describe_volumes({filters: [{name: 'status',values: VOLUME_STATES}]}).data
    volume_count = describe_volume_results.volumes.count
    puts "\tDetached EBS volume count: #{volume_count}"
  end
  def print_snapshots_count(region, ec2_client)
    #get the accound id from user arn arn:aws:iam::1234567890:user/test
    account_id = ((@user.arn =~ /arn:aws:iam::(\d+):*/) == 0) ? $1:nil
    describe_snapshots_results = ec2_client.describe_snapshots({owner_ids: [account_id]}).data
    snapshots_count = describe_snapshots_results.snapshots.count
    puts "\tSnapshots count: #{snapshots_count}"
  end
end
