Payroll Scheduler App
=====================

#### Setup

1. Clone Repo onto your local machine (git clone git@github.com:bkosik24/payroll_scheduler.git)
2. Run bundle install (install bundler gem first if you don't arleady have it)

#### Executing

1. Run pry command, ie (USER)$ pry
2. type: load "lib/payroll_scheduler.rb"
3. payroll = PayrollScheduler.new

#### Testing the different scenarios
1. **Yearly on a specific date**
⋅⋅1. payroll.find_dates_for_year (The system will prompt you to enter in a few values)

2. **Payroll on a given start date**
⋅⋅1. payroll.find_payouts_starting_on_date (The system will ask you to enter a start date)

3. **Payroll on a given start date with a frequency**
⋅⋅1. payroll.find_payouts_for_frequency (The system will ask for a start date & frequency)
