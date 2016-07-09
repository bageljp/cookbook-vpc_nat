#
# Cookbook Name:: vpc_nat
# Recipe:: default
#
# Copyright 2014, bageljp
#
# All rights reserved - Do Not Redistribute
#

case node['platform_family']
when "rhel"
  service "iptables" do
    action :enable
  end

  template "/etc/sysconfig/iptables" do
    owner "root"
    group "root"
    mode 00600
    notifies :restart, "service[iptables]"
  end

  bash "sysctl apply" do
    code <<-EOC
      sysctl -p
    EOC
    action :nothing
  end

  template "/etc/sysctl.conf" do
    owner "root"
    group "root"
    mode 00644
    notifies :run, "bash[sysctl apply]"
  end
end


