## MongoDB Notes ##

## Links ##
Installation
- https://docs.mongodb.com/manual/reference/connection-string/
- https://docs.mongodb.com/guides/server/auth/
- https://docs.mongodb.com/manual/administration/production-notes/
- https://docs.mongodb.com/manual/administration/security-checklist/
- https://www.linode.com/docs/databases/mongodb/create-a-mongodb-replica-set/
- https://docs.mongodb.com/manual/tutorial/deploy-replica-set/
- https://docs.mongodb.com/manual/tutorial/expand-replica-set/

Usage
- https://docs.mongodb.com/manual/reference/operator/
- https://docs.mongodb.com/manual/reference/operator/query/
- https://docs.mongodb.com/manual/reference/command/
- https://www.mongodb.com/collateral/quick-reference-cards

## Mongo Basics ##
Current database

    db

List databases

    show databases

Switch to database 'foo'; this creates the database if it doesn't already
exist

    use foo

List collections in a database

    show collections

**Create** data

    db.myCollection.insert({"name": "john", "age" : 22, "location": "here"})

Also, you can use `insertOne()`, `insertMany()` to insert new records

**Read** data

    db.myCollection.find()

Pretty printed data

    db.myCollection.find().pretty()

Find specific records

    db.myCollection.find({ name: "john" })

**Update** data

    db.myCollection.update({age : 20}, {$set: {age: 23}})

**Delete** data

    db.myCollection.remove({name: "john"});

Delete a database

    db.myCollection.remove({});

## Setting up MongoDB to use Users ##
Start the `mongo` client (with _MongoDB_ authentication disabled)

    mongo

Start the `mongo` client (with _MongoDB_ authentication enabled)

    mongo -u superuser -p --authenticationDatabase admin

Switch to the 'admin' database

    use admin

Create an admin user user ('superuser')

    db.createUser({user: "superuser", pwd: "password", roles:[{role: "root", db: "admin"}]})
Create a normal user ('bob') with access to database 'foo'

    db.createUser({user: "bob", pwd: "password", roles: [{role: "readWrite", db: "foo"}]})

View the users in the 'admin' database

    use admin
    show users

View users in the 'foo' database

    use foo
    show users

## Replica Sets ##
See if the current host is the primary of a replica set

    db.isMaster()

Initiate replication

    rs.initiate()

Add hosts to the replica set as needed

    rs.add("mongo2")
    rs.add("mongo3")
    rs.add( { host: "mongo4:27017", priority: 0, votes: 0 } )

View current replica set configuration

    rs.conf()

View status of all replica sets

    rs.status()

Add data to test replication

    use exampleDB
    for (var i = 0; i <= 10; i++) db.exampleCollection.insert( { x : i } )

Connect to a non-master node, and check replication

    mongo
    db.getMongo().setSlaveOk()
    use exampleDB
    db.exampleCollection.find()
    quit()

vim: filetype=markdown shiftwidth=2 tabstop=2
