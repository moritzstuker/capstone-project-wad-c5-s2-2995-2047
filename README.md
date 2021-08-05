# Codex

The intuitive toolkit for lawyers. Live demo available under: [https://young-scrubland-22306.herokuapp.com](https://young-scrubland-22306.herokuapp.com)

## Table of contents

- [Project instructions](#project-instructions)
- [Overview](#overview)
- [Local installation](#local-installation)
- [Access online demo](#access-online-demo)
- [What the project has achieved](#what-the-project-has-achieved)
- [Changes I had to make or difficulties that I have faced](#changes-i-had-to-make-or-difficulties-that-i-have-faced)

## Project instructions

> Once you have completed your capstone project as outlined in your project proposal, you will need to submit the project in the form of a git repository saved on GitHub.  
Before submitting, make sure that there is adequate documentation to explain what the project has achieved and any changes you had to make or difficulties that you faced. Put all such comments in a README.md file in the root of your project folder.  
Also include the public URL for your deployed application in the README.md file, e.g. the URL to access the deployed application on Heroku.  
Once you have done these things, follow the instructions for the submission process after this unit.

Project proposal available under [this dedicated repository](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047).

## Overview

Working as a lawyer, we are constantly questioning our software and looking for the unicorn CRM which is both complete enough yet intuitive enough. [There](https://www.coradis.ch) [are](https://www.winjur.com/features.php) [many](https://fr.timesensor.ch) [options](https://www.clio.com/uk/) [on](https://www.microsoft.com/fr-ch/microsoft-365/sharepoint/collaboration) [the](https://www.vertec.com/ch/) [market](https://www.sergroup.com/de/ecm-software.html), though none that satisfied me. So I decided to build my own, which could serve as a template for a full-fledged tool for lawfirms.

_**Note:** For the purpose of this project, the terms "User" and "Employee" will be synonymous, as well as "Project" and "Case". The correct term for a lawyer's "project" is a "case". But this is a reserved word by Rails and a risky word in Ruby, so I will avoid using it to name this model. Accordingly, cases will be labeled as "Project"s. Employee is also the correct word for the intended users of the application, but the term "User" is more appropriate in the context of a rails application. Accordingly, the terms "User" and "Employee" will also be synonymous._

_**Note 2:** Ruby of Rails style prescriptions (mostly) based on [this Ruby Style Guide](https://rails.rubystyle.guide)._

## Local installation

1. Make sure Ruby 2.6.6 is installed on your system. To check this, fire up a command prompt and run:
```shell
ruby -v
```
2. Still in the command prompt, make sure Ruby on Rails 5.1.7 is installed:
```shell
rails -v
```
If you see the correct versions for both Ruby and Ruby on Rails then you are good to start, otherwise [you will need to install what's missing](https://guides.rubyonrails.org/v5.1.7/getting_started.html).

3. Once done, clone this repository and move into it:
```shell
git clone https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047
cd capstone-project-wad-c5-s2-2995-2047
```
4. Install all dependencies:
```shell
bundle install
```
5. Create db and migrate schema:
```shell
rails db:create
rails db:migrate
```
6. [optional] Seed some fake data:
```shell
rails db:seed
```
7. Now run your application:
```shell
rails s
```
8. If all went well, you should be able to access it under [`http://localhost:3000`](http://localhost:3000).

9. If you seeded data (step 6 above), you may now login with either of the <span id="account-credentials">following accounts</span>:

| Role      | Login              | Password   |
|-----------|--------------------|------------|
| Admin     | admin@test.dev     | `password` |
| Partner   | partner@test.dev   | `password` |
| Associate | associate@test.dev | `password` |
| Intern    | intern@test.dev    | `password` |

If you did not seed any data, you will first need to [create an account](http://localhost:3000/signup), then bump it to admin level:
```shell
rails console
User.last.update_attribute(:role, :admin)
```

## Access online demo

1. Head over to [https://young-scrubland-22306.herokuapp.com](https://young-scrubland-22306.herokuapp.com).

2. You may then either [create a new account](https://young-scrubland-22306.herokuapp.com/signup) or [log into](https://young-scrubland-22306.herokuapp.com/login) one of the existing accounts. For their respective credentials, see [point 9 of the Local installation](#account-credentials) above; they're identical.

3. Have fun.

## What the project has achieved

On a subjective level, I have managed to set up a web app such as I would like to use on a daily basis. It's feature-rich yet intuitive enough so that a user could find his/her way around [without needing a manual](https://www.brainyquote.com/quotes/elon_musk_567244).

On an objective level, I believe that the project meets the requirements. All [project features](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047#application-purpose) are there and work as expected and the UI/UX is satisfactory. One could of course always improve such a project, and if I had the time I would probably update it to Rails 6, tweak the controllers so that they only output JSON and plug something like [react.js](https://github.com/reactjs/react-rails) on the front-end. This was however never the scope if this exercise.

## Changes I had to make or difficulties that I have faced

I have faced a great amount of unexpected difficulties, some of which I was able to overcome, some of which I could not solve and some of which I managed to get around. Here are the main ones, along with the fixes I had to make.

### Storing addresses

- **The Address field.** The 'Contact' model has a 'street' and a 'city' field. Initially, I wanted these two to be a single [serialized hash](https://apidock.com/rails/ActiveModel/Serialization/serializable_hash). The reason was that I view the 'Address' as a single unit composed of various sub-elements (street, street number, zip code, city, county and country). I implemented this successfully on the Model level and was able to seed data into it as a satisfactory way, as well as show it in the views. But then came the moment when I had to manipulate the data from the front-end, through an HTML form. The complexity quickly got out of hands: should I use a nested form? a dedicated form? how to edit a single element of the serialized hash yet preserve the rest? should the hash be written in YAML, JSON, TOML, or anything else? Should I use a dedicated gem? I toyed around some time before deciding that it was just not worth it: serialized hashes were not part of the course and the fun of discovering something new turned to frustration without any sufficient outcome in sight. So I chose to move away from the problem and to shift to a dedicated Model: ContactAddress...

- **The ContactAddress model.** Creating a dedicated model for the contact's addresses proved to be much more flexible than a serialized hash. It could have validation rules, extensible fields, be associated with multiple contacts (indeed as a one-to-many relationship, where one address could (optionally!) `belong_to` many contacts), etc. One could also imagine having multiple addresses for a single contact: billing address, delivery address, work address, etc  (in which cas the association would be a many-to-many relationship, _i.e._ a `has_and_belongs_to_many` association). So from a technical standpoint, this was a viable solution. However, another issue started creeping up: one of the key goals of my project was to provide for a simple and intuitive interface and not just a blind rush-for-features. Indeed, here's a quote [from my project proposal](https://github.com/epfl-extension-school/capstone-proposal-wad-c5-s1-2995-2047#application-purpose):

> Currently, software solutions for lawyers are essentially based on general-purpose boilerplate CRMs [which] provide overly complex or overwhelming features (think SAP) but lack the specific logic required by this audience. Thus, these software risk being only partially understood and used fully.

Providing for multiple addresses per contact was way beyond the specifications and provided no additional value: the scope of my project was such that you needed only a single address and by no means multiple ones. I realized that I actually fell into the trap that I was precisely trying to avoid: providing overly complex features which are not needed.

- **The 'street' and 'city' fields.** So I took the decision to remove this model entirely and stick to a simple 'street' and 'city' field for my contacts. This is enough and not more than what's needed. It's simple and leaves enough liberty for the user to specify whatever's needed. Besides, there's no justification to normalize the data up to the street number, so I might as well just include it in the 'street' field and not have a dedicated field.

### User access levels

This application relies heavily on user access levels. There are four different user roles (admin, partner, associate and intern), plus a fifth: anonymous. It proved to be quite hard to make sure every role had access to the right pages, not less, not more.

I've contemplated the possibility of defining these roles in a dedicated model, called something along the lines of "UserRoles". One could imagine the columns to be the roles, the lines to contain various controller actions and the fields a boolean value indicating if said role can perform said action. Then, in the controller, every action would have to be checked in this table before being executed (with a `before_action` method). An even more compact solution could have been a single column and each field containing the minimal role which may execute the action, and `nil` where no role is required. So for example:

```ruby
# app/models/user.rb
class User < ApplicationRecord
  enum role: {
    intern: 0,
    associate: 1,
    partner: 2,
    admin: 3
  }
end
```

and the `UserRoles` table:

| action          | minimal_access_level |
|-----------------|----------------------|
| Home#index      | nil                  |
| Project#index   | 0                    |
| Project#show    | 0                    |
| Project#new     | 2                    |
| Project#edit    | 1                    |
| Project#create  | 2                    |
| Project#update  | 1                    |
| Project#destroy | 3                    |
| ...             | ...                  |

This would have been a very elegant way to make sure the access levels are correct.

The problem however, is that in order to check if a certain action may be performed of not, I should probably have to pass the name of this action as a string to a certain method in order to verify the user's rights. This method would then have to `eval()` the intended method's name in order to run it. Running this command was a no-go for me, as [it poses a huge security risk](https://medium.com/@r_trojanowski/a-quick-overview-of-security-vulnerabilities-in-rails-applications-96385b78852a#2106) (I've only used this command in [one specific test](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047/blob/master/test/controllers/sessions_controller_test.rb), where I can be absolutely sure it will only run in a controller environment). Besides, the entire setup looked a lot like something too complicated for the intended purposes.

A much simpler way would have been to use a gem, such as [CanCan](https://github.com/ryanb/cancan). In a "real-world" situation, I would probably have used this. In this context however, I chose to go the 'long way' and set these permissions manually, be it at least to learn something along the way.

### Scopes and their consequences

Scopes are simple in appearance. It gets much more tricky when you are dealing with scopes on associated models, especially when these models do not have an obvious name. For example, the Contact model has a `get_role` scope ([contact.rb:22](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047/blob/7bca1b8ad85ec53adc451111335fbdc3e83e4cc1/app/models/contact.rb#L22)). The roles are defined in a separate model, called `ContactRole`. But the attribute is `role`, not `ContactRole`. Besides, such code was prone to the dreaded [N+1 query issue](https://medium.com/@bretdoucette/n-1-queries-and-how-to-avoid-them-a12f02345be5), which generates a horrendous amount of SQL queries. Thus, I slowly came to satisfactory piece code: [`scope :get_role, -> (str) { includes(:role).where("contact_roles.label = '#{str}'").references(:contact_roles) }`](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047/blob/7bca1b8ad85ec53adc451111335fbdc3e83e4cc1/app/models/contact.rb#L22).

### Keeping rails-ujs in sync with views

Views are coded in ruby-peppered HTML (ERB). But it's essentially HTML with placeholders for content. Dynamic JavaScript interactions require to code the HTML tags in, well, JavaScript. But both languages are completely different. As an example, the [_activity.html.erb](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047/blob/master/app/views/application/_activity.html.erb) partial and the [create.js.erb](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047/blob/master/app/views/activities/create.js.erb) view render essentially the same tags. But I've edited the .html file many times and realized much later that the .js file had to be kept in sync. This proved to be tedious and demonstrated the need for careful element construction.
