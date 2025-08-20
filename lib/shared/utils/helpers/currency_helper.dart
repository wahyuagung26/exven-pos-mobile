/// Currency formatting utilities for Indonesian Rupiah
/// 
/// This file contains utility functions for formatting currency,
/// parsing currency strings, and handling Indonesian Rupiah formatting.

import 'dart:math' as math;
import 'package:intl/intl.dart';

/// Currency helper utility class with static methods
class CurrencyHelper {
  CurrencyHelper._(); // Private constructor to prevent instantiation
  
  // Indonesian currency formatter
  static final NumberFormat _rupiahFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );
  
  static final NumberFormat _rupiahWithDecimalFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 2,
  );
  
  static final NumberFormat _rupiahWithoutSymbolFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: '',
    decimalDigits: 0,
  );
  
  static final NumberFormat _thousandSeparatorFormatter = NumberFormat('#,###', 'id_ID');
  
  /// Format number as Indonesian Rupiah (Rp 1.000.000)
  static String formatAsRupiah(num? amount, {bool showSymbol = true}) {
    if (amount == null) return showSymbol ? 'Rp 0' : '0';
    
    if (showSymbol) {
      return _rupiahFormatter.format(amount);
    } else {
      return _rupiahWithoutSymbolFormatter.format(amount).trim();
    }
  }
  
  /// Format number as Indonesian Rupiah with decimal places (Rp 1.000.000,50)
  static String formatAsRupiahWithDecimal(num? amount, {bool showSymbol = true}) {
    if (amount == null) return showSymbol ? 'Rp 0,00' : '0,00';
    
    if (showSymbol) {
      return _rupiahWithDecimalFormatter.format(amount);
    } else {
      final formatter = NumberFormat.currency(
        locale: 'id_ID',
        symbol: '',
        decimalDigits: 2,
      );
      return formatter.format(amount).trim();
    }
  }
  
  /// Format number as compact Indonesian Rupiah (Rp 1,2 Jt)
  static String formatAsCompactRupiah(num? amount) {
    if (amount == null) return 'Rp 0';
    
    final absAmount = amount.abs();
    final isNegative = amount < 0;
    final prefix = isNegative ? '-Rp ' : 'Rp ';
    
    if (absAmount >= 1000000000000) {
      return '$prefix${(absAmount / 1000000000000).toStringAsFixed(1)} T';
    } else if (absAmount >= 1000000000) {
      return '$prefix${(absAmount / 1000000000).toStringAsFixed(1)} M';
    } else if (absAmount >= 1000000) {
      return '$prefix${(absAmount / 1000000).toStringAsFixed(1)} Jt';
    } else if (absAmount >= 1000) {
      return '$prefix${(absAmount / 1000).toStringAsFixed(1)} Rb';
    } else {
      return formatAsRupiah(amount);
    }
  }
  
  /// Format number with thousand separators (1.234.567)
  static String formatWithThousands(num? amount) {
    if (amount == null) return '0';
    return _thousandSeparatorFormatter.format(amount);
  }
  
  /// Parse currency string to double
  static double? parseFromRupiah(String? currencyString) {
    if (currencyString == null || currencyString.trim().isEmpty) return null;
    
    // Remove currency symbols and spaces
    String cleanString = currencyString
        .replaceAll('Rp', '')
        .replaceAll('Rb', '')
        .replaceAll('Jt', '')
        .replaceAll('M', '')
        .replaceAll('T', '')
        .replaceAll(' ', '')
        .trim();
    
    // Handle compact notation
    if (currencyString.contains('T')) {
      final number = double.tryParse(cleanString);
      return number != null ? number * 1000000000000 : null;
    } else if (currencyString.contains('M')) {
      final number = double.tryParse(cleanString);
      return number != null ? number * 1000000000 : null;
    } else if (currencyString.contains('Jt')) {
      final number = double.tryParse(cleanString);
      return number != null ? number * 1000000 : null;
    } else if (currencyString.contains('Rb')) {
      final number = double.tryParse(cleanString);
      return number != null ? number * 1000 : null;
    } else {
      // Remove dots (thousand separators) and replace comma with dot (decimal separator)
      cleanString = cleanString.replaceAll('.', '').replaceAll(',', '.');
      return double.tryParse(cleanString);
    }
  }
  
  /// Validate if string is a valid currency format
  static bool isValidCurrencyString(String? currencyString) {
    return parseFromRupiah(currencyString) != null;
  }
  
  /// Format as percentage
  static String formatAsPercentage(num? value, {int decimalPlaces = 1}) {
    if (value == null) return '0%';
    return '${value.toStringAsFixed(decimalPlaces)}%';
  }
  
  /// Calculate tax amount
  static double calculateTax(num amount, num taxRate) {
    return amount * (taxRate / 100);
  }
  
  /// Calculate amount including tax
  static double calculateAmountWithTax(num amount, num taxRate) {
    return amount + calculateTax(amount, taxRate);
  }
  
  /// Calculate amount excluding tax (reverse calculation)
  static double calculateAmountWithoutTax(num amountWithTax, num taxRate) {
    return amountWithTax / (1 + (taxRate / 100));
  }
  
  /// Calculate discount amount
  static double calculateDiscount(num amount, num discountRate) {
    return amount * (discountRate / 100);
  }
  
  /// Calculate amount after discount
  static double calculateAmountAfterDiscount(num amount, num discountRate) {
    return amount - calculateDiscount(amount, discountRate);
  }
  
  /// Calculate percentage of total
  static double calculatePercentageOfTotal(num amount, num total) {
    if (total == 0) return 0;
    return (amount / total) * 100;
  }
  
  /// Calculate change amount
  static double calculateChange(num totalAmount, num paidAmount) {
    return paidAmount - totalAmount;
  }
  
  /// Round to nearest currency unit (e.g., round to nearest 100 for Rupiah)
  static double roundToCurrencyUnit(num amount, [int unit = 100]) {
    return (amount / unit).round() * unit.toDouble();
  }
  
  /// Round up to nearest currency unit
  static double roundUpToCurrencyUnit(num amount, [int unit = 100]) {
    return (amount / unit).ceil() * unit.toDouble();
  }
  
  /// Round down to nearest currency unit
  static double roundDownToCurrencyUnit(num amount, [int unit = 100]) {
    return (amount / unit).floor() * unit.toDouble();
  }
  
  /// Check if amount is valid for currency operations
  static bool isValidCurrencyAmount(num? amount) {
    if (amount == null) return false;
    if (amount.isNaN || amount.isInfinite) return false;
    
    // Check if it has more than 2 decimal places (not valid for currency)
    final decimalPart = (amount * 100) % 100;
    return decimalPart == decimalPart.truncate();
  }
  
  /// Convert foreign currency to Rupiah
  static double convertToRupiah(num amount, num exchangeRate) {
    return amount * exchangeRate;
  }
  
  /// Convert Rupiah to foreign currency
  static double convertFromRupiah(num rupiahAmount, num exchangeRate) {
    if (exchangeRate == 0) return 0;
    return rupiahAmount / exchangeRate;
  }
  
  /// Calculate compound interest
  static double calculateCompoundInterest({
    required num principal,
    required num rate,
    required int periods,
    int compoundingFrequency = 1,
  }) {
    final r = rate / 100;
    return principal * math.pow(1 + (r / compoundingFrequency), 
                               compoundingFrequency * periods);
  }
  
  /// Calculate simple interest
  static double calculateSimpleInterest({
    required num principal,
    required num rate,
    required num time,
  }) {
    return principal * (rate / 100) * time;
  }
  
  /// Calculate profit margin percentage
  static double calculateProfitMargin(num sellingPrice, num costPrice) {
    if (sellingPrice == 0) return 0;
    return ((sellingPrice - costPrice) / sellingPrice) * 100;
  }
  
  /// Calculate markup percentage
  static double calculateMarkupPercentage(num sellingPrice, num costPrice) {
    if (costPrice == 0) return 0;
    return ((sellingPrice - costPrice) / costPrice) * 100;
  }
  
  /// Calculate selling price from cost and margin
  static double calculateSellingPriceFromMargin(num costPrice, num marginPercentage) {
    return costPrice / (1 - (marginPercentage / 100));
  }
  
  /// Calculate selling price from cost and markup
  static double calculateSellingPriceFromMarkup(num costPrice, num markupPercentage) {
    return costPrice * (1 + (markupPercentage / 100));
  }
  
  /// Calculate commission
  static double calculateCommission(num amount, num commissionRate) {
    return amount * (commissionRate / 100);
  }
  
  /// Split amount into equal parts
  static List<double> splitAmountEqually(num totalAmount, int parts) {
    if (parts <= 0) return [];
    
    final amountPerPart = totalAmount / parts;
    final roundedAmountPerPart = roundToCurrencyUnit(amountPerPart);
    
    final result = List.filled(parts, roundedAmountPerPart);
    
    // Adjust for rounding differences
    final totalRounded = roundedAmountPerPart * parts;
    final difference = totalAmount - totalRounded;
    
    if (difference != 0) {
      result[0] += difference;
    }
    
    return result;
  }
  
  /// Split amount by percentages
  static Map<String, double> splitAmountByPercentages(
    num totalAmount, 
    Map<String, double> percentages,
  ) {
    final result = <String, double>{};
    double remaining = totalAmount.toDouble();
    
    // Sort by percentage descending to handle rounding better
    final sortedEntries = percentages.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    
    for (int i = 0; i < sortedEntries.length; i++) {
      final entry = sortedEntries[i];
      
      if (i == sortedEntries.length - 1) {
        // Last item gets the remaining amount to avoid rounding errors
        result[entry.key] = remaining;
      } else {
        final amount = totalAmount * (entry.value / 100);
        final roundedAmount = roundToCurrencyUnit(amount);
        result[entry.key] = roundedAmount;
        remaining -= roundedAmount;
      }
    }
    
    return result;
  }
  
  /// Format currency difference with sign
  static String formatCurrencyDifference(num current, num previous) {
    final difference = current - previous;
    final formattedAmount = formatAsRupiah(difference.abs(), showSymbol: false);
    
    if (difference > 0) {
      return '+Rp $formattedAmount';
    } else if (difference < 0) {
      return '-Rp $formattedAmount';
    } else {
      return 'Rp $formattedAmount';
    }
  }
  
  /// Get currency input validation regex
  static RegExp get currencyInputRegex => RegExp(r'^\d{1,3}(?:\.\d{3})*(?:,\d{0,2})?$');
  
  /// Clean currency input string
  static String cleanCurrencyInput(String input) {
    // Remove everything except digits, dots, and commas
    return input.replaceAll(RegExp(r'[^\d.,]'), '');
  }
  
  /// Format currency input as user types
  static String formatCurrencyInput(String input) {
    final cleaned = cleanCurrencyInput(input);
    if (cleaned.isEmpty) return '';
    
    // Split by comma to handle decimal part
    final parts = cleaned.split(',');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : null;
    
    // Remove existing dots and add thousand separators
    final integerOnly = integerPart.replaceAll('.', '');
    if (integerOnly.isEmpty) return '';
    
    final formatted = _thousandSeparatorFormatter.format(int.tryParse(integerOnly) ?? 0);
    
    if (decimalPart != null) {
      // Limit decimal places to 2
      final limitedDecimal = decimalPart.length > 2 
          ? decimalPart.substring(0, 2) 
          : decimalPart;
      return '$formatted,$limitedDecimal';
    }
    
    return formatted;
  }
}

