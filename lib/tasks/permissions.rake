namespace :permissions do
  desc "Generate permissions for all models"
  task generate: :environment do
    Rails.application.eager_load!
    Permission.generate_for_models
  end
end
