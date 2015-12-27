ChattyCatty
===========
A simple demo chat application built using rails and angular js.

#Running a development version
The application is split into two sections frontend app and backend.
The backend is a straight forward Rails app. It uses PG as a db.
Refer to `db/database.yml` for database configuration.

After installing, migrating and running the rails server. change directory to the client directory and run `npm install` and then `bower install`.
After that `npm run dev` you can now find the app on [localhost:8000](http://localhost:8000).

run `npm run deploy` to create a minified version of the app in the rails public folder.

Find production related environment variables [here](https://github.com/ah450/chatty-catty/wiki/Environment-variables)

#Technology

##Websockets

One of the most common use cases advertised for websockets, following notifications,
is chat. Websockets are very efficient if there is frequent bidirectional data exchange.
Perfect for pub/sub use cases such as chat. Faye was used as it has a long polling fallback.


##Sessionless

Keeping our app stateless, means saying goodbye to cookies. A token is sent with requests in a header field when needed. Since we are using a client side framework
such as Angular we can keep track of the user's state client side with no need for server side sessions. This decreases the strain on our server, more noticible with scaling.
 It also eliminates XSRF and session related attack vectors. This app uses JSON
 web tokens.

