module Whoa
  class Authentication
    class AuthError < StandardError;end
    
    Url = 'https://www.google.com/accounts/ClientLogin' 

    def parameters
      {
        'Email'       => Whoa.email,
        'Passwd'      => Whoa.password,
        'accountType' => 'GOOGLE',
        'service'     => 'analytics',
        'source'      => 'whoa-001'
      }
    end

    def send_request
      RestClient.post(Url, parameters) do |response|
        raise AuthError unless response.code == 200 
        response.return!
      end
    end

    def auth_token
      send_request.body.match(/^Auth=(.*)$/)[1]
    end
    
  end
end