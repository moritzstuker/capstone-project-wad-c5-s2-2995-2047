# Codex

The intuitive toolkit for lawyers. Live demo available under: [https://young-scrubland-22306.herokuapp.com](https://young-scrubland-22306.herokuapp.com)

## Table of contents

- [Project instructions](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047#project-instructions)
- [Overview](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047#overview)
- [Local installation](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047#local-installation)
- [Access online demo](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047#access-online-demo)
- [What the project has achieved](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047#what-the-project-has-achieved)
- [Changes I had to make or difficulties that I have faced](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047#changes-i-had-to-make-or-difficulties-that-i-have-faced)

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

9. If you seeded data (step 6 above), you may now login with either of the following accounts:

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

2. You may then either [create a new account](https://young-scrubland-22306.herokuapp.com/signup) or [log into](https://young-scrubland-22306.herokuapp.com/login) one of the existing accounts. For their respective credentials, see point 9 of the [Local installation](https://github.com/epfl-extension-school/capstone-project-wad-c5-s2-2995-2047#local-installation) above; they're identical.

3. Have fun.

## What the project has achieved

todo

## Changes I had to make or difficulties that I have faced

todo
