# frozen_string_literal: true

module Aservice
  # Sidekiq job callbacks
  class Callback
    class << self
      def add(jid, class_name, method, args)
        opt = {
          'class' => class_name,
          'method' => method,
          'args' => args
        }
        Sidekiq.redis do |conn|
          conn.multi do
            conn.rpush(key(jid), opt.to_json)
            conn.expire(key(jid), Aservice::Config.callbacks_expiration)
          end
        end
      end

      def success(job)
        while (opt = pop_next(job['jid']))
          execute_service(opt['class'], opt['method'], opt['args'])
        end
      end

      def failure(job)
        clear_stack(job['jid'])
      end

      private

      def execute_service(class_name, method, args)
        Kernel.const_get(class_name).send(method, *args)
      end

      def pop_next(jid)
        opt = Sidekiq.redis do |conn|
          conn.lpop(key(jid))
        end
        return false if opt.nil?

        JSON.parse(opt)
      end

      def clear_stack(jid)
        Sidekiq.redis do |conn|
          conn.del(key(jid))
        end
      end

      def key(jid)
        "#{Aservice::Config.redis_prefix}_#{jid}"
      end
    end
  end
end
