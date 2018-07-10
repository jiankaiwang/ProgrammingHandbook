# Quick Reference



## Basic Commands

```sql
/* Login */
$ mongo -–port <27017> –u <acc> -p <pass>

/* List Database / Keyspace */
> show databases

/* Use Database / Keyspace */
> use <dbname>

/* List Table / Collections / Keys */
> show collections

/* Column Info */
> var col_list= db.myCollections.findOne(); 
> for (var col in col_list) { print (col); }

/* create a role to access the database */
> db.createUser({ user:"test", pwd:"test", roles: [ { role: "dbOwner", db : "test" } ] })

/* show all content in the collection */
> db.getCollection("collection_name").find().forEach(printjson)
```



## Database Operations

```sql
/* Create the Database / Keyspace */
> use <dbname>  /* create one if it not exists */

/* Drop the Database */
> db.dropDatabase() /* use db */

/* Create the Collection/Table/Key */
> db.createCollection("name") 

/* Drop the Collection/Table */
> db.Collection.drop()

/* Show the Content */
> db.myCollection.find( { col : val } ).sort( { col : -1 } ).limit(10)
```











