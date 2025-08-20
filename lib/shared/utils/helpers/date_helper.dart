/// Date parsing and formatting utilities
/// 
/// This file contains utility functions for date parsing, formatting,
/// and manipulation with Indonesian locale support.

import 'package:intl/intl.dart';

/// Date helper utility class with static methods
class DateHelper {
  DateHelper._(); // Private constructor to prevent instantiation
  
  // Indonesian locale formatters
  static final DateFormat _indonesianDateFormat = DateFormat('dd/MM/yyyy', 'id_ID');
  static final DateFormat _indonesianDateTimeFormat = DateFormat('dd/MM/yyyy HH:mm', 'id_ID');
  static final DateFormat _indonesianReadableFormat = DateFormat('d MMMM yyyy', 'id_ID');
  static final DateFormat _indonesianFullFormat = DateFormat('EEEE, d MMMM yyyy', 'id_ID');
  static final DateFormat _indonesianShortFormat = DateFormat('d MMM yyyy', 'id_ID');
  static final DateFormat _timeFormat = DateFormat('HH:mm');
  static final DateFormat _timeWithSecondsFormat = DateFormat('HH:mm:ss');
  static final DateFormat _apiDateFormat = DateFormat('yyyy-MM-dd');
  static final DateFormat _apiDateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
  static final DateFormat _timestampFormat = DateFormat('yyyyMMdd_HHmmss');
  static final DateFormat _monthYearFormat = DateFormat('MMMM yyyy', 'id_ID');
  
  /// Parse Indonesian date string (dd/MM/yyyy) to DateTime
  static DateTime? parseIndonesianDate(String? dateString) {
    if (dateString == null || dateString.trim().isEmpty) return null;
    
    try {
      return _indonesianDateFormat.parse(dateString.trim());
    } catch (e) {
      return null;
    }
  }
  
