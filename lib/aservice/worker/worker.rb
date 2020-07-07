# frozen_string_literal: true

module Aservice
  # Mixin which define perform_after method
  module Worker
    def self.included(base)
      base.include Sidekiq::Worker
      base.include Sidekiq::Status::Worker
      Sidekiq::Worker::Setter.class_eval do
        def perform_after(jid, class_name, method, *args)
          Aservice::Callback.add(jid, class_name, method, args)
        end
      end

      def expiration
        Aservice::Config.status_expiration
      end
    end
  end
end
