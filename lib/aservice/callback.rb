# frozen_string_literal: true

module Aservice
  class Callback
    class << self
      def add(jid, class_name, method, args)
        opt = {
          'class' => class_name,
          'method' => method,
          'args' => args
        }
        Sidekiq.redis do |conn|
          conn.rpush("as#{jid}", opt.to_json)
        end
      end

      def success(job)
        while (opt = pop_next(job['jid']))
          res = Kernel.const_get(opt['class']).send(opt['method'], *opt['args'])
        end
      end

      def failure(job)
        clear_stack(job['jid'])
      end

      private

      def pop_next(jid)
        opt = Sidekiq.redis do |conn|
          conn.lpop("as#{jid}")
        end
        return false if opt.nil?

        JSON.parse(opt)
      end

      def clear_stack(jid)
        Sidekiq.redis do |conn|
          conn.del("ac#{jid}")
        end
      end
    end
  end
end
