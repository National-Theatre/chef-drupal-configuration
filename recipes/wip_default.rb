#
# Cookbook Name:: drupal-configuration
# Recipe:: default
#
# Copyright 2014, National Theatre
#
# All rights reserved - Do Not Redistribute
#
require 'json'

['drupal']['sites'].each do |site|
  json_list = `drush -r #{site['path']} pml --status=enabled --type=module`
  list = JSON.parse(json_list)

  module_list = site['modules'] + node['drupal']['default_modules']
  module_list = module_list.uniq

  module_list.each do |mod|
    if list.has_key?(mod)
      list.delete(mod)
    else
      execute 'enable module' do
        pwd site['path']
        command "drush en #{mod}"
      end
    end
  end

  list.each_key do |mod|
    execute 'enable module' do
      pwd site['path']
      command "drush dis #{mod}"
    end
  end
end
