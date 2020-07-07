# frozen_string_literal: true

require 'aservice'
Redis.exists_returns_integer = false

class Main
  include Aservice

  def self.call(a, b)
    puts "summ: #{a + b}"
  end
end

class Second
  include Aservice

  def self.call(a, b)
    puts "summ: #{a + b}"
  end
end

class Third
  include Aservice

  def self.call(a, b)
    puts "summ: #{a + b}"
  end
end

class Fourth
  include Aservice

  def self.any_method(a, b)
    puts "summ: #{a + b}"
  end
end