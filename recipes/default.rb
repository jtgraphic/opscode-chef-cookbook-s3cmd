#
# Cookbook Name:: s3cmd
# Recipe:: default
#
# Copyright 2012, jtgraphic
#
# All rights reserved - Do Not Redistribute
#

package "s3cmd"

node[:s3cmd][:users].each do |user|   
    home = user.to_s == :root.to_s ? "/root" : "/home/#{user}"

    template "s3cfg" do
        path "#{home}/.s3cfg"
        source "s3cfg.erb"
        mode 0655
    end
end
