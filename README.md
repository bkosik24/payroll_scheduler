Payroll Scheduler App
=====================

#### Setup

1. Clone Repo onto your local machine (git clone git@github.com:bkosik24/payroll_scheduler.git)
2. cd into that directory cd payroll_scheduler/
3. Run bundle install (install bundler gem first if you don't already have it)


#### Executing

1. Run **bin/payroll_scheduler**

#### Testing the different scenarios
1. Type "1" to calculate the payroll dates for a given year & date
  1. First enter a year, next enter a day of the month (1-31), then either drag in or type in the path of the JSON file of public holidays.
2. Type "2" to calculate the payroll dates for a given start date & frequency
  1. First enter a day of the year in the MM/DD/YYYY format, enter a frequency based on the options provided, then either drag in or type in the path of the JSON file of public holidays.

*Notes:* The starting date, frequency and public holiday JSON file is an optional parameter.
