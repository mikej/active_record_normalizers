# frozen_string_literal: true

require "active_support/concern"
require_relative "active_record_normalizers/version"
require_relative "active_record_normalizers/string_and_text_attributes"
require_relative "active_record_normalizers/normalizes_blank_strings_to_nil"
require_relative "active_record_normalizers/strips_leading_and_trailing_whitespace_from_strings"

if defined?(Rails)
  require_relative "active_record_normalizers/railtie"
end
