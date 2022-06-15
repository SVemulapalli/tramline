# README

The primary orchestration and frontend monolith.

## Development Setup

For local development on Mac, clone the git repository and run the setup script included:

```bash
git clone git@github.com:tramlinehq/site.git
cd site
bin/setup.mac
```

Note: If you already have a previous dev environment you're trying to refresh, it's easiest to drop your database run setup again.

```bash
rails db:drop
bin/setup.mac
```

Refer to `db/seeds.rb` for credentials on how to login using the seed users.

## Developer Notes

### SSL

We use SSL locally and as a part of the setup script certificates are also generated. It's recommended to use `https://local.tramline.gd:3000`. This is the default `HOST_NAME` that can be changed via `.env.development` if necessary.

### Letter Opener

All e-mails are caught and can be viewed at http://localhost:3000/letter_opener.

### Sidekiq

The dashboard for all background jobs can be viewed at http://localhost:3000/sidekiq.

### Flipper

All feature-flags are managed through flipper. The UI can be viewed at: http://localhost:3000/flipper. 

## Webhooks

Webhooks need access to the application over internet and it require tunneling on localhost environment. It's recommened to use ngrok and set the ngrok URL as `WEBHOOK_HOST_NAME` 
in .env.development

```
ngrok http https://localhost:3000
```

### Adding or updating gems

* Use `bundle add <gem>` to add a new gem.
* To update a gem use `bundle update <gem>`.

Using the `bundle add` tool auto-applies the [pessimistic operator](https://thoughtbot.com/blog/rubys-pessimistic-operator) in the `Gemfile`. Although `Gemfile.lock` is the correct source of gem versions, specifying the pessimistic operator makes for a simpler and safer update path through bundler for future users.

Doing this for development/test groups is optional.
