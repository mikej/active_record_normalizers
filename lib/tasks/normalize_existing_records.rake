namespace :db do
  desc "Apply normalizations to existing records"
  task normalize_existing_records: :environment do
    Rails.application.eager_load!

    models = ActiveRecord::Base.descendants.select do |model|
      model.table_exists? && !model.abstract_class? && model.respond_to?(:normalized_attributes)
    end.sort_by { |m| m.name.downcase }

    puts "Found #{models.size} models to process."

    models.each do |model|
      print "Processing #{model.name}... "

      # Get attributes that have normalizations defined
      normalized_attributes = model.normalized_attributes.to_a.map(&:to_s)
      if normalized_attributes.empty?
        puts "No normalized attributes (skipping)."
        next
      end

      updated_count = 0
      model.find_each do |record|
        normalized_attributes.each do |attr|
          # Trigger normalization by re-assigning the current value to attribute
          current_value = record.read_attribute(attr)
          record.send("#{attr}=", current_value)
        end

        # did normalization change anything?
        if record.changed?
          if record.update_columns(record.changes.transform_values(&:last))
            updated_count += 1
          else
            puts "\nFailed to update #{model.name} ID #{record.id}"
          end
        end
      end

      puts "Done. Updated #{updated_count} records."
    end

    puts "Normalization complete."
  end
end
