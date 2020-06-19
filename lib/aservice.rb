# frozen_string_literal: true

require 'sidekiq'
require 'anyway_config'
require_relative 'aservice/config.rb'
require_relative 'aservice/worker/worker.rb'
require_relative 'aservice/worker/aservice_worker.rb'
require_relative 'aservice/callback.rb'
require_relative 'sidekiq/middleware/callback_middleware.rb'

module Aservice
  def self.included(base)
    base.class_eval do
      class << self
        def call_async(*args)
          perform(:async, 'call', args)
        end

        def call_after(jid, *args)
          args = [] if args.nil?
          perform(:after, 'call', args.unshift(jid))
        end

        def method_missing(method, *args)
          method = method.to_s
          if method =~ /_async$/
            method = method.sub(/.*\K_async/, '')
            perform(:async, method, args)
          elsif method =~ /_after$/
            method = method.sub(/.*\K_after/, '')
            perform(:after, method, args)
          else
            raise_no_method_error("No method: #{method} for class: #{AserviceWorker.name}")
          end
        end

        private

        def perform(type, method, args)
          worker = AserviceWorker.set(queue: Aservice::Config.queue)
          raise_no_method_error("No method: #{method} for class: #{name}") unless respond_to?(method.to_sym)
          if type == :async
            worker.perform_async(name, method, *args)
          else
            jid = args.shift
            worker.perform_after(jid, name, method, *args)
          end
        end

        def raise_no_method_error(msg)
          raise NoMethodError, msg
        end
      end
    end
  end
end
