/// Number extensions for currency formatting, calculations, and Indonesian locale
/// 
/// This file contains extension methods on num (int/double) for currency formatting,
/// mathematical operations, validation, and Indonesian-specific number formatting.

import 'dart:math' as math;
import 'package:intl/intl.dart';

/// Extension on num for currency formatting
extension CurrencyExtension on num {
  /// Format as Indonesian Rupiah (Rp 1.000.000)
  String get formatAsRupiah {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(this);
  }
  
  /// Format as Indonesian Rupiah with decimal (Rp 1.000.000,50)
  String get formatAsRupiahWithDecimal {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 2,
    );
    return formatter.format(this);
  }
  
  /// Format as Indonesian Rupiah without symbol (1.000.000)
  String get formatAsRupiahWithoutSymbol {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: 0,
    );
    return formatter.format(this).trim();
  }
  
  /// Format as compact Indonesian Rupiah (Rp 1,2 Jt)
  String get formatAsCompactRupiah {
    if (abs() >= 1000000000) {
      return 'Rp ${(this / 1000000000).toStringAsFixed(1)} M';
    } else if (abs() >= 1000000) {
      return 'Rp ${(this / 1000000).toStringAsFixed(1)} Jt';
    } else if (abs() >= 1000) {
      return 'Rp ${(this / 1000).toStringAsFixed(1)} Rb';
    } else {
      return formatAsRupiah;
    }
  }
  
  /// Format as percentage with Indonesian locale (12,5%)
  String get formatAsPercentage {
    final formatter = NumberFormat.percentPattern('id_ID');
    return formatter.format(this / 100);
  }
  
  /// Format as decimal with Indonesian locale (1.234,56)
  String get formatAsDecimal {
    final formatter = NumberFormat.decimalPattern('id_ID');
    return formatter.format(this);
  }
  
  /// Format with specific decimal places
  String formatWithDecimal(int decimalPlaces) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: '',
      decimalDigits: decimalPlaces,
    );
    return formatter.format(this).trim();
  }
  
  /// Format as thousands separator (1.234.567)
  String get formatWithThousands {
    final formatter = NumberFormat('#,###', 'id_ID');
    return formatter.format(this);
  }
}

/// Extension on num for mathematical operations
extension MathExtension on num {
  /// Round to specific decimal places
  double roundToDecimals(int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces).toDouble();
    return (this * factor).round() / factor;
  }
  
  /// Ceiling to specific decimal places
  double ceilToDecimals(int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces).toDouble();
    return (this * factor).ceil() / factor;
  }
  
  /// Floor to specific decimal places
  double floorToDecimals(int decimalPlaces) {
    final factor = math.pow(10, decimalPlaces).toDouble();
    return (this * factor).floor() / factor;
  }
  
  /// Get percentage of another number
  double percentageOf(num total) {
    if (total == 0) return 0.0;
    return (this / total) * 100;
  }
  
  /// Get what percentage this number represents of total
  double asPercentageOf(num total) {
    if (total == 0) return 0.0;
    return (this / total) * 100;
  }
  
  /// Calculate percentage increase/decrease
  double percentageChange(num newValue) {
    if (this == 0) return newValue == 0 ? 0.0 : double.infinity;
    return ((newValue - this) / this) * 100;
  }
  
  /// Check if number is within range (inclusive)
  bool isInRange(num min, num max) {
    return this >= min && this <= max;
  }
  
  /// Check if number is between two values (exclusive)
  bool isBetween(num min, num max) {
    return this > min && this < max;
  }
  
  /// Clamp value between min and max
  num clampValue(num min, num max) {
    if (this < min) return min;
    if (this > max) return max;
    return this;
  }
  
  /// Get distance from another number
  num distanceFrom(num other) {
    return (this - other).abs();
  }
  
  /// Check if number is approximately equal (with tolerance)
  bool approximatelyEquals(num other, {double tolerance = 0.0001}) {
    return distanceFrom(other) <= tolerance;
  }
}

/// Extension on num for validation and checks
extension ValidationExtension on num {
  /// Check if number is positive
  bool get isPositive => this > 0;
  
  /// Check if number is negative  
  bool get isNegative => this < 0;
  
