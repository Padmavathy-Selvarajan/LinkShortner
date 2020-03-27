# LinkShortner

## Setting up the development environment

Read this if you need to set up everything for local development.

**Note:** You probably want to use rvm here to set up a separate gemset for each application, see [https://rvm.io](https://rvm.io).

## Prerequisites

You will need the following packages installed in your system in order to set this up:
- Ruby (2.4.0 and above)
- Rails (4.2.1 and above)
- Postgres (https://www.postgresql.org/download/linux/ubuntu/)

### DB setup & seed


```bash
rake db:create db:migrate 
```

### Starting server


```bash
rails s 
```

### Spec tests

To run all specs:

```bash
rake spec
```

