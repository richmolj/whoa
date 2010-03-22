$:.unshift File.expand_path(File.dirname(__FILE__))    

require 'net/http'
require 'net/https'   
 
require 'happymapper'    
require 'rest_client'

require 'whoa/wo_object' 
require 'whoa/link'
require 'whoa/page'
require 'whoa/experiment'
require 'whoa/authentication'  
require 'whoa/feed'
require 'whoa/request'

module Whoa
  
  class << self
    attr_accessor :email
    attr_accessor :password
    attr_accessor :account_id
  end     
  
end