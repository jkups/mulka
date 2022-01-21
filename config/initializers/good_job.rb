# use ActiveJob to retry, not GoodJob
GoodJob.retry_on_unhandled_error = false
GoodJob.on_thread_error = ->(_) {}
