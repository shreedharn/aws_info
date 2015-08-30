require_relative 'base_info'
class RdsInfo < BaseInfo
  def print_rdsinfo
    @regions.each { |region|
      rds_client = Aws::RDS::Client.new(region: region, credentials: @credentials)
      puts "region: #{region}"
      print_rds_instance_count region, rds_client
      print_rds_snapshots_count region, rds_client
    }
  end

  private
  def print_rds_instance_count(regions, rds_client)
    describe_instances_results = rds_client.describe_db_instances.data
    instance_count = describe_instances_results.db_instances.count
    puts "\tRds Instance count: #{instance_count}"
  end

  def print_rds_snapshots_count(regions, rds_client)
    describe_snapshots_results = rds_client.describe_db_snapshots().data
    snapshots_count = describe_snapshots_results.db_snapshots.count
    puts "\tRds snapshots count: #{snapshots_count}"
  end
end