/// Currency constants for Indonesian Rupiah
class CurrencyConstants {
  static const String symbol = 'Rp';
  static const String code = 'IDR';
  static const String name = 'Indonesian Rupiah';
  static const int decimalPlaces = 0; // Rupiah typically doesn't use decimals
  static const int roundingUnit = 100; // Round to nearest 100
  
  // Common denominations
  static const List<int> coins = [50, 100, 200, 500, 1000];
  static const List<int> notes = [
    1000, 2000, 5000, 10000, 20000, 50000, 100000
  ];
  
  // All denominations combined
  static List<int> get allDenominations => [...coins, ...notes]..sort();
}

/// Exchange rate helper for currency conversion
class ExchangeRateHelper {
  static final Map<String, double> _rates = {};
  
  /// Set exchange rate for a currency
  static void setExchangeRate(String currencyCode, double rate) {
    _rates[currencyCode.toUpperCase()] = rate;
  }
  
  /// Get exchange rate for a currency
  static double? getExchangeRate(String currencyCode) {
    return _rates[currencyCode.toUpperCase()];
  }
  
  /// Convert amount from foreign currency to IDR
  static double? convertToIDR(String fromCurrency, num amount) {
    final rate = getExchangeRate(fromCurrency);
    if (rate == null) return null;
    return amount * rate;
  }
  
  /// Convert amount from IDR to foreign currency
  static double? convertFromIDR(String toCurrency, num idrAmount) {
    final rate = getExchangeRate(toCurrency);
    if (rate == null || rate == 0) return null;
    return idrAmount / rate;
  }
  
  /// Check if exchange rate exists for currency
  static bool hasExchangeRate(String currencyCode) {
    return _rates.containsKey(currencyCode.toUpperCase());
  }
  
  /// Get all available currencies
  static List<String> get availableCurrencies => _rates.keys.toList();
  
  /// Clear all exchange rates
  static void clearExchangeRates() {
    _rates.clear();
  }
}