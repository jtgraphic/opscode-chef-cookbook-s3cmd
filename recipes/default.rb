#
# Cookbook Name:: s3cmd
# Recipe:: default
#
# Copyright 2012, jtgraphic
#
# All rights reserved - Do Not Redistribute
#

package "s3cmd"

if node[:s3cmd][:data_bag]

    data = data_bag_item(node[:s3cmd][:data_bag], node[:s3cmd][:data_bag_item])

    if node[:s3cmd][:aws_access_key]
        data[:aws_access_key] = data[node[:s3cmd][:aws_access_key]]
    end
    if node[:s3cmd][:aws_secret_key]
        data[:aws_secret_key] = data[node[:s3cmd][:aws_secret_key]]
    end

else
    data = node[:s3cmd]
end

node[:s3cmd][:users].each do |user|   
    home = user.to_s == :root.to_s ? "/root" : "/home/#{user}"

    template "s3cfg" do
        path "#{home}/.s3cfg"
        source "s3cfg.erb"
        mode 0655
        variables :credentials => data
    end
end
