class Ec2Info
  def initialize(regions, credentials)
    @regions = regions
    @credentials = credentials
  end

  def print_ec2info
    @regions.each{ |region|
      ec2_client = Aws::EC2::Client.new(region: region, credentials: @credentials)
      print_instance_count(region, ec2_client)
    }
  end

  private
  def print_instance_count(region, ec2_client)
    describe_instances_results = ec2_client.describe_instances({filters: [{name: 'instance-state-name',values: ['pending','running', 'shutting-down', 'stopping', 'stopped']}]}).data
    instance_count = describe_instances_results.reservations.count
    puts("region: #{region}, count: #{instance_count}")
  end
end