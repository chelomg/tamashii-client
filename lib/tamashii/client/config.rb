require 'tamashii/common'
module Tamashii
  module Client
    class Config
      class << self
        def instance
          @instance ||= Config.new
        end

        def respond_to_missing?(name, _all = false)
          super
        end

        def method_missing(name, *args, &block)
          return instance.send(name, *args, &block) if instance.respond_to?(name)
          super
        end
      end

      include Tamashii::Configurable

      config :log_file, default: STDOUT

      config :use_ssl, default: false
      config :entry_point, default: ""
      config :host, default: "localhost"
      config :port, default: 3000
      config :opening_timeout, default: 10
      config :opening_retry_interval, default: 1
      config :closing_timeout, default: 10

      def log_level(level = nil)
        return Client.logger.level if level.nil?
        Client.logger.level = level
      end
    end
  end
end
