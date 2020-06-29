# frozen_string_literal: true

require 'aservice'

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

job = Main.call_async(1, 2)
Second.call_after(job, 3, 4)
Third.call_after(job, 5, 6)
