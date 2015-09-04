require 'yaml'

module VappFormer
  class Config
    attr_accessor :full_config, :tiers, :backbone, :name, :vdc, :catalogue, :template, :bastion_ip
    
    def initialize(filename)
   
      raise('File Not Found') unless File.exists?(filename)
      
      @full_config = YAML.load(File.open(filename))
      @tiers = @full_config['vapp']['tiers']
      @backbone = @full_config['vapp']['backbone']
      @name = @full_config['vapp']['name']
      @vdc = @full_config['vapp']['vdc']
      @catalogue = @full_config['vapp']['catalogue']
      @template = @full_config['vapp']['template']
      @bastion_ip = @full_config['vapp']['bastion_ip']
    end
    

    
  end
end