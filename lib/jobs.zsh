#
# jobs: Set options related to jobs.
#

# 16.2.7 Job Control
setopt auto_resume     # Attempt to resume existing job before creating a new process.
setopt long_list_jobs  # List jobs in the long format by default.
setopt notify          # Report status of background jobs immediately.
setopt NO_bg_nice      # Don't run all background jobs at a lower priority.
setopt NO_check_jobs   # Don't report on jobs when shell exit.
setopt NO_hup          # Don't kill jobs on shell exit.
