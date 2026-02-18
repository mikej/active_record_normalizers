module ActiveRecordNormalizers
  module NormalizesBlankStringsToNil
    extend ActiveSupport::Concern
    include ActiveRecordNormalizers::StringAndTextAttributes

    class_methods do
      def add_normalization_of_blank_strings_to_nil
        return if abstract_class?

        attributes = string_and_text_column_names
        return if attributes.empty?

        normalizes(
          *attributes,
          with: ->(value) { value.presence }
        )
      end
    end
  end
end
