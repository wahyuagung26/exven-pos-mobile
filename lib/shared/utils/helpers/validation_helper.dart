/// Input validation utilities for common validation tasks
/// 
/// This file contains utility functions for validating various input types
/// including email, phone numbers, passwords, and business-specific validations.

/// Validation helper utility class with static methods
class ValidationHelper {
  ValidationHelper._(); // Private constructor to prevent instantiation
  
  /// Regular expressions for common validations
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  
  static final RegExp _phoneRegex = RegExp(
    r'^(\+62|62|0)[0-9]{8,13}$',
  );
  
  static final RegExp _alphabeticRegex = RegExp(r'^[a-zA-Z\s]+$');
  static final RegExp _alphanumericRegex = RegExp(r'^[a-zA-Z0-9\s]+$');
  static final RegExp _numericRegex = RegExp(r'^\d+$');
  static final RegExp _decimalRegex = RegExp(r'^\d+(\.\d+)?$');
  
  static final RegExp _urlRegex = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
  );
  
  static final RegExp _indonesianNameRegex = RegExp(r"^[a-zA-Z\s.']+$");
  
  /// Validate email address
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }
    
    final trimmedEmail = email.trim();
    
    if (!_emailRegex.hasMatch(trimmedEmail)) {
      return 'Format email tidak valid';
    }
    
    if (trimmedEmail.length > 254) {
      return 'Email terlalu panjang (maksimal 254 karakter)';
    }
    
    return null;
  }
  
  /// Validate Indonesian phone number
  static String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }
    
    // Remove spaces, hyphens, and parentheses
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    
    if (!_phoneRegex.hasMatch(cleanPhone)) {
      return 'Format nomor telepon tidak valid\n(contoh: 08123456789 atau +62812345678)';
    }
    
    return null;
  }
  
  /// Validate password strength
  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    
    if (password.length < 8) {
      return 'Password minimal 8 karakter';
    }
    
    if (password.length > 128) {
      return 'Password maksimal 128 karakter';
    }
    
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
    final hasNumbers = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    
    int strength = 0;
    if (hasUppercase) strength++;
    if (hasLowercase) strength++;
    if (hasNumbers) strength++;
    if (hasSpecialCharacters) strength++;
    
    if (strength < 3) {
      return 'Password harus mengandung minimal 3 dari:\n'
          '• Huruf besar (A-Z)\n'
          '• Huruf kecil (a-z)\n'
          '• Angka (0-9)\n'
          '• Karakter khusus (!@#\$%^&*...)';
    }
    
    return null;
  }
  
  /// Validate confirm password
  static String? validateConfirmPassword(String? confirmPassword, String? originalPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    
    if (confirmPassword != originalPassword) {
      return 'Konfirmasi password tidak sesuai';
    }
    
    return null;
  }
  
  /// Validate required field
  static String? validateRequired(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    return null;
  }
  
  /// Validate name (Indonesian names)
  static String? validateName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    
    final trimmedName = name.trim();
    
    if (trimmedName.length < 2) {
      return 'Nama minimal 2 karakter';
    }
    
    if (trimmedName.length > 100) {
      return 'Nama maksimal 100 karakter';
    }
    
    if (!_indonesianNameRegex.hasMatch(trimmedName)) {
      return 'Nama hanya boleh mengandung huruf, spasi, titik, dan apostrof';
    }
    
    return null;
  }
  
  /// Validate numeric input
  static String? validateNumeric(String? value, [String fieldName = 'Nilai']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    
    if (!_numericRegex.hasMatch(value.trim())) {
      return '$fieldName harus berupa angka';
    }
    
    return null;
  }
  
  /// Validate decimal number
  static String? validateDecimal(String? value, [String fieldName = 'Nilai']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    
    final cleanValue = value.trim().replaceAll(',', '.');
    
    if (!_decimalRegex.hasMatch(cleanValue)) {
      return '$fieldName harus berupa angka';
    }
    
    return null;
  }
  
  /// Validate positive number
  static String? validatePositiveNumber(String? value, [String fieldName = 'Nilai']) {
    final numericValidation = validateDecimal(value, fieldName);
    if (numericValidation != null) return numericValidation;
    
    final number = double.tryParse(value!.trim().replaceAll(',', '.'));
    if (number == null || number <= 0) {
      return '$fieldName harus lebih besar dari 0';
    }
    
    return null;
  }
  
  /// Validate price
  static String? validatePrice(String? value) {
    final positiveValidation = validatePositiveNumber(value, 'Harga');
    if (positiveValidation != null) return positiveValidation;
    
    final price = double.tryParse(value!.trim().replaceAll(',', '.'));
    if (price == null) return 'Harga tidak valid';
    
    // Check if price has more than 2 decimal places
    final decimalPart = (price * 100) % 100;
    if (decimalPart != decimalPart.truncate()) {
      return 'Harga maksimal 2 desimal';
    }
    
    if (price > 999999999) {
      return 'Harga terlalu besar (maksimal Rp 999.999.999)';
    }
    
    return null;
  }
  
  /// Validate quantity
  static String? validateQuantity(String? value) {
    final numericValidation = validateNumeric(value, 'Jumlah');
    if (numericValidation != null) return numericValidation;
    
    final quantity = int.tryParse(value!.trim());
    if (quantity == null || quantity <= 0) {
      return 'Jumlah harus lebih besar dari 0';
    }
    
    if (quantity > 999999) {
      return 'Jumlah terlalu besar (maksimal 999.999)';
    }
    
    return null;
  }
  
  /// Validate percentage (0-100)
  static String? validatePercentage(String? value, [String fieldName = 'Persentase']) {
    final decimalValidation = validateDecimal(value, fieldName);
    if (decimalValidation != null) return decimalValidation;
    
    final percentage = double.tryParse(value!.trim().replaceAll(',', '.'));
    if (percentage == null) return '$fieldName tidak valid';
    
    if (percentage < 0 || percentage > 100) {
      return '$fieldName harus antara 0-100';
    }
    
    return null;
  }
  
  /// Validate discount rate
  static String? validateDiscountRate(String? value) {
    return validatePercentage(value, 'Diskon');
  }
  
  /// Validate tax rate
  static String? validateTaxRate(String? value) {
    return validatePercentage(value, 'Pajak');
  }
  
  /// Validate URL
  static String? validateUrl(String? url) {
    if (url == null || url.trim().isEmpty) {
      return 'URL tidak boleh kosong';
    }
    
    if (!_urlRegex.hasMatch(url.trim())) {
      return 'Format URL tidak valid';
    }
    
    return null;
  }
  
  /// Validate minimum length
  static String? validateMinLength(String? value, int minLength, [String fieldName = 'Field']) {
    if (value == null || value.length < minLength) {
      return '$fieldName minimal $minLength karakter';
    }
    return null;
  }
  
  /// Validate maximum length
  static String? validateMaxLength(String? value, int maxLength, [String fieldName = 'Field']) {
    if (value != null && value.length > maxLength) {
      return '$fieldName maksimal $maxLength karakter';
    }
    return null;
  }
  
  /// Validate length range
  static String? validateLengthRange(
    String? value, 
    int minLength, 
    int maxLength, 
    [String fieldName = 'Field']
  ) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    
    if (value.length < minLength) {
      return '$fieldName minimal $minLength karakter';
    }
    
    if (value.length > maxLength) {
      return '$fieldName maksimal $maxLength karakter';
    }
    
    return null;
  }
  
  /// Validate alphabetic input (letters only)
  static String? validateAlphabetic(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    
    if (!_alphabeticRegex.hasMatch(value.trim())) {
      return '$fieldName hanya boleh mengandung huruf dan spasi';
    }
    
    return null;
  }
  
  /// Validate alphanumeric input
  static String? validateAlphanumeric(String? value, [String fieldName = 'Field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName tidak boleh kosong';
    }
    
    if (!_alphanumericRegex.hasMatch(value.trim())) {
      return '$fieldName hanya boleh mengandung huruf, angka, dan spasi';
    }
    
    return null;
  }
  
  /// Validate product SKU
  static String? validateSKU(String? sku) {
    if (sku == null || sku.trim().isEmpty) {
      return 'SKU tidak boleh kosong';
    }
    
    final trimmedSku = sku.trim().toUpperCase();
    
    if (trimmedSku.length < 3) {
      return 'SKU minimal 3 karakter';
    }
    
    if (trimmedSku.length > 50) {
      return 'SKU maksimal 50 karakter';
    }
    
    // Allow letters, numbers, hyphens, and underscores
    if (!RegExp(r'^[A-Z0-9\-_]+$').hasMatch(trimmedSku)) {
      return 'SKU hanya boleh mengandung huruf, angka, tanda hubung (-), dan underscore (_)';
    }
    
    return null;
  }
  
  /// Validate barcode
  static String? validateBarcode(String? barcode) {
    if (barcode == null || barcode.trim().isEmpty) {
      return null; // Barcode is optional
    }
    
    final trimmedBarcode = barcode.trim();
    
    if (!_numericRegex.hasMatch(trimmedBarcode)) {
      return 'Barcode harus berupa angka';
    }
    
    // Common barcode lengths: 8, 12, 13, 14
    final length = trimmedBarcode.length;
    if (![8, 12, 13, 14].contains(length)) {
      return 'Barcode harus 8, 12, 13, atau 14 digit';
    }
    
    return null;
  }
  
  /// Validate Indonesian postal code
  static String? validatePostalCode(String? postalCode) {
    if (postalCode == null || postalCode.trim().isEmpty) {
      return null; // Postal code is optional
    }
    
    if (!RegExp(r'^\d{5}$').hasMatch(postalCode.trim())) {
      return 'Kode pos harus 5 digit angka';
    }
    
    return null;
  }
  
  /// Validate date string
  static String? validateDateString(String? dateString) {
    if (dateString == null || dateString.trim().isEmpty) {
      return 'Tanggal tidak boleh kosong';
    }
    
    // Try parsing Indonesian format (dd/MM/yyyy)
    try {
      final parts = dateString.trim().split('/');
      if (parts.length != 3) throw const FormatException();
      
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      
      if (day < 1 || day > 31) throw const FormatException();
      if (month < 1 || month > 12) throw const FormatException();
      if (year < 1900 || year > 2100) throw const FormatException();
      
      // Create DateTime to validate the date
      DateTime(year, month, day);
      
      return null;
    } catch (e) {
      return 'Format tanggal tidak valid (dd/MM/yyyy)';
    }
  }
  
  /// Validate age
  static String? validateAge(String? ageString) {
    final numericValidation = validateNumeric(ageString, 'Umur');
    if (numericValidation != null) return numericValidation;
    
    final age = int.tryParse(ageString!.trim());
    if (age == null) return 'Umur tidak valid';
    
    if (age < 0 || age > 150) {
      return 'Umur harus antara 0-150 tahun';
    }
    
    return null;
  }
  
  /// Combine multiple validators
  static String? combineValidators(String? value, List<String? Function(String?)> validators) {
    for (final validator in validators) {
      final result = validator(value);
      if (result != null) return result;
    }
    return null;
  }
  
  /// Check if string is empty or only whitespace
  static bool isBlank(String? value) {
    return value == null || value.trim().isEmpty;
  }
  
  /// Check if string is not empty and not only whitespace
  static bool isNotBlank(String? value) {
    return !isBlank(value);
  }
  
  /// Trim and normalize whitespace
  static String? normalizeWhitespace(String? value) {
    if (value == null) return null;
    return value.trim().replaceAll(RegExp(r'\s+'), ' ');
  }
  
  /// Clean phone number (remove formatting)
  static String cleanPhoneNumber(String phone) {
    return phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
  }
  
  /// Format phone number for display
  static String formatPhoneNumber(String phone) {
    final cleaned = cleanPhoneNumber(phone);
    
    // Format Indonesian phone numbers
    if (cleaned.startsWith('+62')) {
      return cleaned.replaceFirst('+62', '+62 ');
    } else if (cleaned.startsWith('62')) {
      return '+62 ${cleaned.substring(2)}';
    } else if (cleaned.startsWith('08')) {
      return cleaned.replaceFirst('08', '08');
    }
    
    return cleaned;
  }
  
  /// Get password strength score (0-4)
  static int getPasswordStrength(String? password) {
    if (password == null || password.isEmpty) return 0;
    
    int score = 0;
    
    if (RegExp(r'[a-z]').hasMatch(password)) score++;
    if (RegExp(r'[A-Z]').hasMatch(password)) score++;
    if (RegExp(r'[0-9]').hasMatch(password)) score++;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) score++;
    
    return score;
  }
  
  /// Get password strength description
  static String getPasswordStrengthDescription(String? password) {
    final strength = getPasswordStrength(password);
    
    switch (strength) {
      case 0:
        return 'Sangat Lemah';
      case 1:
        return 'Lemah';
      case 2:
        return 'Sedang';
      case 3:
        return 'Kuat';
      case 4:
        return 'Sangat Kuat';
      default:
        return 'Unknown';
    }
  }
}