module Whoa
  class Experiment < WoObject
            
    Url = "https://www.google.com/analytics/feeds/websiteoptimizer/experiments"
    
    tag 'entry'
    element :wo_url, String, :tag => "id"
    element :updated, Time
    element :title, String
    
    with_options :namespace => "http://schemas.google.com/analytics/websiteoptimizer/2009" do |exp|
      exp.element :account_id, Integer, :tag => "analyticsAccountId"
      exp.element :control_script, String, :tag => "controlScript"
      exp.element :conversion_script, String, :tag => "conversionScript"
      exp.element :tracking_script, String, :tag => "trackingScript"
      exp.element :experiment_id, Integer, :tag => "experimentId"
      exp.element :type, String, :tag => "experimentType"
      exp.element :ab_experiment_count, Integer, :tag => "numAbPageVariations"
      exp.element :combination_count, Integer, :tag => "numCombinations"
      exp.element :status, String 
    end 
    
    has_many :links, Whoa::Link
    
    def pages
      Whoa::Feed.all_pages(experiment_id)
    end
    
    def create_page(opts)
      opts.merge!({:experiment_id => experiment_id})  
      Whoa::Page.create(opts)
    end
    
    def stop!
      update_attributes(:status => 'Finished')
    end
    
    def start!
      update_attributes(:status => 'Running')
    end
    
    def self.find(exp_id)
      Whoa::Request.get(url(exp_id)) do |response|
        return if response.code == 401 # raise like AR? I say no.
        parse(response.body)
      end  
    end
    
    def url
      str = Url
      str += "/#{experiment_id}" unless new_record?
      str
    end
    
    # TODO: remove all default account stuff
    def to_xml
      Whoa::Request.build_payload do |xml|
        xml.title title
        xml.gwo :experimentType, 'AB'
        xml.gwo :status, status
      end
    end
    
    def all
      Feed.all.experiments
    end     
    
  end
end