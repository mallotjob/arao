class PhoneNumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    cleaned = value.to_s.gsub(/\D/, "")

    # Valid Madagascar mobile prefixes
    madagascar_prefixes = ["32", "33", "34", "38", "39", "37"]

    # Valid China mobile prefixes (start with 13, 14, 15, 16, 17, 18, 19)
    china_prefixes = ["13", "14", "15", "16", "17", "18", "19"]

    # Handle Madagascar local format: 0340441586 (10 digits starting with 0)
    if cleaned.start_with?("0")
      if cleaned.length != 10
        record.errors.add(attribute, options[:message] || "must be a valid phone number")
        return
      end
      prefix = cleaned[1, 2]
      unless madagascar_prefixes.include?(prefix)
        record.errors.add(attribute, options[:message] || "must be a valid phone number")
      end
      return
    end

    # Handle Madagascar international format: +261340441586 (country code + 9 digits)
    if cleaned.start_with?("261")
      if cleaned.length != 12
        record.errors.add(attribute, options[:message] || "must be a valid phone number")
        return
      end
      prefix = cleaned[3, 2]
      unless madagascar_prefixes.include?(prefix)
        record.errors.add(attribute, options[:message] || "must be a valid phone number")
      end
      return
    end

    # Handle China international format: +8613812345678 (country code + 11 digits)
    if cleaned.start_with?("86")
      if cleaned.length != 13
        record.errors.add(attribute, options[:message] || "must be a valid phone number")
        return
      end
      prefix = cleaned[2, 2]
      unless china_prefixes.include?(prefix)
        record.errors.add(attribute, options[:message] || "must be a valid phone number")
      end
      return
    end

    # Handle phone numbers without country code (assume local without 0 prefix)
    # Should be 9 digits for Madagascar local number
    if cleaned.length == 9
      prefix = cleaned[0, 2]
      valid_prefixes_without_zero = madagascar_prefixes
      unless valid_prefixes_without_zero.include?(prefix)
        record.errors.add(attribute, options[:message] || "must be a valid phone number")
      end
      return
    end

    # Handle China local format: 13812345678 (11 digits starting with 1)
    if cleaned.length == 11 && cleaned.start_with?("1")
      prefix = cleaned[0, 2]
      unless china_prefixes.include?(prefix)
        record.errors.add(attribute, options[:message] || "must be a valid phone number")
      end
      return
    end

    record.errors.add(attribute, options[:message] || "must be a valid phone number")
  end
end
