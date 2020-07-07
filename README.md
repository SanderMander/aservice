Aservice gem allow you to execute your services in background as a sidekiq jod.

Include Aservice into your class and [method_name]_async and [method_name]_after will be available.

[method_name]_async call method in sidekiq background job.
And [method_name]_after accepts sidekiq job as a first argument and would call method only when job will be successfully completed.
Check examples folder for example