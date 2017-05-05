## Testing Beastly Bugs via cURL ##

cURL usage:
- `--verbose` switch in cURL: http://stackoverflow.com/questions/3252851
- `--request` switch in cURL: http://superuser.com/questions/149329
- https://gist.github.com/subfuzion/08c5d85437d5d4f00e58


### GET requests ###
Calling HTTP GET on `/foo`, returning HTML or JSON

    # HTML
    curl --verbose --request GET http://127.0.0.1:3001/foo
    curl --verbose --request GET http://127.0.0.1:3001/foo?format=html
    curl --verbose --request GET http://127.0.0.1:3001/foo \
      --header "Accept: text/html"

    # JSON
    curl --verbose --request GET http://127.0.0.1:3001/foo.json
    curl --verbose --request GET http://127.0.0.1:3001/foo?format=json
    curl --verbose --request GET http://127.0.0.1:3001/foo \
      --header "Accept: application/json"


### POST requests ###
Calling a POST URL:

    # HTML
    curl --verbose --request POST http://127.0.0.1:3001/foo
    curl --verbose --request POST http://127.0.0.1:3001/foo.html

    # JSON
    curl --verbose --request POST http://127.0.0.1:3001/users/foo.json


Calling a POST URL with HTTP headers determining the response:

    # HTML
    curl --verbose --request POST http://127.0.0.1:3001/bop \
      --header "Accept: text/html"

    # JSON
    curl --verbose --request POST http://127.0.0.1:3001/bop \
      --header "Accept: application/json"


Calling a POST URL with "application/x-www-form-urlencoded" data; note that
`cURL` assumes _POST_ when the `--request` flag is used, so you don't need it
in that case

    # HTML
    curl --verbose --data data=bop http://127.0.0.1:3001/foo.html
    curl --verbose --data data=bop http://127.0.0.1:3001/foo \
      --header "Accept: text/html"

    # JSON
    curl --verbose --data data=bop http://127.0.0.1:3001/foo.json
    curl --verbose --data data=bop http://127.0.0.1:3001/foo \
      --header "Accept: application/json"

Calling a POST URL with JSON data, expecting different types of responses

    # JSON data, HTML response
    curl --verbose --data '{"data": "bop"}' \
      --header 'Content-Type: application/json' \
      http://127.0.0.1:3001/foo.html
    curl --verbose --data '{"data": "bop"}' \
      --header 'Content-Type: application/json' \
      --header "Accept: text/html" \
      http://127.0.0.1:3001/foo

    # JSON data, JSON response
    curl --verbose --data '{"data": "bop"}' \
      http://127.0.0.1:3001/foo.json
    curl --verbose --data '{"data": "bop"}' \
      --header 'Content-Type: application/json' \
      --header "Accept: application/json" \
      http://127.0.0.1:3001/foo

Calling a POST URL with a JSON file, expecting different types of responses


    # JSON data, HTML response
    curl --verbose --data "@data.json" \
      --header 'Content-Type: application/json' \
      http://127.0.0.1:3001/foo.html
    curl --verbose --data "@data.json" \
      --header "Accept: text/html" \
      --header 'Content-Type: application/json' \
      http://127.0.0.1:3001/foo.html

    # JSON data, JSON response
    curl --verbose --data "@data.json" \
      --header 'Content-Type: application/json' \
      http://127.0.0.1:3001/foo.json
    curl --verbose --data "@data.json" \
      --header 'Content-Type: application/json' \
      --header "Accept: application/json" \
      http://127.0.0.1:3001/foo

Sample data

    {"data": [
      {
         "path": "test.example.foo",
         "value": "42",
         "epoch_time": "1492808743"
      },
      {
         "path": "test.example.bar",
         "value": "41.5",
         "epoch_time": "1492808743"
       },
    ]}

vim: filetype=markdown shiftwidth=2 tabstop=2
