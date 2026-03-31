# 🚚 Follow - Product & Shipping Management Platform

A modern Rails 8 + Vue.js application for managing products, shipping, and multi-tenant operations with comprehensive user management and internationalization support.

## ✨ Features

- **Multi-tenant Architecture** - Separate admin and user portals with subdomain routing
- **Product Management** - Complete product lifecycle with state machine (pending → confirmed → shipped → completed → delivered)
- **User Authentication** - Devise-based authentication with company associations
- **Internationalization** - Support for English, French, Malagasy, and Chinese (Simplified)
- **Modern Frontend** - Vue 3 + PrimeVue + TailwindCSS with Vite build system
- **Feature Flags** - Dynamic feature toggling for controlled rollouts
- **Permission System** - Role-based access control with CASL integration
- **Versioned API** - RESTful APIs with JSON responses and version control
- **Docker Support** - Containerized deployment with Kamal
- **Comprehensive Testing** - RSpec for backend, Vitest for frontend
- **Code Quality** - ESLint, RuboCop, and pre-commit hooks

## 🏗️ Architecture Overview

### Application Structure

```
arao/
├── app/
│   ├── controllers/          # Rails controllers
│   │   ├── admin/           # Admin portal controllers
│   │   │   └── api/       # Versioned API controllers
│   │   │       └── v1/    # V1 API namespace
│   │   │           ├── base_controller.rb
│   │   │           ├── users_controller.rb
│   │   │           ├── companies_controller.rb
│   │   │           ├── products_controller.rb
│   │   │           └── roles_controller.rb
│   │   └── concerns/        # Shared controller concerns
│   ├── models/              # ActiveRecord models
│   │   ├── concerns/        # Model concerns
│   │   ├── application_record.rb
│   │   ├── user.rb          # User authentication with Devise
│   │   ├── company.rb       # Company management
│   │   ├── product.rb       # Product lifecycle with AASM
│   │   └── ...
│   ├── serializers/         # API serializers
│   │   ├── application_serializer.rb
│   │   └── admin/
│   │       └── api/
│   │           └── v1/    # V1 serializers namespace
│   │               ├── user_serializer.rb
│   │               ├── company_serializer.rb
│   │               ├── product_serializer.rb
│   │               ├── role_serializer.rb
│   │               ├── permission_serializer.rb
│   │               ├── balance_serializer.rb
│   │               ├── shipping_time_serializer.rb
│   │               └── type_config_serializer.rb
│   ├── frontend/            # Vue.js frontend
│   │   ├── admin/           # Admin portal Vue components
│   │   ├── me/              # User portal Vue components
│   │   ├── shared/          # Shared Vue components
│   │   ├── baseElements/    # Reusable UI elements
│   │   ├── i18n/           # Internationalization files
│   │   └── entrypoints/    # Vite entry points
│   └── views/              # Rails ERB templates
├── config/                 # Rails configuration
│   ├── routes.rb           # Multi-tenant routing with API versioning
│   ├── locales/           # I18n translation files
│   └── environments/      # Environment-specific configs
├── db/                    # Database migrations and seeds
├── spec/                  # RSpec tests (backend)
├── test/                  # Vitest tests (frontend)
└── docker/                # Docker configuration
```

### Backend (Rails 8)

- **Ruby 3.4.1** with modern Rails 8 features
- **PostgreSQL** database with UUID primary keys
- **Authentication**: Devise with custom login (email/username)
- **State Management**: AASM for product workflows
- **Permissions**: CanCanCan for authorization
- **API Versioning**: Namespaced V1 API controllers and serializers
- **Caching**: Solid Cache and Solid Queue
- **Deployment**: Kamal with Docker support

### Frontend (Vue 3)

- **Vue 3.5** with Composition API
- **UI Framework**: PrimeVue with TailwindCSS
- **Build Tool**: Vite 6.x for fast development
- **Testing**: Vitest with Histoire for component stories
- **Icons**: FontAwesome integration
- **Internationalization**: Vue I18n

### Multi-Tenant Structure

- **Admin Portal** (`admin.follow.local`) - Administrative interface
- **User Portal** (`me.follow.local`) - User-facing application
- **Versioned APIs** - RESTful endpoints under `/admin/api/v1/*`

---

## 📋 Table of Contents

