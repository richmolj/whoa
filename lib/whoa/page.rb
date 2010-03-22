module Whoa
  class Page < WoObject
    
    tag 'entry'
    element :wo_url, String, :tag => 'id'
    element :updated, Time
    element :edited, Time, :namespace => 'http://www.w3.org/2007/app'   
    element :title, String
    element :content, String 
    element :variation_id, String, :tag => 'abPageVariationId', :namespace => 'http://schemas.google.com/analytics/websiteoptimizer/2009' 
    
    has_many :links, Whoa::Link 
    
    def experiment_id
      @experiment_id ||= (wo_url.to_s.split("experiments/")[1].split("/")[0].to_i if wo_url)
    end
    
    def experiment_id=(val)
      @experiment_id = val
    end
    
    def url
      str = "https://www.google.com/analytics/feeds/websiteoptimizer/experiments/#{experiment_id}/abpagevariations"   
      str += "/#{variation_id}" unless new_record?
      str
    end
    
    def to_xml
      Whoa::Request.build_payload do |xml|
        xml.title title
        xml.content content
      end
    end
    
  end
end