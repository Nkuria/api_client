# Name

API CLIENT

# Description

This is a simple app that demonstartes the functionality of an api client. The api client can be inherited to consume or interact with any api

## Configuration

The is no special configuration required to run the app. You just need to have ruby and rails installed in your system. From there just clone the app and run the migrations

## Tools / gems used
- Ruby & Ruby on Rails
- sqlite3
- Minitest for tests
- Webmock to stub / mock api calls
- Net/http to make the api requests
- [football-data.org](https://www.football-data.org/) for the football API


# How it works
- There is a an ApplicationClient class that contains the abstrction that makes the actual request.
- You'll just need to run: ``` rails generate api_client sample_client ``` to create a client that inherits from the ApplicationClient. You'll need to replace ``` sample_client ``` with the actual name of the client. The generator will also generate the respective test class
- You can now interact with any api by calling either ``` get / post / patch / put / delete ``` in your client with the required parameters
- In order to test the football api client, you'll need to sign up to [football-data.org](https://www.football-data.org/) and generate your own ``` X-Auth-Token ``` to use for testing

