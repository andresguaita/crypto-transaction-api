class AuthenticationService
    def initialize(email, password)
      @user = User.find_by(email: email)
      @password = password
    end
  
    def authenticate
      if @user && @user.authenticate(@password)
        token = encode_token({ user_id: @user.id, name: @user.name })
        { user: @user, token: token }
      else
        { error: 'Invalid email or password' }
      end
    end
  
    private
  
    def encode_token(payload)
      expiration_time = 10.minutes.from_now.to_i
      payload[:exp] = expiration_time
      JWT.encode(payload, 'hellomars1211')
    end
  end
  