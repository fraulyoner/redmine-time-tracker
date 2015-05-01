# Redmine Time Tracker

Allows time tracking through accessing the Redmine API.

# Usage

Download the project, create a MySQL database and start the application with the Maven Jetty plugin.

## Download

[Download the latest release](https://github.com/murygina/redmine-time-tracker/releases/tag/v0.1.0)

<b>OR</b>

Clone the repository:
<pre>
git clone https://github.com/murygina/redmine-time-tracker.git
</pre>

## Getting started

Run
<pre>
mvn clean jetty:run
</pre>

You can access the application now under the URL `localhost:2342`.
Now you're ready to create events that you can track later in your Redmine/ChiliProject.
The data is stored in a database file in your project directory under `db` directory.

## Configuration

Click the navigation point "Konfiguration" to add your custom Redmines/ChiliProjects.
You have to provide your API key to be able to access the information through the Redmine API.

Please note that accessing the time entry activities through the Redmine API is possible only for Redmine version >= 2.2
(see [Redmine Rest API Documentation](http://www.redmine.org/projects/redmine/wiki/Rest_api))
For lower versions the time entry activities must be persisted with their Redmine ID in your database.

# License

The code is released under the [MIT license](https://github.com/murygina/redmine-time-tracker/blob/master/LICENSE).
