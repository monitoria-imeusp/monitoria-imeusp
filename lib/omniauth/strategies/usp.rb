require 'omniauth-oauth'

module OmniAuth
  module Strategies
    class USP < OmniAuth::Strategies::OAuth
      # Give your strategy a name.
      option :name, "USP"

      # This is where you pass the options you would pass when
      # initializing your consumer from the OAuth gem.
      option :client_options, {
        #site: "https://uspdigital.usp.br/wsusuario/"
        site: "https://labs.uspdigital.usp.br/wsusuario"
      }

      option :authorize_params, {
        #callback_id: "9"
        callback_id: "8"
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
          :email => raw_info['emailPrincipalUsuario']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        body = access_token.post('/oauth/usuariousp').body
        @raw_info ||= MultiJson.decode(body)
      end
    end
  end
end

OmniAuth.config.add_camelization 'usp', 'USP'
