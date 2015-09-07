require 'yaml'

module VappFormer
  class Config
    attr_accessor :full_config, :tiers, :backbone, :name, :vdc, :catalogue, :template, :bastion_ip
    
    def initialize(filename)
   
      raise('File Not Found') unless File.exists?(filename)
      
      @full_config = YAML.load(File.open(filename))
      set_fields(fields)
      
    end
    
    
    def validate(object, type, present)      
      validate_presence(object) if present
      validate_type(object,type)
    end
    
    def validate_presence(object)
      raise ArgumentError unless object
    end
    
    def validate_type(object,type)
      raise ArgumentError unless object.class == type.class
    end
    
    def set_fields(fields)
      fields.each do |name, value|
        validate(@full_config['vapp']["#{name.to_s}"],value,true)
        instance_variable_set("@#{name.to_s}", @full_config['vapp']["#{name.to_s}"]) 
      end
    end
    
    def fields
      {
        :tiers => [],
        :backbone => {},
        :name => "",
        :vdc => "",
        :catalogue => "",
        :template => "",
        :bastion_ip => ""
      }
    end

    
  end
end