/// String extensions for validation, formatting, and manipulation
/// 
/// This file contains extension methods on String for common string operations
/// including validation, formatting, case conversion, and text manipulation.

import 'dart:convert';

/// Extension on String for validation operations
extension ValidationExtension on String {
  /// Check if string is empty or only contains whitespace
  bool get isBlank => trim().isEmpty;
  
  /// Check if string is not empty and not only whitespace
  bool get isNotBlank => !isBlank;
  
  /// Validate email format
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }
  
  /// Validate phone number (Indonesian format)
  bool get isValidPhone {
    final phoneRegex = RegExp(
      r'^(\+62|62|0)[0-9]{8,13}$',
    );
    return phoneRegex.hasMatch(replaceAll(RegExp(r'[\s-()]'), ''));
  }
  
  /// Validate strong password (min 8 chars, uppercase, lowercase, number)
  bool get isValidPassword {
    if (length < 8) return false;
    
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(this);
    final hasLowercase = RegExp(r'[a-z]').hasMatch(this);
    final hasNumbers = RegExp(r'[0-9]').hasMatch(this);
    
    return hasUppercase && hasLowercase && hasNumbers;
  }
  
  /// Validate numeric string
  bool get isNumeric {
    return double.tryParse(this) != null;
  }
  
  /// Validate integer string
  bool get isInteger {
    return int.tryParse(this) != null;
  }
  
  /// Validate URL format
  bool get isValidUrl {
    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );
    return urlRegex.hasMatch(this);
  }
  
  /// Check if string contains only alphabetic characters
  bool get isAlphabetic {
    final alphabeticRegex = RegExp(r'^[a-zA-Z]+$');
    return alphabeticRegex.hasMatch(this);
  }
  
  /// Check if string contains only alphanumeric characters
  bool get isAlphanumeric {
    final alphanumericRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return alphanumericRegex.hasMatch(this);
  }
}

/// Extension on String for formatting operations
extension FormattingExtension on String {
  /// Capitalize first letter of each word
  String get titleCase {
    if (isBlank) return this;
    
    return split(' ')
        .map((word) => word.isNotEmpty 
            ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
            : word)
        .join(' ');
  }
  
  /// Capitalize only the first letter of the string
  String get capitalizeFirst {
    if (isBlank) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
  
  /// Convert to camelCase
  String get camelCase {
    if (isBlank) return this;
    
    final words = split(RegExp(r'[\s_-]+'));
    if (words.isEmpty) return this;
    
    final first = words.first.toLowerCase();
    final rest = words.skip(1).map((word) => word.capitalizeFirst);
    
    return '$first${rest.join()}';
  }
  
  /// Convert to PascalCase
  String get pascalCase {
    if (isBlank) return this;
    
    return split(RegExp(r'[\s_-]+'))
        .map((word) => word.capitalizeFirst)
        .join();
  }
  
  /// Convert to snake_case
  String get snakeCase {
    if (isBlank) return this;
    
    return replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => '_${match.group(1)!.toLowerCase()}',
    ).replaceAll(RegExp(r'[\s-]+'), '_').toLowerCase();
  }
  
  /// Convert to kebab-case
  String get kebabCase {
    if (isBlank) return this;
    
    return replaceAllMapped(
      RegExp(r'([A-Z])'),
      (match) => '-${match.group(1)!.toLowerCase()}',
    ).replaceAll(RegExp(r'[\s_]+'), '-').toLowerCase();
  }
  
  /// Remove all whitespace
  String get removeWhitespace {
    return replaceAll(RegExp(r'\s+'), '');
  }
  
  /// Limit string length and add ellipsis if needed
  String truncate(int maxLength, {String suffix = '...'}) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - suffix.length)}$suffix';
  }
  
  /// Add padding to string
  String padBoth(int width, [String padding = ' ']) {
    final totalPad = width - length;
    if (totalPad <= 0) return this;
    
    final leftPad = totalPad ~/ 2;
    final rightPad = totalPad - leftPad;
    
    return padding * leftPad + this + padding * rightPad;
  }
  
  /// Mask string for privacy (e.g., credit card, phone numbers)
  String mask({
    int start = 4,
    int end = 4,
    String maskChar = '*',
  }) {
    if (length <= start + end) return this;
    
    final startPart = substring(0, start);
    final endPart = substring(length - end);
    final maskedLength = length - start - end;
    
    return '$startPart${maskChar * maskedLength}$endPart';
  }
}

/// Extension on String for currency and number formatting
extension CurrencyExtension on String {
  /// Format string as Indonesian Rupiah
  String get formatAsRupiah {
    final number = double.tryParse(replaceAll(RegExp(r'[^\d.]'), ''));
    if (number == null) return this;
    
    return 'Rp ${number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)}.',
    )}';
  }
  
  /// Parse currency string to double
  double? get parseFromRupiah {
    return double.tryParse(
      replaceAll(RegExp(r'[Rp\s.]'), '').replaceAll(',', '.'),
    );
  }
  
  /// Format as percentage
  String get formatAsPercentage {
    final number = double.tryParse(this);
    if (number == null) return this;
    
    return '${(number * 100).toStringAsFixed(1)}%';
  }
  
  /// Add thousand separators
  String get addThousandSeparator {
    final number = double.tryParse(this);
    if (number == null) return this;
    
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match.group(1)}.',
    );
  }
}

/// Extension on String for text manipulation
extension TextManipulationExtension on String {
  /// Remove HTML tags from string
  String get removeHtmlTags {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }
  
