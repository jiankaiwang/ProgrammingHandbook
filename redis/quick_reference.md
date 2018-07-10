# Quick Reference



## Basic Operation

```sql
/* Login */
$ redis-cli -h <host> -p <6379> -a <pass>

/* List Database / Keyspace */
> INFO KEYSPACE

/* Use Database / Keyspace */
> SELECT keyspace-index

/* List Table / Collections / Keys */
> KEYS *

/* Logout */
> exit
```



## Database Operation

```sql
/* Create the Database / Keyspace */
> CONFIG GET DATABASES

/* Drop the Database */
(set /default/path/redis.conf)

/* Create the Collection/Table/Key */
> SET key value EX seconds NX/XX

/* Drop the Collection/Table */
> DEL key

/* Show the Content */
> GET key
```



## Quick Start

```sql
/* create a pair of key-value with the expired time (EX) and check point (NX/XX) */
SET key value
SET key value EX seconds
SET key value EX seconds NX/XX

/* does key exist ? */
EXISTS key
/* data type of key */
TYPE key
/* get the value responding to the key */
GET key
/* show all keys */
KEYS *

/* set the expired time of the key */
EXPIRE key seconds
/* the remaining time of the key */
TTL key
/* delete the pair of the key-value */
DEL key

/* increase the key */
INCR key
/* increase the value of the key by the number */
INCRBY key number
/* decrease the key */
DECR key
/* Decrease the value of the key by the number */
DECRBY key number

/* set multiple each pair of key-value */
MSET key1 value1 [key2 value2]
/* get multiple values corresponding to keys */
MGET key1 key2
```











