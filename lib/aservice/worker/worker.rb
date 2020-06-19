# frozen_string_literal: true

module Aservice
  module Worker
    def self.included(base)
      base.include Sidekiq::Worker
      Sidekiq::Worker::Setter.class_eval do
        def perform_after(jid, class_name, method, *args)
          Aservice::Callback.add(jid, class_name, method, args)
        end
      end
    end
  end
end