  /// Extract numbers from string
  List<int> get extractNumbers {
    final numbers = <int>[];
    final matches = RegExp(r'\d+').allMatches(this);
    
    for (final match in matches) {
      final number = int.tryParse(match.group(0)!);
      if (number != null) numbers.add(number);
    }
    
    return numbers;
  }
  
  /// Count words in string
  int get wordCount {
    if (isBlank) return 0;
    return trim().split(RegExp(r'\s+')).length;
  }
  
  /// Reverse string
  String get reverse {
    return split('').reversed.join();
  }
  
  /// Check if string is palindrome
  bool get isPalindrome {
    final cleaned = toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return cleaned == cleaned.reverse;
  }
  
  /// Convert string to list of characters
  List<String> get toCharList {
    return split('');
  }
  
  /// Remove diacritics (accents) from string
  String get removeDiacritics {
    const diacritics = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    const ascii = 'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    
    String result = this;
    for (int i = 0; i < diacritics.length; i++) {
      result = result.replaceAll(diacritics[i], ascii[i]);
    }
    
    return result;
  }
}

/// Extension on String for encoding/decoding operations
extension EncodingExtension on String {
  /// Encode string to base64
  String get toBase64 {
    return base64Encode(utf8.encode(this));
  }
  
  /// Decode base64 string
  String? get fromBase64 {
    try {
      return utf8.decode(base64Decode(this));
    } catch (e) {
      return null;
    }
  }
  
  /// URL encode string
  String get urlEncode {
    return Uri.encodeComponent(this);
  }
  
  /// URL decode string
  String get urlDecode {
    return Uri.decodeComponent(this);
  }
  
  /// HTML escape string
  String get htmlEscape {
    return replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;');
  }
  
  /// HTML unescape string
  String get htmlUnescape {
    return replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#x27;', "'");
  }
}

/// Extension on String for search and matching
extension SearchExtension on String {
  /// Check if string contains substring (case insensitive)
  bool containsIgnoreCase(String substring) {
    return toLowerCase().contains(substring.toLowerCase());
  }
  
  /// Check if string starts with substring (case insensitive)
  bool startsWithIgnoreCase(String substring) {
    return toLowerCase().startsWith(substring.toLowerCase());
  }
  
  /// Check if string ends with substring (case insensitive)
  bool endsWithIgnoreCase(String substring) {
    return toLowerCase().endsWith(substring.toLowerCase());
  }
  
  /// Get similarity score with another string (Levenshtein distance)
  int levenshteinDistance(String other) {
    if (this == other) return 0;
    if (isEmpty) return other.length;
    if (other.isEmpty) return length;
    
    final List<List<int>> matrix = List.generate(
      length + 1,
      (i) => List.generate(other.length + 1, (j) => 0),
    );
    
    for (int i = 0; i <= length; i++) {
      matrix[i][0] = i;
    }
    
    for (int j = 0; j <= other.length; j++) {
      matrix[0][j] = j;
    }
    
    for (int i = 1; i <= length; i++) {
      for (int j = 1; j <= other.length; j++) {
        final cost = this[i - 1] == other[j - 1] ? 0 : 1;
        
        matrix[i][j] = [
          matrix[i - 1][j] + 1,     // deletion
          matrix[i][j - 1] + 1,     // insertion
          matrix[i - 1][j - 1] + cost, // substitution
        ].reduce((a, b) => a < b ? a : b);
      }
    }
    
    return matrix[length][other.length];
  }
  
  /// Calculate similarity percentage with another string
  double similarity(String other) {
    if (this == other) return 1.0;
    if (isEmpty && other.isEmpty) return 1.0;
    if (isEmpty || other.isEmpty) return 0.0;
    
    final distance = levenshteinDistance(other);
    final maxLength = length > other.length ? length : other.length;
    
    return 1.0 - (distance / maxLength);
  }
}

/// Extension on String for file operations
extension FileExtension on String {
  /// Get file extension from file path
  String get fileExtension {
    final lastDot = lastIndexOf('.');
    if (lastDot == -1) return '';
    return substring(lastDot);
  }
  
  /// Get file name from file path
  String get fileName {
    final lastSlash = lastIndexOf('/');
    if (lastSlash == -1) return this;
    return substring(lastSlash + 1);
  }
  
  /// Get file name without extension
  String get fileNameWithoutExtension {
    final name = fileName;
    final lastDot = name.lastIndexOf('.');
    if (lastDot == -1) return name;
    return name.substring(0, lastDot);
  }
  
  /// Get directory path from file path
  String get directoryPath {
    final lastSlash = lastIndexOf('/');
    if (lastSlash == -1) return '';
    return substring(0, lastSlash);
  }
  
  /// Check if string represents an image file
  bool get isImageFile {
    final ext = fileExtension.toLowerCase();
    return ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'].contains(ext);
  }
  
  /// Check if string represents a document file
  bool get isDocumentFile {
    final ext = fileExtension.toLowerCase();
    return ['.pdf', '.doc', '.docx', '.txt', '.rtf'].contains(ext);
  }
}

/// Extension on String nullable
extension NullableStringExtension on String? {
  /// Check if nullable string is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  
  /// Check if nullable string is null or blank
  bool get isNullOrBlank => this == null || this!.isBlank;
  
  /// Get string or default value if null
  String orEmpty() => this ?? '';
  
  /// Get string or default value if null or empty
  String orDefault(String defaultValue) => 
      isNullOrEmpty ? defaultValue : this!;
}