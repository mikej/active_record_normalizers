module ActiveRecordNormalizers
  module StripsLeadingAndTrailingWhitespaceFromStrings
    extend ActiveSupport::Concern
    include ActiveRecordNormalizers::StringAndTextAttributes

    class_methods do
      def add_stripping_of_leading_and_trailing_whitespace_from_strings
        return if abstract_class?

        attributes = string_and_text_column_names
        return if attributes.empty?

        normalizes(
          *attributes,
          with: ->(value) { value.present? ? value.strip : value }
        )
      end
    end
  end
end
