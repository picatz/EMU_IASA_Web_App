#!/usr/bin/env ruby
#
#    ▄▄▄▄▄▄▄▄▄▄▄▄▄
#  ▄▀             ▀▄
#  █   ▄▀▀▀█▀▀▄    █                      |
#  █   █     ▄▄█   █   █▀▀▀▀ █▄ ▄█ █   █  |  ▀▀█▀▀ █▀▀▀█ █▀▀▀▀ █▀▀▀█
#  █   ▀▄   ▀▄ ▀   █   █     █ █ █ █   █  |    █   █   █ █     █   █
#  █  ▄▄█     ▀▄▄  █   █▀▀▀  █   █ █   █  |    █   █▀▀▀█ ▀▀▀▀█ █▀▀▀█
#  ▀▄▀           ▀▄▀   █     █   █ █   █  |    █   █   █     █ █   █
#   ▀▄           ▄▀    ▀▀▀▀▀ ▀   ▀ ▀▀▀▀▀  |  ▀▀▀▀▀ ▀   ▀ ▀▀▀▀▀ ▀   ▀
#     ▀▄       ▄▀                         |
#       ▀▄   ▄▀
#         ▀▄▀
#
# This web application is built for Eastern Michigan
# University's Information Assurance Student Association
# to serve as a platform to foster an awesome cyber
# security community in Ypsilanti, MI. Written in Ruby
# with love.
#
# Author::    Kent 'picat' Gruber
# Copyright:: Copyright (c) 2016 Kent Gruber
# License::   MIT

# Require Gems
require 'sinatra/base'
require 'rack/protection'
require 'rack/ssl'
require 'rack/reverse_proxy'
require 'rack-ssl-enforcer'
require 'thin'
require 'yaml'
require 'logger'
require 'trollop'
require 'colorize'
#require 'pry'

# Require Custom Files
require_relative 'routes/main'
require_relative 'routes/errors'

# Main CTF class
class CTF < Sinatra::Base

  # Logging options for application.
  ::Logger.class_eval { alias :write :'<<' }
  # Application access.log is stored in /log/access.log
  access_log = ::File.join(::File.dirname(::File.expand_path(__FILE__)),'log','access.log')
  access_logger = ::Logger.new(access_log)
  # Application access.log is stored in /log/error.log
  error_logger = ::File.new(::File.join(::File.dirname(::File.expand_path(__FILE__)),'log','error.log'),"a+")
  error_logger.sync = true

  before do
    env["rack.errors"] =  error_logger
  end

  # Configurations for the application
  configure do
    set :title, "EMU IASA Web App"
    set :environment, :production
    set :bind, '192.207.255.38'
    set :port, 443
    set :server, :thin
    server.threaded = settings.threaded if server.respond_to? :threaded=
    enable :sessions
    set :root, File.dirname(__FILE__)
    use ::Rack::CommonLogger, access_logger
    register Sinatra::App::Routing::Main
    register Sinatra::App::Routing::Errors
    use Rack::ReverseProxy do
      reverse_proxy '/test', 'https://emuiasa.io/'
      reverse_proxy /^\/documentation\/?(.*)$/, 'https://emuiasa.io/$1'
    end
    use Rack::SSL
    use Rack::SslEnforcer
    use Rack::Deflater
  end

  def self.run!
    super do |server|
      server.ssl = true
      server.ssl_options = {
        :cert_chain_file  => File.dirname(__FILE__) + "/ssl/legit.cert.pem",
        :private_key_file => File.dirname(__FILE__) + "/ssl/legit.key.pem",
        :verify_peer      => false
      }
    end
  end
end

# Default option to help menu if nothing is set.
foo = ARGV[0] || ARGV[0] = '-h'

# Available options.
opts = Trollop::options do
  banner "EMU".green.bold + " IASA".white.bold
  version "EMU IASA Web App v 1.0"
  opt :start, "Start the application."
end

# Respond to whatever options.
if opts[:start]
  CTF.run!
end
