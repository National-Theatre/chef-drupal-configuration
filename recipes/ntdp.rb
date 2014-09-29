#
# Cookbook Name:: drupal-configuration
# Recipe:: NTDP
#
# Copyright 2014, National Theatre
#
# All rights reserved - Do Not Redistribute
#

require 'json'
json_list = `drush -r /media/ephemeral0/website/drupal pml --status=enabled --type=module`
list = JSON.parse(json_list)

module_list = node['drupal']['ntdp_alpha']['modules'] + node['drupal']['default_modules']
module_list = module_list.uniq

module_list.each do |mod|
  if list.has_key?(mod)
    list.delete(mod)
  else
    execute 'enable module' do
      pwd node['drupal']['ntdp_alpha']['path']
      command "drush en #{mod}"
    end
  end
end

list.each_key do |mod|
  execute 'enable module' do
    pwd node['drupal']['ntdp_alpha']['path']
    command "drush dis #{mod}"
  end
end
