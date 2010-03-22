module Whoa
  class Link
    include HappyMapper
    
    tag 'link'
    
    attribute :href, String
    attribute :rel, String
  end
end