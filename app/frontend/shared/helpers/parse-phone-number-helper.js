const parsePhoneNumber = (term, countryCode = '261') => {
  if (!term) return null;

  // Remove all non-numeric characters for validation
  const cleaned = term.replace(/\D/g, '');

  // Check if term contains more than just numbers
  const regex = /[^0-9]/;
  const termNotNumber = regex.test(term?.slice(1));

  if (termNotNumber) return null;

  // If term starts with 0, treat it as local number and replace with country code
  if (cleaned.startsWith('0')) {
    return `+${countryCode}${cleaned.slice(1)}`;
  }

  // If term already includes the country code with +, return as is
  if (term.includes(`+${countryCode}`)) {
    return term;
  }

  // If term already includes country code without +, add +
  if (cleaned.startsWith(countryCode)) {
    return `+${cleaned}`;
  }

  // Otherwise, prepend the country code
  return `+${countryCode}${cleaned}`;
};

const isValidPhoneNumber = (term) => {
  if (!term) return false;

  // Remove all non-numeric characters
  const cleaned = term.replace(/\D/g, '');

  // Valid Madagascar mobile prefixes
  const madagascarPrefixes = ['32', '33', '34', '38', '39', '37'];

  // Valid China mobile prefixes (start with 13, 14, 15, 16, 17, 18, 19)
  const chinaPrefixes = ['13', '14', '15', '16', '17', '18', '19'];

  // Handle Madagascar local format: 0340441586 (10 digits starting with 0)
  if (cleaned.startsWith('0')) {
    if (cleaned.length !== 10) return false;
    const prefix = cleaned.substring(1, 3);
    return madagascarPrefixes.includes(prefix);
  }

  // Handle Madagascar international format: +261340441586 (country code + 9 digits)
  if (cleaned.startsWith('261')) {
    if (cleaned.length !== 12) return false;

    const prefix = cleaned.substring(3, 5);
    return madagascarPrefixes.includes(prefix);
  }

  // Handle China international format: +8613812345678 (country code + 11 digits)
  if (cleaned.startsWith('86')) {
    if (cleaned.length !== 13) return false;
    const prefix = cleaned.substring(2, 4);
    return chinaPrefixes.includes(prefix);
  }

  // Handle phone numbers without country code (assume local without 0 prefix)
  // Should be 9 digits for Madagascar local number
  if (cleaned.length === 9) {
    const prefix = cleaned.substring(0, 2);
    return madagascarPrefixes.map(p => p.substring(1)).includes(prefix);
  }

  // Handle China local format: 13812345678 (11 digits starting with 1)
  if (cleaned.length === 11 && cleaned.startsWith('1')) {
    const prefix = cleaned.substring(0, 2);
    return chinaPrefixes.includes(prefix);
  }

  return false;
};

export { parsePhoneNumber, isValidPhoneNumber };
