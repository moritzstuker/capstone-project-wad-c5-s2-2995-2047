# Capstone project proposal outline

Working as a lawyer, we are constantly questioning our software and looking for the unicorn CRM which is both simple enough yet complete enough. There are many options on the market, though none that satisfied me. So I decided to build my own.

## Project overview

The needs this application is intended to meet are the following:

- simple timesheet
- list of parties
- list of upcoming deadlines
- case overview, including at least:
  - parties' addresses
  - case description
  - total number of hours spent
  - financial overview (including expenses)
  - next deadlines
  - employees working on the case
  - links to case timesheet, deadlines, etc.
- employee overview, including at least:
  - active cases
  - total hours (per day/month/year)
- client account, including at least:
  - overview of timesheet
  - overview of deadlines
- some sort of conflict-check verification
- ideally, query for addresses and commercial registry via API.

## Application purpose

The application is intended to serve as a CRM for lawyers. Special care will be given to the intuitiveness of the application, both for lawyers.

Currently, software solutions for lawyers are solely coded by IT-professionals who don't always entirely understand the specific needs of this target audience and provide overly complex or overwhelming software (think SAP). Thus, these software become hugely complex tools which the users rarely use fully. This project here tackles the problem by starting from the user's perspective, which I know, and tries to achieve high quality standards in terms of software development practices based on this.

## Front end

The project will include numerous databases (timesheets, clients, employees, etc.), all of which have to be interacted with in an as intuitive as possible way. I will thus strive to make use of precisely the right amount of JS to provide for a simple UI.

Two examples are:
- the ability to easily add/remove/shift timesheet entries
- the ability to have overviews of different needs

## Data structures and models

- Employee (name, role, cases, timesheet, fees)
- Client (name, address, cases)
- Case (name, parties, subject)
- Timesheet entry (time, hourly fee, employee, case, date)
- Expenses (amount, case, provider, employee, date)
- Deadlines (date, case)

## Third party services

Include a list of all third party services that you envisage using in your project. For each one, indicate what they will be used for. These include:

* Ruby gems or JavaScript libraries outside of those bundled with Ruby on Rails by default.
  - Pixelpress (or equivalent) to generate PDFs (for invoices)
  - CarrierWave for files
  - Though neither a gem nor a JS library, I will provide french and english localization
* CSS frameworks
  - I like working with [Bulma](https://bulma.io), so I will most likely use this. But this may be adapted later on
* Third party APIs
  - [Zefix](https://www.e-service.admin.ch/wiki/display/openegovdoc/Zefix+Webservice), in order to get company informations
  - [tel.search](https://tel.search.ch/api/help.fr.html)
* Deployment services
  - Most likely Heroku, at least for the proof-of-concept. Later on, probably a company based in Switzerland for data protection reasons.
