# Codex

The intuitive toolkit for lawyers.

## Table of content

- [Project overview](#project-overview)
- [Application purpose](#application-purpose)
- [Front end](#front-end)
- [Data structures and models](#data-structures-and-models)
- [Third party services](#third-party-services)

## Project overview

Working as a lawyer, we are constantly questioning our software and looking for the unicorn CRM which is both complete enough yet intuitive enough. [There](https://www.coradis.ch) [are](https://www.winjur.com/features.php) [many](https://fr.timesensor.ch) [options](https://www.clio.com/uk/) [on](https://www.microsoft.com/fr-ch/microsoft-365/sharepoint/collaboration) [the](https://www.vertec.com/ch/) [market](https://www.sergroup.com/de/ecm-software.html), though none that satisfied me. So I decided to build my own so that we could use it in our law firm.

_**Note:** For the purpose of this project, the terms "User" and "Employee" will be synonymous, as well as "Project" and "Case". The correct term for a lawyer's "project" is a "case". But it's a reserved word by Rails, so I will avoid using it to name this model. Accordingly, cases will be labeled as "Project"s. Employee is also the correct word for the intended users of the application, but the term "User" is more appropriate in the context of a rails application. Accordingly, the terms "User" and "Employee" will also be synonymous._

## Application purpose

Codex is a toolkit for lawyers that allows them to have an overview of their activity. Special care will be given to the intuitiveness of the application.

Currently, software solutions for lawyers are solely coded by IT-professionals who don't always entirely understand the specific needs of this target audience and provide overly complex or overwhelming software (think [SAP](https://www.sap.com/suisse/index.html)). Thus, these software become hugely complex tools which the users rarely use fully. This project here tackles the problem by starting from the user's perspective, which I know, and tries to achieve high quality standards in terms of software development practices based on this.

The project's main features include:
- the ability to log an activity related to a specific project (_i.e._ timesheet for a case)
- an overview of clients and adversaries
- a list of upcoming deadlines
- an overview of cases
- a personal overview page with total billed hours

These overview pages are to include the following:
- Project (i.e. "Case") overview, including at least:
  - parties' addresses and roles
  - case description
  - total number of hours spent
  - financial overview (including expenses)
  - next deadlines
  - employees working on the case
  - links to case timesheet, deadlines, etc.
  - whether the case is active or archived
- User (i.e. "Employee") overview, including at least:
  - active cases
  - total hours (per day/month/year)
  - the ability to edit their infos within their respective access level
- Contact (i.e. "Client/Adversary"), including at least:
  - overview of linked timesheet
  - overview of linked cases

I also intend to implement:
- some sort of conflict-check verification:
  - no duplicate contacts, which is to say that there will be a uniqueness validator
  - no contact can (ever) be simultaneously client in one case and adversary in another. This can be easily implementented by adding their role as an attribute. When opening a new case, only "clients" will show up as selectable clients and adversaries in their place.
- ideally, query for addresses (via the tel.search.ch API) and commercial registry entries (via the zefix API).
- the project will support french and english localization

## Front end

The project will include numerous databases (timesheets, clients, employees, etc.), all of which have to be interacted with in an as intuitive as possible way. I will thus strive to make use of precisely the right amount of JS to provide for a simple UI.

Examples include:
- the ability to easily add/remove/shift timesheet entries
- the ability to have overviews of different needs

I intend to use the [Tailwind CSS 2.1.0](https://tailwindcss.com) framework for all my front-end needs, backed up by [AlpineJS](https://github.com/alpinejs/alpine).

In order to [use Tailwind fully](https://tailwindcss.com/docs/installation), it needs to be loaded as a [PostCSS](https://postcss.org) plugin, which is included in [Webpack](https://webpack.js.org), [which does not come activated by default in rails 5.1.7](https://samuelmullen.com/articles/embracing-change-rails51-adopts-yarn-webpack-and-the-js-ecosystem/). So this will have to be implemented first.

If, for some unforeseen reason, Tailwind CSS does not satisfy the needs, I will resort to the more traditional CSS Framework [Bulma](https://bulma.io), which does not need any additional tool such as Webpack. One of these reasons is the fact that I own an Apple Silicon-based MacBook Air, on which [Webpack is having issues](https://github.com/rails/webpacker/issues/2992#issuecomment-827002178).

## Data structures and models

The project will be based on the following models:
- **User** (_i.e._ an employee of the firm)
  - Minimal attributes: `login:string`, `password:string`, `avatar:string`, `role:string`
  - Minimal associations: Contact (_i.e._ user's own contact information, one-to-one), Project (many-to-many), TimeEntry (one-to-many), Deadline (many-to-many).
- **Contact** (_i.e._ a client or an adversary)
  - Minimal attributes: `prefix:string`, `first_name:string`, `last_name:string`, `suffix:string`, `address:text` (serialized hash), `phone:string`, `email:string`, `birthday:date`, `profession:string`, `role:string` (client, adversary, employee, other), `personality:string` (legal, natural), `notes:text`.
  - Minimal associations: User (_i.e._ user's own contact information, one-to-one), Project (many-to-many).
- **Project** (_i.e._ a case)
  - Minimal attributes: `label:string`, `description:text`, `fee:decimal{10,2}` (_i.e._ default fee), `status:string` (active or archived).
  - Minimal associations: User (many-to-many), Contact (_i.e._ parties involved, many-to-many), TimeEntry (one-to-many).
- **TimeEntry** (_i.e._ the unit for timesheets)
  - Minimal attributes: `label:string`, `category:string`, `time:decimal{10,2}` (NOT time/DateTime/..., I just want it to be "0.20", "1.45", etc.), `date:date`.
  - Minimal associations: User (many-to-one), Project (many-to-one).
- **Deadline** (_i.e._ similar to a to-do list)
  - Minimal attributes: `label:string`, `category:string`, `date:date`.
  - Minimal associations: User (many-to-many).

## Third party services

Include a list of all third party services that you envisage using in your project. For each one, indicate what they will be used for. These include:

* Ruby gems or JavaScript libraries outside of those bundled with Ruby on Rails by default.
  - [Pixelpress](https://github.com/nerdgeschoss/pixelpress) (or equivalent) to generate PDFs (for invoices);
  - [CarrierWave](https://github.com/carrierwaveuploader/carrierwave) for user avatars;
  - [Kaminari](https://github.com/kaminari/kaminari) for pagination;
  - [Faker](https://github.com/faker-ruby/faker) to generate realistic seed data;
  - [figaro](https://rubygems.org/gems/figaro), Heroku-friendly Rails app configuration;
  - [fog-aws](https://rubygems.org/gems/fog-aws), module for fog or as standalone provider to use the Amazon S3;
  - [pg](https://rubygems.org/gems/pg), ruby interface for PostgreSQL;
  - [redcarpet](https://rubygems.org/gems/redcarpet), for richer texts (parses markdown to html).
* CSS frameworks
  - [Tailwind CSS](https://tailwindcss.com) for all my front-end needs.
* Third party APIs
  - [Zefix](https://www.e-service.admin.ch/wiki/display/openegovdoc/Zefix+Webservice), in order to get company information.
  - [tel.search](https://tel.search.ch/api/help.fr.html), in order to retrieve real user data.
* Deployment services
  - Most likely [Heroku](https://www.heroku.com), at least for the proof-of-concept. Later on, probably a company based in Switzerland for data protection reasons.
