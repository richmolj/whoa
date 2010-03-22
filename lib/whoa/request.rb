module Whoa
  class Request
    
    class << self
      
      def auth_token
        @auth_token ||= Whoa::Authentication.new.auth_token
      end
    
      def headers
        @headers ||= 
          {
            :content_type => "application/atom+xml", 
            'Authorization' => "GoogleLogin auth=#{auth_token}"
          }
      end
    
      def namespaces
        {
          :base => 'http://www.w3.org/2005/Atom',
          :gwo  => 'http://schemas.google.com/analytics/websiteoptimizer/2009',
          :app  => 'http://www.w3.org/2007/app',
          :gd   => 'http://schemas.google.com/g/2005'
        }
      end
    
      def build_xml_namespaces
        returning Hash.new do |hash|
          namespaces.each_pair do |key, value|
            hash.merge!({"xmlns#{':'+key.to_s unless key == :base}" => value})
          end
        end
      end
      
      def build_payload
        xml = Builder::XmlMarkup.new
        
        xml.entry(build_xml_namespaces) do
          yield xml   
          xml.gwo :analyticsAccountId, Whoa.account_id
        end
      end

      def send_to_wo(verb, url, payload=nil) 
        args = verb.to_s =~ /(post|put)/ ? [url, payload, headers] : [url, headers]
        RestClient.send(verb, *args) do |resp|
          yield resp
        end
      end
      
      # For http verbs
      def method_missing(id, *args, &blk)
        if id.to_s =~ /^(get|post|put|delete)/
          send_to_wo(id, *args, &blk)
        else
          super
        end
      end
      
    end   

  end
end