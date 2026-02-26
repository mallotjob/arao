# 📖 README

* [📖 README](#-readme)
   * [💻 Local development environment setup](#-local-development-environment-setup)
      * [Install Ruby](#install-ruby)
      * [Install dependencies](#install-dependencies)
      * [Setup hostnames in /etc/hosts](#setup-hostnames-in-etchosts)
      * [Setup and Run Postgres](#setup-and-run-postgres)
      * [Start using your local dev environment](#start-using-your-local-dev-environment)
      * [Running tests](#running-tests)
         * [Running E2E tests with Chrome visible](#running-e2e-tests-with-chrome-visible)
         * [Disable RSpec retry](#disable-rspec-retry)
   * [🔨 Practices](#-practices)
      * [✅ Feature Flags](#-feature-flags)
      * [🛡️ Frontend Permission System ](#️-frontend-permission-system)
      * [Annotating model classes](#annotating-model-classes)

## 💻 Development environment setup

The instructions in this section refers to local setup. If you want a have a setup with docker, refer to `docker-setup.md` file.

### Install Ruby

1. Install a ruby version manager, (e.g. [rbenv](https://github.com/rbenv/rbenv) and [ruby-build](https://github.com/rbenv/ruby-build), or [RVM](https://rvm.io/)).

    The main difference on RVM vs RBENV is that:

   - With RVM you can use directly the command (because RVM overwrite host Ruby version). e.g: `rspec ...`

   - With RBENV you need to prefix any command with `bundle exec`. e.g: `bundle exec rspec ...`

2. Install the ruby version specified in `.ruby-version`, for instance

```
rbenv install 3.4.1
```

### Install dependencies

Install node version >= 25.6.1

```
yarn install
bundle install
```

To update yarn find out the [latest version](https://github.com/yarnpkg/berry/releases) and run:
```
yarn set version {version number}
```

To update bundler run:
```
bundle update --bundler
```

### Setup hostnames in /etc/hosts

Add the following lines to your `/etc/hosts` file:

```
127.0.0.1   me.follow.local
127.0.0.1   admin.follow.local
```

### Setup and Run Postgres

Install via brew: `brew install postgres@16`


Create database:

```bash
bin/rails db:create
```

###  Start using your local dev environment

Now you should be able to run rails and rspec command locally.

You can make a test this by running:

```bash
bundle exec rspec path/name_spec.rb
```

To start a server with the required process, use:

```bash
foreman start -e /dev/null
```
### Running tests
Rails related content and the E2E tests are located in `spec` folder, and can be run from rspec command:
```bash
bundle exec rspec path/name_spec.rb
```
Test for frontend are located in `test/unit`. Tests can be run with

```bash
$ yarn test
```

#### Running E2E tests with Chrome visible

To see the Chrome window when running end-to-end tests add the following environment variable to `.env.test.local`

```
HEADLESS=false
```

#### Disable RSpec retry

In order to disable RSpec retry add the following environment variable to `.env.test.local`

```
RSPEC_RETRY_DISABLED=true
```

## 🔨 Practices
### ✅ Feature Flags

In order to use a feature flag in front and backend you first need to create it in `app/models/feature.rb` by adding its name to the `FEATURES` array.

At development stage, you can call `Feature.seed` directly in the console to apply changes.

At deployment stage, we `db:seed` the database. This automatically adds the new features and removes outdated ones.
You can them enable the using ActiveAdmin or the console.

Using the flag in the backend works as follows:

```ruby
if Feature.enabled? :new_feature_1
  ...
end

```

In the frontend you can use the vue plugin:

```javascript
if(this.$features.isEnabled('new_feature_1')) { ... }

```

or use the Vue component:

```
<feature name="new_feature_1">
    Show this if new_feature_1 is enabled

    <template v-slot:fallback>
        Optionally show this new_feature_1 is disabled
    </template>
</feature>

```

### 🛡️ Frontend Permission System

In order to use abilities that are fetched from backend into frontend side,
there are two possible way:

- use conditional rendering control: `v-if="$can( action , className )`,\
  &nbsp;&nbsp;&nbsp;&nbsp;e.g: `v-if = "$can( 'read' , 'user' )`

- wrap around with `Can` component.\
  &nbsp;&nbsp;&nbsp;&nbsp;e.g:

```
<Can i="read" a="company">
...
</Can>
```

Documentation of [vue casl library](https://github.com/stalniy/casl/tree/master/packages/casl-vue) will help you for more complex needs.

### Annotating model classes

To annotate a new model class or to update annotation you can use drwl/annotaterb gem:

```
bundle exec annotaterb models
```
