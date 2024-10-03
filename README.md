# Ruby on Rails Assignment

### Enviroment Setup

$ bundle install

$ bundle db:create

$ bundle db:migrate

$ bundle db:schema:load

$ bundle db:seed


#### Running the app locally

$ foreman start -f Procfile.dev


### LinkClick Admin Path

`/link_clicks`


### Running Tests

$ rails test



### Explanation of your implementation approach

Requirement looks clear for me crucial part for this implementation is the JS code where we have choosen to use
 `navigator.sendBeacon`
 The navigator.sendBeacon() method is used to send small amounts of data to a web server asynchronously. It's typically used for sending analytics or diagnostics data without blocking page navigation, unloading, or performance-sensitive user interactions

### Any assumptions or trade-offs made

### Ideas for future improvements or scaling considerations
1. UI can be made to look better
2. Refactor scopes in  the LinkClick Modal
3. Add more tests


### Items not handled

❌ Implement a rate limiting mechanism to prevent abuse
❌ end-to-end tests


