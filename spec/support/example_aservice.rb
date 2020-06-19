# frozen_string_literal: true

class ExampleService
  include Aservice

  def self.call(a, b)
    [a, b]
  end

  def self.any(a, b)
    [a, b]
  end
end
