require 'spec_helper'
 
describe VappFormer::Config do
  before :each do
    @config = VappFormer::Config.new('spec/test_data/environment.yml')
  end
 


  describe "Functions" do
    
    it "instantiates a config object" do
      expect(@config).to be_a VappFormer::Config
    end
    
    it "raises an error if the file does not exist" do
      expect{ VappFormer::Config.new('doesntexist.yml') }.to raise_error("File Not Found")
    
    end
    
    it "returns full config if yaml loaded succesfully" do
      expect(@config.full_config).to be_kind_of(Hash)
    end
    
    it "has an array of tiers" do
      expect(@config.tiers).to be_kind_of(Array)
    end
    
    it "has an backbone network hash" do
      expect(@config.backbone).to be_kind_of(Hash)
    end
    
    it "has a name property" do
      expect(@config.name).to eq('vapp_name')
    end
    
    it "has a vdc property" do
      expect(@config.vdc).to eq('vdc_name')
    end
    
    it "has a catalogue property" do
      expect(@config.catalogue).to eq('images')
    end
    
    it "has a template property" do
      expect(@config.template).to eq('centos_template')
    end
    
    it "has a bastion_ip property" do
      expect(@config.bastion_ip).to eq('10.0.0.11')
    end
    
    
  end

end