# Codex

The intuitive toolkit for lawyers.

View live demo: [https://young-scrubland-22306.herokuapp.com](https://young-scrubland-22306.herokuapp.com)

## Table of contents

- [Project overview](#project-overview)
- [Local installation](#local-installation)
- [Application purpose](#application-purpose)
- [Front end](#front-end)
- [Data structures and models](#data-structures-and-models)
- [User access levels](#user-access-levels)
- [Third party services](#third-party-services)

## Project overview

Working as a lawyer, we are constantly questioning our software and looking for the unicorn CRM which is both complete enough yet intuitive enough. [There](https://www.coradis.ch) [are](https://www.winjur.com/features.php) [many](https://fr.timesensor.ch) [options](https://www.clio.com/uk/) [on](https://www.microsoft.com/fr-ch/microsoft-365/sharepoint/collaboration) [the](https://www.vertec.com/ch/) [market](https://www.sergroup.com/de/ecm-software.html), though none that satisfied me. So I decided to build my own, which could serve as a template for a full-fledged tool for lawfirms.

_**Note:** For the purpose of this project, the terms "User" and "Employee" will be synonymous, as well as "Project" and "Case". The correct term for a lawyer's "project" is a "case". But this is a reserved word by Rails and a risky word in Ruby, so I will avoid using it to name this model. Accordingly, cases will be labeled as "Project"s. Employee is also the correct word for the intended users of the application, but the term "User" is more appropriate in the context of a rails application. Accordingly, the terms "User" and "Employee" will also be synonymous._

_**Note 2:** Ruby of Rails style prescriptions (mostly) based on [this Ruby Style Guide](https://rails.rubystyle.guide)._

## Local installation

1. Make sure Ruby 2.6.6 is installed on your system. Fire command prompt and run:
```shell
ruby -v
```
2. Make sure Rails 5.1.7 is installed
```shell
rails -v
```
If you see Ruby and Rails version then you are good to start, otherwise [you will need to install it](https://guides.rubyonrails.org/v5.1.7/getting_started.html)

3. Once done, clone this repository and move into it
```shell
git clone https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047.git
cd capstone-proposal-wad-c5-s1-2995-2047
```
4. Install all dependencies
```shell
bundle install
```
5. Create db and migrate schema
```shell
rails db:create
rails db:migrate
```
5. Now run your application
```shell
rails s
```
6. If all went well, you should be able to access it under `http://localhost:3000`

## Application purpose

Codex is a toolkit for lawyers that allows them to have an overview of their activity. Special care has been given to the intuitiveness of the application.

Currently, software solutions for lawyers are essentially based on general-purpose boilerplate CRMs and then reduced to fit particular needs. As such, they often provide overly complex or overwhelming features (think [SAP](https://www.sap.com/suisse/index.html)) but lack the specific logic required by this audience. Thus, these software risk being only partially understood and used fully. This project (tries to) tackle the problem by starting from the user's perspective — which I'm familiar with — and applying high quality standards in terms of software development practices to answer the stated needs.

The project's main features include:
- the ability to log an activity related to a specific project (_i.e._ timesheet for a case)
- an overview of clients and adversaries
- a list of upcoming deadlines
- an overview of cases
- a personal overview page with total billed hours

These overview pages are to include the following:
- **Project** (i.e. "Case") overview, including at least:
  - parties' names and roles
  - case description
  - total number of hours spent
  - financial overview
  - upcoming deadlines
  - employees working on the case
  - whether the case is active or archived
  - the project category
- **User** (i.e. "Employee") overview, including at least:
  - active cases
  - total hours
  - the ability to edit their infos (provided the user's privilege allows it)
- **Contact** (i.e. "Client/Adversary"), including at least:
  - overview of linked timesheet
  - overview of linked cases

I also intend to implement:
- some sort of conflict-check verification:
  - no contact can (ever) be simultaneously client in one case and adversary in another. This can be easily implemented by adding their role as an attribute. When opening a new case, only "clients" will show up as selectable clients and adversaries as such.
- ideally, query for addresses (via the tel.search.ch API).
- the project will support french and english localization

## Front end

The project will include numerous databases (timesheets, clients, deadlines, etc.), all of which have to be interacted with in an as intuitive as possible way. I will thus strive to make use of precisely the right amount of JS to provide for a simple UI/UX.

Examples include:
- the ability to easily add/remove timesheet entries
- the ability to access easily various overviews of statistics

### Mock ups

![home#index](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047/raw/master/_mockup/home%23index.png)
Home#index

![dashboard#show](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047/raw/master/_mockup/dashboard%23show.png)
Dashboard#show

![account#show](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047/raw/master/_mockup/account%23show.png)
Account#show

![projects#index](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047/raw/master/_mockup/projects%23index.png)
Projects#index

![project#show](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047/raw/master/_mockup/project%23show.png)
Project#show

![project#show_with_account](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047/raw/master/_mockup/project%23show_with_account.png)
Project#show (with account overlay)

![contacts#index](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047/raw/master/_mockup/contacts%23index.png)
Contacts#index

![deadlines#index](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047/raw/master/_mockup/deadlines%23index.png)
Deadlines#index

## Data structures and models

The project will be based on the following models:
- **User** (_i.e._ an employee of the firm)
  - Minimal attributes:
    - `login:string`,
    - `password:string`,
    - `avatar:string`,
    - `role:string`
  - Minimal associations:
    - Contact (_i.e._ user's own contact information, one-to-one),
    - Project (many-to-many),
    - Activity (one-to-many).
- **Contact** (_i.e._ a client or an adversary)
  - Minimal attributes:
    - `prefix:string`,
    - `name:string`,
    - `address:string`,
    - `country:string`,
    - `email:string`,
    - `profession:string`,
    - `role:string` (client, adversary, other),
    - `personality:string` (company, private person),
    - `notes:text`.
  - Minimal associations:
    - Project (many-to-many).
- **Project** (_i.e._ a case)
  - Minimal attributes:
    - `label:string`,
    - `description:text`,
    - `fee:decimal{10,2}` (_i.e._ default fee),
    - `category:string`,
    - `status:string` (active or archived).
  - Minimal associations:
    - User (many-to-many),
    - Contact (_i.e._ parties involved, many-to-many),
    - Activity (one-to-many),
    - Deadline.
- **ProjectCategory**
  - Minimal attributes:
    - `label:string`,
    - `color:string`.
  - Minimal associations:
    - Project (one-to-many)
- **Activity** (_i.e._ the unit for timesheets)
  - Minimal attributes:
    - `label:string`,
    - `category:string`,
    - `time:decimal{10,2}` (NOT time/DateTime/..., I just want it to be "0.20", "1.45", etc.),
    - `date:date`.
  - Minimal associations:
    - User (many-to-one),
    - Project (many-to-one).
- **Deadline** (_i.e._ similar to a to-do list)
  - Minimal attributes:
    - `label:string`,
    - `category:string`,
    - `date:date`.
  - Minimal associations:
    - Project (many-to-many).

## User access levels

The following roles will be available:
- Admin
- Partner
- Associate
- Intern

### Users

| Action  | Admin | Partner | Associate | Intern |
|---------|-------|---------|-----------|--------|
| index   | x     |         |           |        |
| show    | x     | (1)     | (1)       | (1)    |
| new     | (3)   | (3)     | (3)       | (3)    |
| edit    | x     | (1)     | (1)       | (1)    |
| create  | (3)   | (3)     | (3)       | (3)    |
| update  | x     | (1)     | (1)       | (1)    |
| destroy | x (2) |         |           |        |

(1) restricted to self
(2) except self
(3) no log in required

### Contacts

| Action  | Admin | Partner | Associate | Intern |
|---------|-------|---------|-----------|--------|
| index   | x     | x       | x         | x      |
| show    | x     | x       | x         | x      |
| new     | x     | x       | x         | x      |
| edit    | x     | x       | x         | x      |
| create  | x     | x       | x         | x      |
| update  | x     | x       | x         | x      |
| destroy | x     | x       |           |        |
| import  | x     | x       | x         | x      |

### Projects

| Action  | Admin | Partner | Associate | Intern |
|---------|-------|---------|-----------|--------|
| index   | x     | x       | x         | x      |
| show    | x     | x       | x         | x      |
| new     | x     | x       | x         | x      |
| edit    | x     | x       | x         | (1)    |
| create  | x     | x       | x         | x      |
| update  | x     | x       | x         | (1)    |
| destroy | x     | (1)     | (1)       | (1)    |

(1) only if owner

### Activities

| Action  | Admin | Partner | Associate | Intern |
|---------|-------|---------|-----------|--------|
| create  | x     | x       | x         | x      |
| destroy | x     | (1)     | (1)       | (1)    |

(1) only if project owner or activity author

### Deadlines

| Action   | Admin | Partner | Associate | Intern |
|----------|-------|---------|-----------|--------|
| index    | x     | x       | x         | x      |
| new      | x     | x       | x         | x      |
| create   | x     | x       | x         | x      |
| destroy  | x     | x       | x         | x      |
| complete | x     | x       | x         | x      |

## Third party services

These include:

* Ruby gems or JavaScript libraries outside of those bundled with Ruby on Rails by default.
  - [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) for user avatars;
  - [Kaminari](https://github.com/kaminari/kaminari) for pagination;
  - [Faker](https://github.com/faker-ruby/faker) to generate realistic seed data;
  - [Figaro](https://rubygems.org/gems/figaro), Heroku-friendly Rails app configuration;
  - ~~[Fog-aws](https://rubygems.org/gems/fog-aws), module for fog or as standalone provider to use the Amazon S3;~~
  - [Carrierwave](https://rubygems.org/gems/carrierwave-aws), officially supported AWS-SDK library for S3 storage;
  - [PG](https://rubygems.org/gems/pg), ruby interface for PostgreSQL.
* Third party APIs
  - [tel.search](https://tel.search.ch/api/help.fr.html), in order to retrieve real user data.
* Deployment services
  - Most likely [Heroku](https://www.heroku.com), at least for the proof-of-concept.
