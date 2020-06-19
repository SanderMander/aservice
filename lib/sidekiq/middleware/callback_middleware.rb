# frozen_string_literal: true

module Sidekiq
  module Middleware
    class CallbackMiddleware
      def call(_worker_class, job, _queue)
        yield
        Aservice::Callback.success(job)
      rescue StandardError => e
        Aservice::Callback.failure(job)
        raise e
      end
    end
  end
end

Sidekiq.configure_server do |config|
  config.server_middleware do |chain|
    chain.add Sidekiq::Middleware::CallbackMiddleware
  end
end
