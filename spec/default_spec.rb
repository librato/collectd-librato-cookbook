require 'chefspec'

describe 'collectd-librato::default' do
  let(:chef_run) do
    Chef::Recipe.any_instance.stub(:include_recipe)
    runner = ChefSpec::ChefRunner.new do |node|
      node.set[:collectd_librato][:api_token] = 'api_token'
      node.set[:collectd_librato][:email] = 'email'
    end
    runner.converge 'collectd-librato::default'
  end

  it 'creates directory' do
    expect(chef_run).to create_directory '/opt/src'
  end

  it 'get repository with git' do
    pending 'No method to check git resource'
  end

  it 'run make install command' do
    expect(chef_run).to execute_command('make install').with(
      :cwd => "/opt/src/collectd-librato-#{chef_run.node[:collectd_librato][:version]}",
      :creates => "/opt/collectd-librato-#{chef_run.node[:collectd_librato][:version]}"
    )
  end

  describe "create collectd plugin file" do
    let(:chef_run) {
      Chef::Recipe.any_instance.stub(:include_recipe)
      runner = ChefSpec::ChefRunner.new(:step_into => ['collectd_plugin']) do |node|
        node.set[:collectd_librato][:api_token] = 'api_token'
        node.set[:collectd_librato][:email] = 'email'
      end
      runner.converge 'collectd-librato::default'
    }

    it 'create collectd-librato.conf file' do
      expect(chef_run).to create_file "#{chef_run.node['collectd']['plugconf_dir']}/collectd-librato.conf"
    end

    it 'create collectd-librato.conf file with content' do
      pending "No method to check template resource contents"
    end
  end

  describe "check errors" do
    let(:chef_run) {
      Chef::Recipe.any_instance.stub(:include_recipe)
      ChefSpec::ChefRunner.new(:log_level => :info).converge 'collectd-librato::default'
    }
    it 'log errors' do
      expect(chef_run).to log 'The node[:collectd_librato][:api_token] attribute has not been set.  The collectd_librato plugin will not work correctly.'
      expect(chef_run).to log 'The node[:collectd_librato][:email] attribute has not been set.  The collectd_librato plugin will not work correctly.'
    end
  end
end
