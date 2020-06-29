# frozen_string_literal: true

module Aservice
  # anyway config wrapper
  class Config < Anyway::Config
    config_name :aservice

    attr_config logger: Logger.new($stdout),
                severity: Logger::Severity::DEBUG,
                queue: 'default'
    def self.instance
      @config ||= new
      yield @config if block_given?
      @config
    end

    def self.respond_to_missing?(_name, _)
      instance.respond_to?(method)
    end

    def self.method_missing(method)
      instance.send(method)
    end
  end
end
