#
# Cookbook Name:: drupal-configuration
# Attributes:: default
#
# Copyright 2014, National Theatre
#
# All rights reserved - Do Not Redistribute
# 

default['drupal']['sites'] = []
# ['modules'] = %w{}
# ['path'] = 'path/to/drupal/root'
default['drupal']['default_modules'] = %w{ block dblog field field_sql_storage field_ui file filter image list menu node number options system taxonomy text update user }
