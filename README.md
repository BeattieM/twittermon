# Technical Assessment - Twittermon
A Ruby on Rails website developer coding practical

## Running the project
This project utilizes the latest versions of Docker and Docker Compose. Please make sure your system is at least somewhat up to date with the most recent version of both.

### Starting the containers
The first time you clone down and run the project will require a little bit of initialization work. You will need to build the web server and database images as well a create the development and test databases within the database container. These actions only need to be completed the first time the project is run and can be skipped for all subsequent restarts of the web and database containers.  
**Building from scratch:**
- `docker-compose build`
- `docker-compose up`

In order to create the development and test database you will need to open a new terminal window and run either:  

- `docker-compose run web rake db:create`  
- `docker-compose run web rake db:migrate`  
or  
- `docker exec -it web-server bash`
- `rake db:create && rake db:migrate`

At this point you should be able to view the project at `localhost:3000`. Simply login/register and start creating new posts.

**Subsequent restarts:**
- `docker-compose up`

## Running the test
Testing is composed of RSpec tests with coverage visible via SimpleCov.  

Call `docker-compose run web rspec` to run the tests and then open up `coverage/index.html` in your browser to view the coverage results

## Running the linters
Linting of this project is composed of a set of 5 linters run in sequence: Rails Best Practices, RuboCop, Reek, Flog, Flay.  
To run all of the linters simply call `docker-compose run web ./lint`

## Bonus feature: WebSockets
In order to simulate a realistic environment with several users you can open up the project in multiple separate browser windows and see new posts being dynamically added to the view.

## Future improvements
- Add infinite scroll
- Add Pokemon API caching
  - Cache API calls(Varnish)
  - Cache Pokemon images(S3)
- Move PokemonService to background task(due to slow API)
- Replace front-end with Angular/React and convert project to Rails API

# Original Specifications

## Technical Assessment
- Should be written in Ruby, Python, Javascript, or Node. Any accompanying framework (back-end or front-end) can also be used.
- Please use git and commit throughout the entire process. We want to see all of your commits as you go (even the ones with mistakes). That will help us to get a sense of your thinking process as you work.
- Feel free to use as many libraries as you need to get the job done (this is how we work after all).
- Write enough automated tests to make sure the basic functionality is working. You don’t have to write a full test suite with 100% coverage. Our goal is to see not just that you can write code, but that you can validate that it functions. If Test-driven development helps you build out your code, go for it!
- Write a README outlining how to build and run the app locally, think of it as open-source project.
- We’re not looking for an absolutely complete project. We’re interested in learning how you work over what you get done.  At a minimum, the application should run locally and we should be able to create a post that is stored to a server-side database.
- No consideration needs to be taken for accomodating for different screen sizes and using the fundamentals built into a front-end framework is a-okay.

## What You’re Building

A simplified version of Twitter — with a Pokemon twist.

### Requirements

- Posts
  - Users should be able to submit posts that are stored to a database.
  - All posts should be displayed in a feed on the home page.
  - You can also implement update and delete functionality [optional].
  - Don’t worry about customizing the feed depending on user account. It’s **not** required.
- External Data
  - Here’s the twist — users are anonymized, so each time a post is submitted, a random Pokemon is assigned to the post and shows up as the username.
  - Make a call to the Pokemon API when each post is created to select a random Pokemon name: http://pokeapi.co/ 
- Authentication [optional]
  - Users should be able to create an account, login, and logout.
  - Account management features, like updating email or password, are **not** needed.
  - Posts should be viewable to anonymous users.
