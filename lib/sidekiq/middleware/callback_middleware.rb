# frozen_string_literal: true

module Sidekiq
  module Middleware
    # Middleware which executes callbacks
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

Sidekiq.configure_client do |config|
  Sidekiq::Status.configure_client_middleware config
end

Sidekiq.configure_server do |config|
  Sidekiq::Status.configure_server_middleware config
  Sidekiq::Status.configure_client_middleware config
  config.server_middleware do |chain|
    chain.add Sidekiq::Middleware::CallbackMiddleware
  end
end
