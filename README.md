# Instalink

This is a Instalink application built with Ruby on Rails. It provides functionality for managing user, posts, comments, likes and chats, including when the user made a post the location automatically add to users post. This application has its own view in rails native.

## Ruby Version

This application is built with Ruby version **3.3.5**.

## Rails Version

The application uses **Rails 7.2.2**.

## System Dependencies

To run this application, you need the following system dependencies:

- Ruby
- Rails
- PostgreSQL (for database)

## Configuration

### 1. Clone the Repository

Open your terminal and run the following command to clone the repository:

```bash
git clone https://github.com/harendra-pratap/instalink.git
cd instalink
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server
```