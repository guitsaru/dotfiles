require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
IRB.conf[:PROMPT_MODE] = :SIMPLE
IRB.conf[:AUTO_INDENT] = true

if defined?(Rails) && defined?(ActiveRecord) && Rails.logger
  Rails.logger =Logger.new(STDOUT)
  ActiveRecord::Base.logger = Rails.logger
elsif !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(STDOUT))
end
