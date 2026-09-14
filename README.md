# SQL Portfolio - Northwind

This repository contains SQL exercises and analysis using the Northwind database.

## How to run

This repo is self-contained: `northwind.db` is a ready-to-use SQLite database, so there's no setup beyond opening it.

```bash
sqlite3 northwind.db < basic-exercises.sql
```

Or open `northwind.db` directly in any SQLite client (e.g. [DB Browser for SQLite](https://sqlitebrowser.org/)) and run the queries from `basic-exercises.sql` one at a time.

Several exercises include two solutions separated by a `----` divider: an initial attempt followed by a refined one. Exercise 4 is a good example on purpose — its first version undercounts 1997 orders (406 instead of 408) because comparing `OrderDate` against a plain date string with `BETWEEN` silently excludes rows that have a time component on the last day of the range; the second version fixes it with an explicit half-open range (`>= ... AND < ...`).

## 👨‍💻 About Me
I am a Data Analyst with experience in Finance, HR, and Supply Chain analytics.
I am currently strengthening my SQL skills through hands-on practice and real-world datasets.

## 📊 Project Objective
The goal of this project is to:
- Practice SQL fundamentals and advanced queries
- Explore relational databases
- Build a strong SQL portfolio for data analysis roles

## 🗂 Repository Contents
- `basic-exercises.sql`: Contains SQL exercises and queries
- `northwind.db`: SQLite database used for practice

## 💡 Skills Demonstrated
- Data querying (SELECT, WHERE, GROUP BY)
- Joins and relationships between tables
- Aggregations and filtering
- Business-oriented questions

## 🛠 Tools Used
- SQL (SQLite)
- DB Browser for SQLite
- GitHub

## 🚀 Next Steps
- Add more complex queries (JOINs, CTEs)
- Create business case analysis
- Build dashboards using SQL outputs

## 📌 Note
This project is part of my transition into more data-focused roles, strengthening my SQL and data analysis capabilities.