- [🚀 Quick Start](#-quick-start)
- [💻 Development Environment Setup](#-development-environment-setup)
  - [Prerequisites](#prerequisites)
  - [Installation Steps](#installation-steps)
  - [Database Setup](#database-setup)
  - [Running the Application](#running-the-application)
- [🧪 Testing](#-testing)
  - [Backend Tests](#backend-tests)
  - [Frontend Tests](#frontend-tests)
  - [E2E Tests](#e2e-tests)
- [🔧 Development Practices](#-development-practices)
  - [Feature Flags](#feature-flags)
  - [Permission System](#permission-system)
  - [API Versioning](#api-versioning)
  - [Code Quality](#code-quality)
  - [Model Annotations](#model-annotations)
- [📚 API Documentation](#-api-documentation)
- [🚀 Deployment](#-deployment)
- [🛠️ Troubleshooting](#️-troubleshooting)

---

## 🚀 Quick Start

```bash
# Clone and setup
git clone <repository-url>
cd arao

# Install dependencies (REQUIRED FIRST)
bundle install
yarn install

# Setup database and start app
bin/rails db:create db:migrate db:seed
foreman start -e /dev/null
```

Visit `http://me.follow.local:5000` or `http://admin.follow.local:5000` after setting up hosts.

---

## 💻 Development Environment Setup

### Prerequisites

Before starting, ensure you have these base dependencies installed:

- **Ruby 3.4.1** (use `.ruby-version`)
- **Node.js >= 25.6.1**
- **PostgreSQL 16**
- **Yarn** (latest Berry version)
- **Git**

### Step 1: Install Development Dependencies

#### 1.1 Install Ruby Version Manager

Choose one:

- **rbenv** + ruby-build (recommended)
- **RVM**

```bash
# With rbenv
rbenv install 3.4.1
rbenv local 3.4.1

# With RVM
rvm install 3.4.1
rvm use 3.4.1
```

#### 1.2 Install Application Dependencies

```bash
# Install Ruby gems
bundle install

# Install Node.js packages
yarn install

# Update tools if needed
yarn set version latest
bundle update --bundler
```

#### 1.3 Verify Dependencies

```bash
# Verify Ruby version
ruby -v  # Should show 3.4.1

# Verify Node.js version
node -v  # Should be >= 25.6.1

# Verify Yarn version
yarn -v

# Verify gems are installed
bundle list
```

### Step 2: Configure Environment

#### 2.1 Setup Local Hostnames

Add to `/etc/hosts`:

```bash
127.0.0.1   me.follow.local
127.0.0.1   admin.follow.local
```

#### 2.2 Environment Configuration

Create environment files as needed:

- `.env.development.local`
- `.env.test.local`

### Step 3: Database Setup

```bash
# Install PostgreSQL (macOS)
brew install postgres@16
brew services start postgres@16

# Create and setup database
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed
```

### Step 4: Start Development Server

```bash
# Start all services (web, vite, workers)
foreman start -e /dev/null

# Or start individually
bin/rails server
yarn dev
```

Access the application:

- **User Portal**: http://me.follow.local
- **Admin Portal**: http://admin.follow.local
- **Health Check**: http://localhost:3000/up

---

## 🧪 Testing

### Backend Tests (RSpec)

```bash
# Run all tests
bundle exec rspec

# Run specific test file
bundle exec rspec spec/path/name_spec.rb

# Run with coverage
bundle exec rspec --format documentation
```

### Frontend Tests (Vitest)

```bash
# Run all frontend tests
yarn test

# Run in watch mode
yarn test --watch

# Run with coverage
yarn test --coverage
```

### E2E Tests

```bash
# Run E2E tests
bundle exec rspec spec/features/

# With visible Chrome (add to .env.test.local)
echo "HEADLESS=false" >> .env.test.local

# Disable RSpec retry (add to .env.test.local)
echo "RSPEC_RETRY_DISABLED=true" >> .env.test.local
```

---

## 🔧 Development Practices

### Feature Flags

Create and manage feature toggles for controlled releases:

1. **Add feature to `app/models/feature.rb`**:

   ```ruby
   FEATURES = %w[existing_feature new_feature_1].freeze
   ```

2. **Seed features**:

   ```ruby
   # In console
   Feature.seed

   # Automatically deployed via db:seed
   ```

3. **Backend usage**:

   ```ruby
   if Feature.enabled?(:new_feature_1)
     # New functionality
   end
   ```

4. **Frontend usage**:

   ```javascript
   // Composable
   if(this.$features.isEnabled('new_feature_1')) { ... }

   // Component
   <feature name="new_feature_1">
     New content
     <template v-slot:fallback>
       Fallback content
     </template>
   </feature>
   ```

### Permission System

Role-based access control using CASL:

#### Backend (CanCanCan)

```ruby
# In ability.rb
can :read, Company if user.admin?
can :manage, User, company_id: user.company_id
```

#### Frontend (Vue CASL)

```javascript
// Directive
v-if="$can('read', 'user')"

// Component
<Can do="read" on="user">
  Protected content
</Can>
```

### API Versioning

The application uses versioned APIs to ensure backward compatibility and future evolution:

#### V1 API Structure

```ruby
# Controllers namespaced under Admin::Api::V1
module Admin
  module Api
    module V1
      class UsersController < BaseController
        # V1 API methods
      end
    end
  end
end

# Serializers namespaced under Admin::Api::V1
module Admin
  module Api
    module V1
      class UserSerializer < ApplicationSerializer
        # V1 serialization logic
      end
    end
  end
end
```

#### API Endpoints

```bash
# All V1 endpoints use the /api/v1 prefix
GET    /admin/api/v1/users
POST   /admin/api/v1/users
PATCH  /admin/api/v1/users/:id
DELETE /admin/api/v1/users/:id

GET    /admin/api/v1/companies
POST   /admin/api/v1/companies
PATCH  /admin/api/v1/companies/:id
DELETE /admin/api/v1/companies/:id

GET    /admin/api/v1/products
POST   /admin/api/v1/products
PATCH  /admin/api/v1/products/:id
DELETE /admin/api/v1/products/:id
PATCH  /admin/api/v1/products/:id/status
```

#### Frontend API Client

```javascript
// Updated to use V1 endpoints
export default {
  getUsers: () => axiosApiInstance.get('/api/v1/users'),
  getCompanies: () => axiosApiInstance.get('/api/v1/companies'),
  getProducts: () => axiosApiInstance.get('/api/v1/products'),
  // ... other V1 endpoints
};
```

### Code Quality

#### Pre-commit Hooks

- **ESLint**: Auto-fixes JavaScript/Vue issues
- **RuboCop**: Enforces Ruby style guidelines
- **Lint-staged**: Runs only on changed files

#### Manual Checks

```bash
# Backend linting
bundle exec rubocop

# Frontend linting
yarn lint

# Security scanning
bundle exec brakeman
```

### Model Annotations

Keep model documentation current:

```bash
# Generate/update annotations
bundle exec annotaterb models
```

---

## 📚 API Documentation

### Authentication

All API endpoints require authentication via Devise tokens.

### V1 API Endpoints

#### Users API

```bash
# Get current user
GET /admin/api/v1/users/me

# Get user statistics
GET /admin/api/v1/users/me/stats

# List users
GET /admin/api/v1/users

# Create user
POST /admin/api/v1/users

# Update user
PATCH /admin/api/v1/users/:id

# Update user password
PATCH /admin/api/v1/users/:id/password

# Delete user
DELETE /admin/api/v1/users/:id
```

#### Companies API

```bash
# List companies
GET /admin/api/v1/companies

# Create company
POST /admin/api/v1/companies

# Update company
PATCH /admin/api/v1/companies/:id

# Delete company
DELETE /admin/api/v1/companies/:id
```

#### Products API

```bash
# List products
GET /admin/api/v1/products

# Create product
POST /admin/api/v1/products

# Update product
PATCH /admin/api/v1/products/:id

# Update product status
PATCH /admin/api/v1/products/:id/status

# Delete product
DELETE /admin/api/v1/products/:id
```

#### Roles API

```bash
# List roles
GET /admin/api/v1/roles

# Create role
POST /admin/api/v1/roles

# Update role
PATCH /admin/api/v1/roles/:id

# Delete role
DELETE /admin/api/v1/roles/:id
```

### Response Format

All APIs return JSON with consistent structure:

```json
{
  "id": 1,
  "name": "Company Name",
  "created_at": "2024-01-01T00:00:00Z",
  "updated_at": "2024-01-01T00:00:00Z",
  "user_count": 5,
  "products_by_status": {
    "pending": 2,
    "confirmed": 3,
    "shipped": 1,
    "completed": 4,
    "delivered": 0
  }
}
```

### Error Response Format

```json
{
  "error": "Validation failed: Email has already been taken"
}
```

---

## 🚀 Deployment

### Docker Deployment

```bash
# Build image
docker build -t follow .

# Run with Docker Compose
docker-compose up -d
```

### Kamal Deployment

```bash
# Deploy to production
bundle exec kamal deploy

# Deploy to staging
bundle exec kamal deploy -e staging
```

### Environment Variables

Key environment variables:

- `DATABASE_URL` - PostgreSQL connection
- `SECRET_KEY_BASE` - Rails secret key
- `RAILS_ENV` - Environment (production/staging)

---

## 🛠️ Troubleshooting

### Common Issues

#### Ruby Version Conflicts

```bash
# Clear bundler cache
bundle clean --force
bundle install
```

#### Node Modules Issues

```bash
# Clean install
rm -rf node_modules yarn.lock
yarn install
```

#### Database Connection

```bash
# Reset database
bin/rails db:drop db:create db:migrate db:seed
```

#### Asset Compilation

```bash
# Clear assets
bin/rails assets:clean
bin/rails assets:precompile
```

### Getting Help

1. Check logs: `tail -f log/development.log`
2. Run health check: `curl http://localhost:3000/up`
3. Verify database: `bin/rails db:migrate:status`
4. Test API endpoints: `curl -H "Accept: application/json" http://admin.follow.local:5000/api/v1/users`

---

## 📄 License

This project is proprietary software. All rights reserved.

## 🤝 Contributing

Internal contributors should follow the established coding standards and testing requirements outlined in this document.
