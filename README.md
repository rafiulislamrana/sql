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
এটি ভ্যারিয়েবল-লেংথ স্ট্রিং। যতটা ডেটা ইনপুট করা হয়, ঠিক ততটাই জায়গা নেয়।

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

## Explain the purpose of the WHERE clause in a SELECT statement.

WHERE ক্লজ ডেটা ফিল্টার করতে ব্যবহৃত হয়। এটি নির্দিষ্ট কন্ডিশন অনুযায়ী শুধুমাত্র কাঙ্ক্ষিত রো (row) রিটার্ন করে। উদাহরণ:

```sql
SELECT * FROM sightings
WHERE location LIKE '%Pass%';
```

এখানে location ফিল্ডে যেসব রো-তে 'Pass' আছে, কেবল সেগুলো রিটার্ন হবে। 

---

## What are the LIMIT and OFFSET clauses used for?

LIMIT এবং OFFSET ক্লজগুলো SQL-এ কুয়েরির রেজাল্ট সেটের আকার নিয়ন্ত্রণ করতে ব্যবহৃত হয়, বিশেষ করে যখন ডেটা অনেক বেশি থাকে এবং আমি শুধু নির্দিষ্ট অংশ দেখতে চাই।

LIMIT: এটি রিটার্ন করা রো এর সর্বোচ্চ সংখ্যা নির্ধারণ করে। উদাহরণ:

```sql
SELECT * FROM sightings LIMIT 5;
```

এই কুয়েরি প্রথম ৫টি রো রিটার্ন করবে।

OFFSET: এটি রেজাল্ট সেট থেকে কতগুলো রো স্কিপ করবে তা নির্ধারণ করে। উদাহরণ:

```sql
SELECT * FROM sightings LIMIT 5 OFFSET 10;
```

এখানে প্রথম ১০টি রো বাদ দিয়ে পরের ৫টি রো দেখাবে।

Pagination বা পেজভিত্তিক ওয়েবসাইটে ডেটা ভাগ করে দেখানোর জন্য LIMIT ও OFFSET খুবই দরকারী।