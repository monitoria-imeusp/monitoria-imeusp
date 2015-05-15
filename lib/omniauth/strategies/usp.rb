require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class USP < OmniAuth::Strategies::OAuth
      # Give your strategy a name.
      option :name, "USP"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      site = "https://uspdigital.usp.br/wsusuario"
      id = "9"
      if Rails.env.development?
        site = "https://labs.uspdigital.usp.br/wsusuario"
        id = "8"
      end      

      option :client_options, {
        site: site
      }

      option :authorize_params, {
        callback_id: id
      }

      option :callback_confirmed, true

      # These are called after authentication has succeeded. If
      # possible, you should try to set the UID without making
      # additional calls (if the user id is returned with the token
      # or as a URI parameter). This may not be possible with all
      # providers.
      uid { request.params['user_id'] }

      info do
        {
          :nusp => raw_info['loginUsuario'],
          :name => raw_info['nomeUsuario'],
          :email => raw_info['emailPrincipalUsuario'],
          :link => userlink
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      private

      def raw_info
        body = access_token.post('/oauth/usuariousp').body
        #@raw_info ||= MultiJson.decode(body)
        @raw_info = MultiJson.decode(body)
      end

      def userlink
        raw_info['vinculo'].each do |link|
          type = link['tipoVinculo']
          if type == "ALUNOGR" or type == "ALUNOPOS"
            return :student
          elsif type == "SERVIDOR" 
            return :teacher
          end
        end
      end

    end
  end
end

OmniAuth.config.add_camelization 'usp', 'USP'
