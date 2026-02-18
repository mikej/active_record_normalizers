module ActiveRecordNormalizers
  module StringAndTextAttributes
    extend ActiveSupport::Concern

    class_methods do
      private

      def string_and_text_column_names
        columns
          .select { |c| c.type.in?([:string, :text]) }
          .reject { |c| c.name == inheritance_column } # avoids STI column
          .map(&:name)
      end
    end
  end
end
