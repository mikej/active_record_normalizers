require "rails/railtie"

module ActiveRecordNormalizers
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.expand_path("../tasks/normalize_existing_records.rake", __dir__)
    end
  end
end
