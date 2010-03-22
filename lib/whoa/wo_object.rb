module Whoa
  class WoObject
    attr_accessor :new_record
    
    def self.inherited(subclass)
      subclass.send :include, HappyMapper
    end
    
    # TODO: hack. should add some protection so wo_url can't be set manually
    # Or some other new record magic.
    def initialize(opts={})   
      self.new_record = true
      merge_attributes(opts)
    end
    
    def merge_attributes(opts)
      opts.each_pair do |key, value|
        self.send("#{key}=", value)
      end
      self             
    end
    alias_method :attributes=, :merge_attributes
    
    # e.g. Whoa::Feed.all_experiments
    def self.all(opts={})
      Whoa::Feed.send("all_#{name.split("::").last.downcase.pluralize}", opts)
    end
    
    def self.first(opts={})
      all(opts).last
    end
    
    def self.last(opts={})
      all(opts).last
    end
    
    def self.create(opts={})
      obj = new(opts)   
      obj.new_record = true
      obj.save
    end
    
    def update_attributes(opts={})
      merge_attributes(opts)
      save 
    end
    
    def copy!
      self.new_record = true 
      self.wo_url = nil
      save
    end
    
    def save
      verb = new_record? ? :post : :put     
      Whoa::Request.send(verb, url, to_xml) do |response|      
        self.new_record = false
        obj = self.class.handle_response(response)
        merge_attributes(obj.attributes)
      end
    end
    
    def destroy
      Whoa::Request.delete(url, to_xml) do |resp|
        resp.code == 200 ? true : false
      end
    end
    
    # Returns a hash of all the attributes with their names as keys and the values of the attributes as values.
    def attributes
      self.instance_variable_names.inject({}) do |attrs, name|
        attrs[name.gsub("@","")] = instance_variable_get(name)
        attrs
      end
    end

    # TODO: hacky
    def new_record?
      self.new_record && wo_url.nil?
    end
    
    def self.handle_response(response)
      if response.code.to_s !~ /^(200|201)/ 
        raise "Not a valid response from WO, was #{CGI.unescapedHTML(response.body)}"
      else
        parse(response.body)
      end
    end
    
  end
end