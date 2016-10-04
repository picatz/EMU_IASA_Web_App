module Sinatra
  module App
    module Routing
      module Main
        def self.registered(app)

          app.get '/' do
            erb :index
          end

          app.get '/twitter' do
            redirect 'https://twitter.com/EMU_IASA'
          end

          app.get '/slack' do
            redirect 'https://emusec.slack.com/'
          end

          app.get '/blog' do
            redirect 'https://emuiasa.wordpress.com/'
          end

        end
      end
    end
  end
end