  /// Parse Indonesian date time string (dd/MM/yyyy HH:mm) to DateTime
  static DateTime? parseIndonesianDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.trim().isEmpty) return null;
    
    try {
      return _indonesianDateTimeFormat.parse(dateTimeString.trim());
    } catch (e) {
      return null;
    }
  }
  
  /// Parse API date string (yyyy-MM-dd) to DateTime
  static DateTime? parseApiDate(String? dateString) {
    if (dateString == null || dateString.trim().isEmpty) return null;
    
    try {
      return _apiDateFormat.parse(dateString.trim());
    } catch (e) {
      return null;
    }
  }
  
  /// Parse API date time string (yyyy-MM-dd HH:mm:ss) to DateTime
  static DateTime? parseApiDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.trim().isEmpty) return null;
    
    try {
      return _apiDateTimeFormat.parse(dateTimeString.trim());
    } catch (e) {
      return null;
    }
  }
  
  /// Parse ISO 8601 date string to DateTime
  static DateTime? parseIsoDate(String? isoString) {
    if (isoString == null || isoString.trim().isEmpty) return null;
    
    try {
      return DateTime.parse(isoString.trim());
    } catch (e) {
      return null;
    }
  }
  
  /// Format DateTime as Indonesian date (dd/MM/yyyy)
  static String formatAsIndonesianDate(DateTime? date) {
    if (date == null) return '';
    return _indonesianDateFormat.format(date);
  }
  
  /// Format DateTime as Indonesian date time (dd/MM/yyyy HH:mm)
  static String formatAsIndonesianDateTime(DateTime? date) {
    if (date == null) return '';
    return _indonesianDateTimeFormat.format(date);
  }
  
  /// Format DateTime as readable Indonesian date (1 Januari 2024)
  static String formatAsReadableIndonesian(DateTime? date) {
    if (date == null) return '';
    return _indonesianReadableFormat.format(date);
  }
  
  /// Format DateTime as full Indonesian date (Senin, 1 Januari 2024)
  static String formatAsFullIndonesian(DateTime? date) {
    if (date == null) return '';
    return _indonesianFullFormat.format(date);
  }
  
  /// Format DateTime as short Indonesian date (1 Jan 2024)
  static String formatAsShortIndonesian(DateTime? date) {
    if (date == null) return '';
    return _indonesianShortFormat.format(date);
  }
  
  /// Format DateTime as time only (HH:mm)
  static String formatAsTime(DateTime? date) {
    if (date == null) return '';
    return _timeFormat.format(date);
  }
  
  /// Format DateTime as time with seconds (HH:mm:ss)
  static String formatAsTimeWithSeconds(DateTime? date) {
    if (date == null) return '';
    return _timeWithSecondsFormat.format(date);
  }
  
  /// Format DateTime for API (yyyy-MM-dd)
  static String formatForApi(DateTime? date) {
    if (date == null) return '';
    return _apiDateFormat.format(date);
  }
  
  /// Format DateTime for API with time (yyyy-MM-dd HH:mm:ss)
  static String formatForApiWithTime(DateTime? date) {
    if (date == null) return '';
    return _apiDateTimeFormat.format(date);
  }
  
  /// Format DateTime as file-safe timestamp (yyyyMMdd_HHmmss)
  static String formatAsTimestamp(DateTime? date) {
    if (date == null) return '';
    return _timestampFormat.format(date);
  }
  
  /// Format DateTime as month-year (Januari 2024)
  static String formatAsMonthYear(DateTime? date) {
    if (date == null) return '';
    return _monthYearFormat.format(date);
  }
  
  /// Get relative time in Indonesian
  static String getRelativeTimeInIndonesian(DateTime? date) {
    if (date == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'tahun' : 'tahun'} yang lalu';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'bulan' : 'bulan'} yang lalu';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'hari' : 'hari'} yang lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'jam' : 'jam'} yang lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'menit' : 'menit'} yang lalu';
    } else {
      return 'Baru saja';
    }
  }
  
  /// Get smart relative time (shows date if > 7 days, otherwise relative)
  static String getSmartRelativeTime(DateTime? date) {
    if (date == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 7) {
      return formatAsShortIndonesian(date);
    } else {
      return getRelativeTimeInIndonesian(date);
    }
  }
  
  /// Check if date is today
  static bool isToday(DateTime? date) {
    if (date == null) return false;
    
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }
  
  /// Check if date is yesterday
  static bool isYesterday(DateTime? date) {
    if (date == null) return false;
    
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return date.year == yesterday.year && 
           date.month == yesterday.month && 
           date.day == yesterday.day;
  }
  
  /// Check if date is tomorrow
  static bool isTomorrow(DateTime? date) {
    if (date == null) return false;
    
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year && 
           date.month == tomorrow.month && 
           date.day == tomorrow.day;
  }
  
  /// Check if date is this week
  static bool isThisWeek(DateTime? date) {
    if (date == null) return false;
    
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    final startOfWeekMidnight = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
    final endOfWeekMidnight = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);
    
    return date.isAfter(startOfWeekMidnight) && date.isBefore(endOfWeekMidnight);
  }
  
  /// Check if date is this month
  static bool isThisMonth(DateTime? date) {
    if (date == null) return false;
    
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }
  
  /// Check if date is this year
  static bool isThisYear(DateTime? date) {
    if (date == null) return false;
    return date.year == DateTime.now().year;
  }
  
  /// Get start of day (00:00:00)
  static DateTime getStartOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
  
  /// Get end of day (23:59:59.999)
  static DateTime getEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59, 999);
  }
  
  /// Get start of week (Monday 00:00:00)
  static DateTime getStartOfWeek(DateTime date) {
    final monday = date.subtract(Duration(days: date.weekday - 1));
    return getStartOfDay(monday);
  }
  
  /// Get end of week (Sunday 23:59:59.999)
  static DateTime getEndOfWeek(DateTime date) {
    final sunday = date.add(Duration(days: 7 - date.weekday));
    return getEndOfDay(sunday);
  }
  
  /// Get start of month (first day 00:00:00)
  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }
  
  /// Get end of month (last day 23:59:59.999)
  static DateTime getEndOfMonth(DateTime date) {
    final nextMonth = date.month == 12 
        ? DateTime(date.year + 1, 1, 1) 
        : DateTime(date.year, date.month + 1, 1);
    return getEndOfDay(nextMonth.subtract(const Duration(days: 1)));
  }
  
  /// Get start of year (January 1st 00:00:00)
  static DateTime getStartOfYear(DateTime date) {
    return DateTime(date.year, 1, 1);
  }
  
  /// Get end of year (December 31st 23:59:59.999)
  static DateTime getEndOfYear(DateTime date) {
    return getEndOfDay(DateTime(date.year, 12, 31));
  }
  
  /// Get date range for a specific period
  static DateRange getDateRangeForPeriod(String period) {
    final now = DateTime.now();
    
    switch (period.toLowerCase()) {
      case 'today':
        return DateRange(
          start: getStartOfDay(now),
          end: getEndOfDay(now),
        );
      case 'yesterday':
        final yesterday = now.subtract(const Duration(days: 1));
        return DateRange(
          start: getStartOfDay(yesterday),
          end: getEndOfDay(yesterday),
        );
      case 'this_week':
        return DateRange(
          start: getStartOfWeek(now),
          end: getEndOfWeek(now),
        );
      case 'last_week':
        final lastWeek = now.subtract(const Duration(days: 7));
        return DateRange(
          start: getStartOfWeek(lastWeek),
          end: getEndOfWeek(lastWeek),
        );
      case 'this_month':
        return DateRange(
          start: getStartOfMonth(now),
          end: getEndOfMonth(now),
        );
      case 'last_month':
        final lastMonth = DateTime(now.year, now.month - 1);
        return DateRange(
          start: getStartOfMonth(lastMonth),
          end: getEndOfMonth(lastMonth),
        );
      case 'this_year':
        return DateRange(
          start: getStartOfYear(now),
          end: getEndOfYear(now),
        );
      default:
        return DateRange(
          start: getStartOfDay(now),
          end: getEndOfDay(now),
        );
    }
  }
  
  /// Calculate business days between two dates (excluding weekends)
  static int calculateBusinessDaysBetween(DateTime start, DateTime end) {
    if (start.isAfter(end)) return 0;
    
    int businessDays = 0;
    DateTime current = start;
    
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      // Monday = 1, Sunday = 7
      if (current.weekday >= 1 && current.weekday <= 5) {
        businessDays++;
      }
      current = current.add(const Duration(days: 1));
    }
    
    return businessDays;
  }
  
  /// Add business days to a date (excluding weekends)
  static DateTime addBusinessDays(DateTime date, int days) {
    DateTime result = date;
    int remainingDays = days.abs();
    final increment = days.isNegative ? -1 : 1;
    
    while (remainingDays > 0) {
      result = result.add(Duration(days: increment));
      // Check if it's a weekday (Monday to Friday)
      if (result.weekday >= 1 && result.weekday <= 5) {
        remainingDays--;
      }
    }
    
    return result;
  }
  
  /// Get Indonesian month names
  static List<String> get indonesianMonthNames => [
    'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
    'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
  ];
  
  /// Get Indonesian day names
  static List<String> get indonesianDayNames => [
    'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
  ];
  
  /// Get Indonesian short month names
  static List<String> get shortIndonesianMonthNames => [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des'
  ];
  
  /// Get Indonesian short day names
  static List<String> get shortIndonesianDayNames => [
    'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'
  ];
  
  /// Get Indonesian month name by index (1-12)
  static String getIndonesianMonthName(int month) {
    if (month < 1 || month > 12) throw ArgumentError('Month must be between 1 and 12');
    return indonesianMonthNames[month - 1];
  }
  
  /// Get Indonesian day name by weekday (1-7, Monday-Sunday)
  static String getIndonesianDayName(int weekday) {
    if (weekday < 1 || weekday > 7) throw ArgumentError('Weekday must be between 1 and 7');
    return indonesianDayNames[weekday - 1];
  }
  
  /// Validate if a string can be parsed as a date
  static bool isValidDateString(String? dateString, {String? format}) {
    if (dateString == null || dateString.trim().isEmpty) return false;
    
    try {
      if (format != null) {
        DateFormat(format).parse(dateString.trim());
      } else {
        // Try common formats
        return parseIndonesianDate(dateString) != null ||
               parseApiDate(dateString) != null ||
               parseIsoDate(dateString) != null;
      }
      return true;
    } catch (e) {
      return false;
    }
  }
  
  /// Get age in years from birthdate
  static int calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    int age = now.year - birthDate.year;
    
    if (now.month < birthDate.month || 
        (now.month == birthDate.month && now.day < birthDate.day)) {
      age--;
    }
    
    return age;
  }
  
  /// Get days between two dates
  static int daysBetween(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }
  
  /// Check if a year is leap year
  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }
  
  /// Get number of days in a month
  static int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}

/// Simple date range class
class DateRange {
  final DateTime start;
  final DateTime end;
  
  const DateRange({
    required this.start,
    required this.end,
  });
  
  /// Check if a date is within this range
  bool contains(DateTime date) {
    return date.isAfter(start) && date.isBefore(end) || 
           date.isAtSameMomentAs(start) || 
           date.isAtSameMomentAs(end);
  }
  
  /// Get duration of this range
  Duration get duration => end.difference(start);
  
  /// Get number of days in this range
  int get days => duration.inDays + 1;
  
  @override
  String toString() => 'DateRange(start: $start, end: $end)';
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DateRange &&
          runtimeType == other.runtimeType &&
          start == other.start &&
          end == other.end;
  
  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}