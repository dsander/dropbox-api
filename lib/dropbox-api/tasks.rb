module Dropbox
  module API

    class Tasks

      extend Rake::DSL if defined? Rake::DSL

      def self.install

        namespace :dropbox do
          desc "Authorize wizard for Dropbox API"
          task :authorize do
            require "oauth2"
            require "dropbox-api"
            require "cgi"
            print "Enter dropbox app key: "
            consumer_key = $stdin.gets.chomp
            print "Enter dropbox app secret: "
            consumer_secret = $stdin.gets.chomp

            Dropbox::API::Config.app_key    = consumer_key
            Dropbox::API::Config.app_secret = consumer_secret

            authorize_uri = ::Dropbox::API::OAuth2::AuthFlow.start

            puts "\nGo to this url and click 'Authorize' to get the token:"
            puts authorize_uri
            print "\nOnce you authorize the app on Dropbox, paste the code here and press enter:"
            code = $stdin.gets.chomp

            access_token = ::Dropbox::API::OAuth2::AuthFlow.finish(code)

            puts "\nAuthorization complete!:\n\n"
            puts "  Dropbox::API::Config.app_key    = '#{consumer_key}'"
            puts "  Dropbox::API::Config.app_secret = '#{consumer_secret}'"
            puts "  client = Dropbox::API::Client.new(:token  => '#{access_token.token}')"
            puts "\n"
          end

        end

      end

    end

  end
end
