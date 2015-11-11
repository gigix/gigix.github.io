include_recipe "passenger_apache2::mod_rails"

group 'rails' do
  group_name 'rails'
  action :create
end

user 'railsapp' do
  username 'railsapp'
  action :create
end

deploy_to = '/var/rails'

directory deploy_to do
  owner "railsapp"
  group "rails"
  mode "0755"
  action :create
end

web_app 'rails_app' do
  template "rails_app.conf.erb"
  docroot "#{deploy_to}/current/public"
  server_name "ec2-122-248-212-135.ap-southeast-1.compute.amazonaws.com"
  rails_env 'production'
end

apache_site "000-default" do
  enable false
end

service "apache2" do 
  action :restart
end