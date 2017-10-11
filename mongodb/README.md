# MongoDB

<script type="text/javascript" src="../js/general.js"></script>

### Commands

```sql
# create a role to access the database
> db.createUser({ user:"test", pwd:"test", roles: [ { role: "dbOwner", db : "test" } ] })

# show all content in the collection
> db.getCollection("collection_name").find().forEach(printjson)
```