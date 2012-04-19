# About
## Introduction
This is a sample, and simple Ruby on Rails Application used by Ryan Schmukler to introduce others to the Ruby on Rails Framework.
## What it Does
The application we are building will server as a way for people to vote for ideas about which topic they would like to hear a talk on next.
## Additional Resources
This guide is by no means comprehensive. Below see a list of additional resources I would recommend checking out.

* Start with [the official rails guide](http://guides.rubyonrails.org/getting_started.html).
* Ryan Bates' excellent [Railscasts Series](railscasts.com)


## Important Rails Directories and Files:

* __app/assets__ - Where your JS/CSS/Images go
* __app/[controllers||models||views]__ - Where your controller/model/view code goes
* __config/database.yml__ - Handles configuration of databases. Default is a SQLite database in a local file.
* __config/routes.rb__ - Handles mapping requests to controller actions.
* __config/application.rb__ - General config file loaded in all environments
* __config/environments/development.rb__ - configuration file for when in development mode
* __config/environments/production.rb__ - configuration file for when in in production mode
* __Gemfile__ - Used by bundler to set dependencies for your application
* __public/*__ - used to serve static assets (404, static HTML, etc.)
* __vendor/assets/*__ - where other people's JS/CSS/Images go (eg. jQuery)

# Application Steps

## 1) Getting Started

### Create the Application
Start by using the rails command to generate a new application. It follows the general syntax:

    rails new <app_name>

We will use:

     rails new voter -T

This will create a new rails application with the standard files. The -T flag simply skips including the test suite. There is are a lot of files generated when we do this. See above for some of the most important.

### Fire up the server

Let's check out rails! We can start the server by running:

		rails server
		
and then visiting [http://localhost:3000](http://localhost:3000)

### Delete the default index.html
Right now we see a splash page. Let's get rid of it.
		rm public/index.html

### Checkout app/views/layouts/application.html.erb
application.html.erb is the default layout for new rails applications. Layouts are views that embed other views within them. They generally include things you want on every page such as a navbar or logo.




## 2) Create Some Talks
### Generate the Talk Resource
Because we want to be able to vote on the next talk, we will need to want an object to store potential talks in the database. In this case we will create a talk resource with a title and description.

		rails g resource talk

Generating a resource automatically generates the following files:

* __app/models/talk.rb__ - Talk model file
* __db/migrate/<date>_create_talks.rb__ - Talk database migration file. Takes care of applying the schema changes to the DB
* __app/controllers/talks_controller___ - Talk controller
* __app/views/talks__ - views directory for controller actions
* __app/assets/javascripts/talks.js.coffee__ - coffeescript file for related CoffeeScript
* __app/assets/stylesheets/talks.css.scss__ - SCSS for related CSS

It also adds the following line to routes.rb
		
		resources talks

To see what that line does, run:
		
		rake routes

We see that rails has taken care of creating some RESTful routes and mapping them to controller actions (methods):

		    talks GET    /talks(.:format)          {:action=>"index", :controller=>"talks"}
		          POST   /talks(.:format)          {:action=>"create", :controller=>"talks"}
		 new_talk GET    /talks/new(.:format)      {:action=>"new", :controller=>"talks"}
		edit_talk GET    /talks/:id/edit(.:format) {:action=>"edit", :controller=>"talks"}
		     talk GET    /talks/:id(.:format)      {:action=>"show", :controller=>"talks"}
		          PUT    /talks/:id(.:format)      {:action=>"update", :controller=>"talks"}
		          DELETE /talks/:id(.:format)      {:action=>"destroy", :controller=>"talks"}

To apply the schema changes to the database, run the following:

			rake db:migrate

### Create some Views

#### index view
Using RESTful standards, we want this view to display a list of all of the talks available. This is the main view when visiting and then visiting [http://localhost:3000/talks](http://localhost:3000/talks)

_app/views/talks/index.html.erb_

		<h1>Available Talks</h1>
		<div class="talks">
		  <%= render @talks %>
		</div>

We use the render command to tell the application to render a partial. A partial is something that we would like to keep in a separate file to make it easy to modify and adhere to DRY principles.
All partials start with an \_. The render command will automatically look for a partial of the same name as the variable passed to it. In this case, it will look for a partial named `app/views/talks/_talk.html.erb`. Let's write it now

_app/views/talks/\_talk.html.erb_

		<div class="talk">
		  <h2><%= talk.title %></h2>
		  <p><%= talk.description %></p>
		</div>

The render command used above automatically iterates over all of the Talk objects in `@talks` and passes them into the partial with the instance variable `talk`. This is because rails uses conventions over configuration. In reality it is actually a shorthand for the following:

			<%= render :partial => "talk", :collection => @talk, :as => :talk %>

#### index controller
Now, we actually need to take care of passing the `@talks` variable to the view for rendering. Using the output of `rake routes` above we can see that we need to edit the `index` method of `app/controllers/talks_controller.rb`

_app/controllers/talks\_controller.rb_

		def index
	    @talks = Talk.all
	  end

The `Talk` object is defined in `app/models/talk.rb`. By simply extending the `ActiveRecord::Base` class it inherits the `Talk.all` method and will pull all database records.


## 3) User Authentication and Sign Up

To ensure that users don't vote more than once, we want to be able to authenticate them.

### Generate the User Model
We will make a simple user model with a username and an encrypted password hash.
To make this, we will use the rails generate command. 

		rails generate model User username:string encrypted_password:string admin:boolean

This generates a few files.

		db/migrate/<date>_create_users.rb - Database migration file. Creates SQL tables
		app/models/user.rb - User class file. Note that it extends active record.

### 

### Make the User


