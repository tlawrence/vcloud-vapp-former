require 'securerandom'
require_relative 'utils'
require 'thread'

module Deployment
  class Pooler
    MAX_THREADS = 10
    
    def initialize(vcloud)
      
      @vcloud = vcloud
    end
    
    def populate(params,quantity)
      org = @vcloud.organizations.first
      vdc = org.vdcs.get_by_name(params['vapp']['vdc'])
      net = org.networks.get_by_name(params['vapp']['backbone']['name'])
      catalogue = org.catalogs.get_by_name(params['vapp']['catalogue'])
      image = catalogue.catalog_items.get_by_name(params['vapp']['template'])
      
      
      
      names = generate_names(quantity)
      final = {}
      
      work_q = Queue.new
      names.map {|n| work_q.push(n)}
      workers = (1..MAX_THREADS).map do
        Thread.new do
          begin
            while vm = work_q.pop(true)
              final[vm] = instantiate(vm,image,vdc)
            end
          rescue ThreadError
          end
        end
      end; "ok"
      workers.map(&:join); "ok"
      
      raise "ERROR: #{names.count} VMs Requested, #{final.count} Created" unless names.count == final.count
      
      final
      
    end
    
    def instantiate(name,image,vdc)
      
      options = {
        :vdc_id => vdc.id,
        :deploy => true,
        :powerOn => false,
      }
      puts "  Deploying Pool VM: #{name}"
      vapp_id = image.instantiate(name,options)
      raise "  Failed to Create Pool VM: #{name}" unless vapp_id
      vm = vdc.vapps.get_by_name(name).vms.first
      puts "  Completed Deployment Of Pool VM: #{name}"
      vm.href
      
    end
    
    def generate_names(quantity)
      
      names = []
      quantity.times {names.push SecureRandom.uuid}
      
      names
      
    end
  
  end
end