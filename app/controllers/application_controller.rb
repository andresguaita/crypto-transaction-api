class ApplicationController < ActionController::API
    # Decodifica el JWT
    def decode_token
      auth_header = request.headers['Authorization']
      if auth_header
        token = auth_header.split(' ')[1]
        begin
          JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
    end
  
    # Encuentra al usuario actual basado en el token JWT
    def current_user
      decoded_token = decode_token
      if decoded_token
        user_id = decoded_token[0]['user_id']
        @user = User.find_by(id: user_id)
      end
    end
  
    # Verifica si hay un usuario autenticado
    def logged_in?
      !!current_user
    end
  
    # Acción que se ejecuta antes de cualquier acción protegida
    def authorized
      render json: { error: 'Please log in' }, status: :unauthorized unless logged_in?
    end
  end
  
  