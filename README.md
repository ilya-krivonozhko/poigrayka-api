# README

# 🎲 Poigrayka API

![Project Status](https://img.shields.io/badge/Course-In%20Progress-yellow)
![Ruby](https://img.shields.io/badge/Ruby-3.x-red)
![Rails](https://img.shields.io/badge/Rails-8.x-red)
![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-blue)
![License](https://img.shields.io/badge/License-Proprietary-lightgrey)
[![RuboCop](https://img.shields.io/badge/Code%20Style-RuboCop-blue)](https://github.com/rubocop/rubocop)
[![RSpec](https://img.shields.io/badge/Tested%20with-RSpec-brightgreen)](https://rspec.info/)
[![OpenAPI](https://img.shields.io/badge/OpenAPI-3.0-green)](https://editor.swagger.io/?url=https://raw.githubusercontent.com/ilya-krivonozhko/poigrayka-api/main/docs/openapi.json)

## 🇷🇺 Описание (Russian)

> 🚧 **Проект в процессе реализации**

**Poigrayka API** — это RESTful backend для интернет-магазина настольных игр Poigrayka, разработанный на Ruby on Rails в API-режиме.

Это пет-проект для демонстрации навыков и ознакомления с архитектурными решениями.

---

## 🇺🇸 Description (English)

> 🚧 **Project in progress**

**Poigrayka API** is a RESTful backend for the Poigrayka online board games store, built with Ruby on Rails in API-only mode.

This is a pet project for evaluation and demonstration purposes.

---
## 🚀 Getting Started / Как запустить проект
```bash
bundle install
rails db:create db:migrate db:seed
rails s
```

---

## 🧩 Domain Model / Доменная модель
Main entities / Основные сущности :

- User
- Product
- Category
- Cart
- Order
- OrderItem
- Favorite

---

## 📘 API Documentation

The API is documented using **OpenAPI 3.0**.

- [**OpenAPI spec (YAML)**](
  https://raw.githubusercontent.com/ilya-krivonozhko/poigrayka-api/main/docs/openapi.yaml)
- [**Swagger Editor (interactive)**](
  https://editor.swagger.io/?url=https://raw.githubusercontent.com/ilya-krivonozhko/poigrayka-api/main/docs/openapi.yaml)

---

## 📦 API Versioning

The API is versioned using a URL namespace:

`/api/v1/...`

---

## ⚙️ Tech Stack / Технологический стек

- Ruby 3.x
- Ruby on Rails 8.x (API-only)
- PostgreSQL
- RSpec
- RuboCop
- OpenAPI 3.0
- Devise JWT

---

## 📄 License / Лицензия

This project is proprietary and published for demonstration purposes only.
See the [LICENSE](LICENSE) file for details.