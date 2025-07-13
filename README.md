## Explain the Primary Key and Foreign Key concepts in PostgreSQL.

Primary Key:
Primary Key হলো এমন একটি কলাম যা প্রত্যেক সারিকে ইউনিকভাবে চিহ্নিত করে। এটি null হতে পারে না। উদাহরণ:

```sql
CREATE TABLE rangers (
  ranger_id SERIAL PRIMARY KEY,
  name VARCHAR(100)
);
```

Foreign Key:
Foreign Key একটি টেবিলের এমন একটি কলাম, যা অন্য একটি টেবিলের Primary Key এর সাথে সম্পর্ক তৈরি করে। উদাহরণ:

```sql
CREATE TABLE sightings (
  sighting_id SERIAL PRIMARY KEY,
  ranger_id INT REFERENCES rangers(ranger_id)
);
```

এখানে sightings.ranger_id একটি Foreign Key, যা rangers.ranger_id এর সাথে সম্পর্কযুক্ত। এটি ডেটার ইন্টিগ্রিটি বজায় রাখে।

---

## What is the difference between the VARCHAR and CHAR data types?

VARCHAR(n):
এটি ভ্যারিয়েবল-লেংথ স্ট্রিং। যতটা ডেটা ইনপুট করা হয়, ঠিক ততটাই জায়গা নেয় (সর্বোচ্চ n পর্যন্ত)।

CHAR(n):
এটি ফিক্সড-লেংথ স্ট্রিং। ইনপুট ছোট হলেও, n সংখ্যক ক্যারেক্টার স্পেস রিজার্ভ করে। ঘাটতি পূরণে স্পেস যোগ হয়।

```sql
-- VARCHAR
name VARCHAR(10); -- 'Cat' = 3 bytes only

-- CHAR
code CHAR(10);    -- 'Cat' = 3 characters + 7 spaces
```

পারফরম্যান্স পার্থক্য সাধারণত ছোট, তবে VARCHAR অধিক ফ্লেক্সিবল।

---