  /// Check if number is zero
  bool get isZero => this == 0;
  
  /// Check if number is not zero
  bool get isNotZero => this != 0;
  
  /// Check if number is even (for integers)
  bool get isEven => this % 2 == 0;
  
  /// Check if number is odd (for integers)
  bool get isOdd => this % 2 != 0;
  
  /// Check if number is whole (no decimal part)
  bool get isWhole => this == this.truncate();
  
  /// Check if number is decimal (has decimal part)
  bool get isDecimal => !isWhole;
  
  /// Check if number is valid price (positive and has max 2 decimal places)
  bool get isValidPrice {
    if (this <= 0) return false;
    final decimalPart = (this * 100) % 100;
    return decimalPart == decimalPart.truncate();
  }
  
  /// Check if number is valid quantity (positive integer)
  bool get isValidQuantity {
    return isPositive && isWhole;
  }
  
  /// Check if number is valid percentage (0-100)
  bool get isValidPercentage {
    return isInRange(0, 100);
  }
  
  /// Check if number is valid discount (0-100)
  bool get isValidDiscount {
    return isValidPercentage;
  }
  
  /// Check if number is valid tax rate (0-100)
  bool get isValidTaxRate {
    return isValidPercentage;
  }
}

/// Extension on num for conversion operations
extension ConversionExtension on num {
  /// Convert to Duration in milliseconds
  Duration get milliseconds => Duration(milliseconds: toInt());
  
  /// Convert to Duration in seconds
  Duration get seconds => Duration(seconds: toInt());
  
  /// Convert to Duration in minutes
  Duration get minutes => Duration(minutes: toInt());
  
  /// Convert to Duration in hours
  Duration get hours => Duration(hours: toInt());
  
  /// Convert to Duration in days
  Duration get days => Duration(days: toInt());
  
  /// Convert bytes to KB
  double get asKB => this / 1024;
  
  /// Convert bytes to MB
  double get asMB => this / (1024 * 1024);
  
  /// Convert bytes to GB
  double get asGB => this / (1024 * 1024 * 1024);
  
  /// Convert KB to bytes
  double get fromKB => this * 1024;
  
  /// Convert MB to bytes
  double get fromMB => this * 1024 * 1024;
  
  /// Convert GB to bytes
  double get fromGB => this * 1024 * 1024 * 1024;
  
  /// Format file size (auto-scale to appropriate unit)
  String get formatFileSize {
    if (this >= fromGB) {
      return '${(asGB).toStringAsFixed(2)} GB';
    } else if (this >= fromMB) {
      return '${(asMB).toStringAsFixed(2)} MB';
    } else if (this >= 1024) {
      return '${(asKB).toStringAsFixed(2)} KB';
    } else {
      return '$this bytes';
    }
  }
}

/// Extension on num for business calculations
extension BusinessCalculationExtension on num {
  /// Calculate tax amount
  double calculateTax(double taxRate) {
    return this * (taxRate / 100);
  }
  
  /// Calculate amount including tax
  double withTax(double taxRate) {
    return toDouble() + calculateTax(taxRate);
  }
  
  /// Calculate amount excluding tax (reverse calculation)
  double withoutTax(double taxRate) {
    return this / (1 + (taxRate / 100));
  }
  
  /// Calculate discount amount
  double calculateDiscount(double discountRate) {
    return this * (discountRate / 100);
  }
  
  /// Calculate amount after discount
  double afterDiscount(double discountRate) {
    return toDouble() - calculateDiscount(discountRate);
  }
  
  /// Calculate markup amount
  double calculateMarkup(double markupRate) {
    return this * (markupRate / 100);
  }
  
  /// Calculate price with markup
  double withMarkup(double markupRate) {
    return toDouble() + calculateMarkup(markupRate);
  }
  
  /// Calculate profit margin
  double profitMargin(num cost) {
    if (cost == 0) return 0.0;
    return ((this - cost) / this) * 100;
  }
  
  /// Calculate commission
  double calculateCommission(double commissionRate) {
    return this * (commissionRate / 100);
  }
  
