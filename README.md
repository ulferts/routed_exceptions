routed_exceptions
=================

Allows ActionDispatch errors to be routed within an rails application. Additionally, it can suppress fatal log entries from being written on routing errors.

Usage
=================

Include the gem into your Gemfile and update your bundle.

Add e.g.
<pre>
    config.routed_exceptions.non_fatal_routing_errors = true
    config.routed_exceptions.in_app_errors = '404'
</pre>

to your ```config/application.rb```. The first option will disable loging routing errors as fatal errors. The second option allows you to specify which status codes you want to route within your application.

Add e.g.

<pre>
  match '/404', to: 'errors#render_404'
</pre>

This will route all 404 errors to the ```render_404``` action of your ```ErrorsController```.

To view the effect in development environment as well as in production environment change

<pre>
  config.consider_all_requests_local = false
</pre>

to

<pre>
  config.consider_all_requests_local = true
</pre>

Start your application, and visit e.g. ```http://localhost:3000/somenonexistenturl``` and the application will serve the action configured in your routes.rb.

License
=================

[MIT](https://github.com/ulferts/routed_exceptions/blob/master/LICENSE)
