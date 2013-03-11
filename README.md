Adhearsion Rails Caller
================

A load test caller with a web UI based on Adhearsion and Rails


This is an adhearsion and ruby on rails app, so both things must be configured and setup properly.  Learn more about that here [Adhearsion Setup](http://adhearsion.com/docs/getting-started/prerequisites).

Adhearsion and Rails run separately and communicate through DRb.  The plugin is found here [adhearsion-drb](https://github.com/adhearsion/adhearsion-drb).  This application is currently using 127.0.0.1 as the IP and 9050 as the port.  

Please fully read and configure `config/adhearsion.rb`

Key files for Rails are `app/controllers/calls_controller.rb` , `app/views/calls/index.html.erb`, and `config/routes.rb`

Currently there is no Model on the rails app, so DB configuration is unnecessary.

The Adhearsion part of the application hooks into asterisk and the config for adhearsion is in config/adhearsion.rb

An example of apache configuration for the rails app.


	<VirtualHost *:80>
	     ServerName exampleapp.com
	     DocumentRoot /var/www/ahn-rails-caller/public/
	     RailsEnv development
	     <Directory /var/www/ahn-rails-caller/public>
	        AllowOverride all
	        Options -MultiViews
	     </Directory>
	 </VirtualHost>