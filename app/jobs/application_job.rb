class ApplicationJob < ActiveJob::Base
  retry_on StandardError,
    wait: :exponentially_longer,
    attempts: 3

  around_perform do |job, block|
    block.call
  rescue => e # rescues StandardError and subclasses
    puts e
    raise
  end
end
