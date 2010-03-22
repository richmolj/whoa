module Whoa
  class Feed
    include HappyMapper
  
    ListExperimentsUrl = "https://www.google.com/analytics/feeds/websiteoptimizer/experiments"
    
    tag 'feed'
    
    has_many :experiments, Whoa::Experiment
    has_many :pages, Whoa::Page
    
    def self.all
      Whoa::Request.get(ListExperimentsUrl) do |response|
        parse(response.body)
      end
    end
    
    # TODO: can probably be handled more eloquently combined with mm (extract_options!), 
    # or remove the mm altogether. 
    def self.all_pages(exp_id)
      Whoa::Request.get(experiment_pages_url(exp_id)) do |response|
        parse(response.body).pages
      end
    end
    
    def self.experiment_pages_url(exp_id)
      "#{ListExperimentsUrl}/#{exp_id}/abpagevariations"
    end
    
    def self.method_missing(id, *args, &blk) 
      if id.to_s =~ /^all_/
        assoc = id.to_s.gsub("all_","")
        return all.send(assoc) if args.first.blank?
        
        selection_statements = returning Array.new do |stmts|
          args.first.each_pair do |key, value|
            stmts << "self.#{key}.to_s == '#{value.to_s}'"
          end
        end
        
        all.send(assoc).select do |assoc|
          assoc.instance_eval selection_statements.join(" && ")
        end
      else
        super
      end
    end
    
  end
end