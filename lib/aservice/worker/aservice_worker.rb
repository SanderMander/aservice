# frozen_string_literal: true

# sidekiq worker which run services in background
class AserviceWorker
  include Aservice::Worker

  def perform(class_name, method_name, *args)
    Kernel.const_get(class_name).__send__(method_name, *args)
  end
end
