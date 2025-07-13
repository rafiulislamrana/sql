## Explain the Primary Key and Foreign Key concepts in PostgreSQL.

Primary Key:
Primary Key হলো এমন একটি কলাম যা প্রত্যেক সারিকে ইউনিকভাবে চিহ্নিত করে। এটি null হতে পারে না।

    উদাহরণ:

```sql
CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);
```

Foreign Key:
Foreign Key একটি টেবিলের এমন একটি কলাম, যা অন্য একটি টেবিলের Primary Key এর সাথে সম্পর্ক তৈরি করে।

    উদাহরণ:

```sql
CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INT REFERENCES rangers(ranger_id)
);
```

এখানে sightings.ranger_id একটি Foreign Key, যা rangers.ranger_id এর সাথে সম্পর্কযুক্ত। এটি ডেটার ইন্টিগ্রিটি বজায় রাখে।

---