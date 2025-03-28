module Webhookable
  extend ActiveSupport::Concern

  included do
    after_save :omit_webhook
  end

  class_methods do
    private

    def omit_webhook
      puts "Omitting webhook!"
    end
  end
end
