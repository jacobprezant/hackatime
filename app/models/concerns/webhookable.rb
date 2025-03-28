module Webhookable
  extend ActiveSupport::Concern

  included do
    after_save :omit_webhook
  end

  def omit_webhook
    puts "Omitting webhook!"
  end

  class_methods do
  end
end
