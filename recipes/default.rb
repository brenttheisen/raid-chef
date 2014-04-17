#
# Cookbook Name:: raid
# Recipe:: default
#

return unless node.attribute?('raid')

package "mdadm"

node[:raid][:devices].each_pair do |mdadm_device_path, opts|
  if File.exists?(mdadm_device_path)
    log "Skipping #{mdadm_device_path} as it already exists"
    next
  end

  mdadm mdadm_device_path do
    devices opts[:devices]
    level opts[:level]
    chunk opts[:chunk_size] || node[:raid][:chunk_size]
    bitmap opts[:bitmap] || node[:raid][:bitmap]
    action :create
    notifies :run, "execute[set_readahead_on_device_after_creation]", :immediately
    only_if "which mdadm"
  end

  execute "set_readahead_on_device_after_creation" do
    command "blockdev --setra #{opts[:read_ahead] || node[:raid][:read_ahead]} #{mdadm_device_path}"
    action :nothing
    only_if "which blockdev"
    only_if "test -b #{mdadm_device_path}"
  end
end
