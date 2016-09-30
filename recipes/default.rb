#
# Cookbook Name:: sabnzbd
# Recipe:: default
#

# get the image from dockerhub
docker_image node['sabnzbd']['docker_image']

# run the container
docker_container 'sabnzbd' do
  repo node['sabnzbd']['docker_image']
  tag node['sabnzbd']['image_tag']
  port "#{node['sabnzbd']['host_port']}:#{node['sabnzbd']['container_port']}"
  restart_policy 'always'
  host_name node['sabnzbd']['host_name']
  domain_name node['sabnzbd']['domain_name']
  volumes ["#{node['sabnzbd']['config_volume']}:/config", "#{node['sabnzbd']['data_volume']}:/data"]
end

# open port in firewall
firewall_rule 'sabnzbd' do
  port node['sabnzbd']['host_port']
  command :allow
end
