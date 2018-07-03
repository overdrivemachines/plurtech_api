# README

$ rails new plurtech_api --api -T
$ rails g scaffold user name email username phone

Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Testing
```bash
# GET    /articles
$curl 0.0.0.0:3000

# POST   /articles
$curl -d '{"title":"test1", "content":"lorem"}' -H "Content-Type: application/json" -X POST http://0.0.0.0:3000/articles

# GET    /articles/:id
$curl 0.0.0.0:3000/articles/1

# PATCH  /articles/:id
$curl -d '{"title":"test5", "content":"lorem5"}' -H "Content-Type: application/json" -X PATCH http://0.0.0.0:3000/articles/5


# PUT    /articles/:id

# DELETE /articles/:id
```
