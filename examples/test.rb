# frozen_string_literal: true

require_relative 'sidekiq.rb'

job = Main.call_async(1, 2)
# sleep(2)
Second.call_after(job, 3, 4)
Third.call_after(job, 5, 6)
Fourth.any_method_after(job, 7, 8)