  /// Round to nearest currency unit (e.g., round to nearest 100 for Rupiah)
  double roundToCurrencyUnit([int unit = 100]) {
    return (this / unit).round() * unit.toDouble();
  }
  
  /// Calculate compound interest
  double compoundInterest({
    required double rate,
    required int periods,
    int compoundingFrequency = 1,
  }) {
    final r = rate / 100;
    return this * math.pow(1 + (r / compoundingFrequency), 
                          compoundingFrequency * periods);
  }
}

/// Extension on num for display and formatting
extension DisplayExtension on num {
  /// Format as ordinal number in Indonesian (1st, 2nd, 3rd, etc.)
  String get ordinalInIndonesian {
    return 'ke-$this';
  }
  
  /// Convert number to Indonesian words (for small numbers)
  String get toIndonesianWords {
    if (this == 0) return 'nol';
    if (this == 1) return 'satu';
    if (this == 2) return 'dua';
    if (this == 3) return 'tiga';
    if (this == 4) return 'empat';
    if (this == 5) return 'lima';
    if (this == 6) return 'enam';
    if (this == 7) return 'tujuh';
    if (this == 8) return 'delapan';
    if (this == 9) return 'sembilan';
    if (this == 10) return 'sepuluh';
    
    // For larger numbers, you might want to implement a more comprehensive
    // number-to-words converter or use a third-party package
    return toString();
  }
  
  /// Format as rating (4.5/5.0)
  String formatAsRating([num maxRating = 5]) {
    return '${toStringAsFixed(1)}/$maxRating';
  }
  
  /// Format as score (85/100)
  String formatAsScore([num maxScore = 100]) {
    return '$this/$maxScore';
  }
  
  /// Format with plus/minus sign
  String get withSign {
    if (this > 0) return '+$this';
    if (this < 0) return toString();
    return '±$this';
  }
  
  /// Format as abbreviated number (1K, 1M, etc.)
  String get abbreviated {
    if (abs() >= 1000000000) {
      return '${(this / 1000000000).toStringAsFixed(1)}B';
    } else if (abs() >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (abs() >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    } else {
      return toString();
    }
  }
  
  /// Format with leading zeros
  String withLeadingZeros(int width) {
    return toString().padLeft(width, '0');
  }
}

/// Extension on double for specific double operations
extension DoubleExtension on double {
  /// Check if double has specific number of decimal places
  bool hasDecimalPlaces(int places) {
    final factor = math.pow(10, places);
    return (this * factor) == (this * factor).truncate();
  }
  
  /// Get number of decimal places
  int get decimalPlaces {
    String str = toString();
    if (str.contains('.')) {
      return str.split('.')[1].length;
    }
    return 0;
  }
  
  /// Check if double is finite and valid for calculations
  bool get isValidForCalculation {
    return isFinite && !isNaN;
  }
}

/// Extension on int for specific integer operations
extension IntExtension on int {
  /// Check if integer is prime
  bool get isPrime {
    if (this < 2) return false;
    if (this == 2) return true;
    if (this % 2 == 0) return false;
    
    for (int i = 3; i * i <= this; i += 2) {
      if (this % i == 0) return false;
    }
    
    return true;
  }
  
  /// Get factorial
  int get factorial {
    if (this < 0) throw ArgumentError('Factorial is not defined for negative numbers');
    if (this <= 1) return 1;
    
    int result = 1;
    for (int i = 2; i <= this; i++) {
      result *= i;
    }
    
    return result;
  }
  
  /// Check if integer is perfect square
  bool get isPerfectSquare {
    if (this < 0) return false;
    final sqrt = math.sqrt(this).toInt();
    return sqrt * sqrt == this;
  }
  
  /// Get digits as list
  List<int> get digits {
    return abs().toString().split('').map(int.parse).toList();
  }
  
  /// Reverse digits
  int get reverseDigits {
    return int.parse(digits.reversed.join());
  }
  
  /// Sum of digits
  int get digitSum {
    return digits.fold(0, (sum, digit) => sum + digit);
  }
  
  /// Generate range from 0 to this number
  Iterable<int> get range => Iterable.generate(this);
  
  /// Generate range from this number to another
  Iterable<int> to(int end) => 
      Iterable.generate(end - this + 1, (i) => this + i);
}