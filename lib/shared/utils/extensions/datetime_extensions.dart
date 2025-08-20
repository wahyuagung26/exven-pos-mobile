/// DateTime extensions for formatting, manipulation, and Indonesian locale support
/// 
/// This file contains extension methods on DateTime for date formatting,
/// manipulation, comparison, and Indonesian-specific formatting.

import 'package:intl/intl.dart';

/// Extension on DateTime for formatting operations
extension DateTimeFormattingExtension on DateTime {
  /// Format as Indonesian date format (dd/MM/yyyy)
  String get formatAsIndonesianDate {
    return DateFormat('dd/MM/yyyy', 'id_ID').format(this);
  }
  
  /// Format as Indonesian date with time (dd/MM/yyyy HH:mm)
  String get formatAsIndonesianDateTime {
    return DateFormat('dd/MM/yyyy HH:mm', 'id_ID').format(this);
  }
  
  /// Format as readable Indonesian date (1 Januari 2024)
  String get formatAsReadableIndonesian {
    return DateFormat('d MMMM yyyy', 'id_ID').format(this);
  }
  
  /// Format as readable Indonesian with day (Senin, 1 Januari 2024)
  String get formatAsFullIndonesian {
    return DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(this);
  }
  
  /// Format as Indonesian short date (1 Jan 2024)
  String get formatAsShortIndonesian {
    return DateFormat('d MMM yyyy', 'id_ID').format(this);
  }
  
  /// Format time only (HH:mm)
  String get formatTime {
    return DateFormat('HH:mm').format(this);
  }
  
  /// Format time with seconds (HH:mm:ss)
  String get formatTimeWithSeconds {
    return DateFormat('HH:mm:ss').format(this);
  }
  
  /// Format as 12-hour time (h:mm a)
  String get formatTime12Hour {
    return DateFormat('h:mm a', 'id_ID').format(this);
  }
  
  /// Format as ISO 8601 string
  String get formatAsIso8601 {
    return toIso8601String();
  }
  
  /// Format for API (yyyy-MM-dd)
  String get formatForApi {
    return DateFormat('yyyy-MM-dd').format(this);
  }
  
  /// Format for API with time (yyyy-MM-dd HH:mm:ss)
  String get formatForApiWithTime {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }
  
  /// Format as file-safe timestamp (yyyyMMdd_HHmmss)
  String get formatAsTimestamp {
    return DateFormat('yyyyMMdd_HHmmss').format(this);
  }
  
  /// Format as month-year (Januari 2024)
  String get formatAsMonthYear {
    return DateFormat('MMMM yyyy', 'id_ID').format(this);
  }
  
  /// Format as day-month (1 Januari)
  String get formatAsDayMonth {
    return DateFormat('d MMMM', 'id_ID').format(this);
  }
}

/// Extension on DateTime for relative time formatting
extension RelativeTimeExtension on DateTime {
  /// Get relative time in Indonesian (misalnya: "2 jam yang lalu")
  String get relativeTimeInIndonesian {
    final now = DateTime.now();
    final difference = now.difference(this);
    
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
  
  /// Get relative time in English
  String get relativeTime {
    final now = DateTime.now();
    final difference = now.difference(this);
    
    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
  
  /// Get smart relative time (shows date if > 7 days, otherwise relative)
  String get smartRelativeTime {
    final now = DateTime.now();
    final difference = now.difference(this);
    
    if (difference.inDays > 7) {
      return formatAsShortIndonesian;
    } else {
      return relativeTimeInIndonesian;
    }
  }
}

/// Extension on DateTime for comparison and checks
extension DateTimeComparisonExtension on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }
  
  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year && 
           month == yesterday.month && 
           day == yesterday.day;
  }
  
  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year && 
           month == tomorrow.month && 
           day == tomorrow.day;
  }
  
  /// Check if date is this week
  bool get isThisWeek {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    
    return isAfter(startOfWeek.copyWith(hour: 0, minute: 0, second: 0)) &&
           isBefore(endOfWeek.copyWith(hour: 23, minute: 59, second: 59));
  }
  
  /// Check if date is this month
  bool get isThisMonth {
    final now = DateTime.now();
    return year == now.year && month == now.month;
  }
  
  /// Check if date is this year
  bool get isThisYear {
    return year == DateTime.now().year;
  }
  
  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());
  
  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());
  
  /// Check if date is weekend (Saturday or Sunday)
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
  
  /// Check if date is weekday (Monday to Friday)
  bool get isWeekday => !isWeekend;
  
  /// Check if same date (ignoring time)
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
  
  /// Check if same month and year
  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }
  
  /// Check if same year
  bool isSameYear(DateTime other) {
    return year == other.year;
  }
}

/// Extension on DateTime for manipulation
extension DateTimeManipulationExtension on DateTime {
  /// Get start of day (00:00:00)
  DateTime get startOfDay {
    return DateTime(year, month, day);
  }
  
  /// Get end of day (23:59:59.999)
  DateTime get endOfDay {
    return DateTime(year, month, day, 23, 59, 59, 999);
  }
  
  /// Get start of week (Monday 00:00:00)
  DateTime get startOfWeek {
    final monday = subtract(Duration(days: weekday - 1));
    return monday.startOfDay;
  }
  
  /// Get end of week (Sunday 23:59:59.999)
  DateTime get endOfWeek {
    final sunday = add(Duration(days: 7 - weekday));
    return sunday.endOfDay;
  }
  
  /// Get start of month (first day 00:00:00)
  DateTime get startOfMonth {
    return DateTime(year, month, 1);
  }
  
  /// Get end of month (last day 23:59:59.999)
  DateTime get endOfMonth {
    final nextMonth = month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
    return nextMonth.subtract(const Duration(days: 1)).endOfDay;
  }
  
  /// Get start of year (January 1st 00:00:00)
  DateTime get startOfYear {
    return DateTime(year, 1, 1);
  }
  
  /// Get end of year (December 31st 23:59:59.999)
  DateTime get endOfYear {
    return DateTime(year, 12, 31).endOfDay;
  }
  
  /// Add business days (excluding weekends)
  DateTime addBusinessDays(int days) {
    DateTime result = this;
    int remainingDays = days.abs();
    final increment = days.isNegative ? -1 : 1;
    
    while (remainingDays > 0) {
      result = result.add(Duration(days: increment));
      if (result.isWeekday) {
        remainingDays--;
      }
    }
    
    return result;
  }
  
  /// Get next weekday occurrence
  DateTime nextWeekday(int weekday) {
    assert(weekday >= 1 && weekday <= 7);
    
    int daysToAdd = weekday - this.weekday;
    if (daysToAdd <= 0) daysToAdd += 7;
    
    return add(Duration(days: daysToAdd));
  }
  
  /// Get previous weekday occurrence
  DateTime previousWeekday(int weekday) {
    assert(weekday >= 1 && weekday <= 7);
    
    int daysToSubtract = this.weekday - weekday;
    if (daysToSubtract <= 0) daysToSubtract += 7;
    
    return subtract(Duration(days: daysToSubtract));
  }
  
  /// Get age in years
  int get age {
    final now = DateTime.now();
    int age = now.year - year;
    
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    
    return age;
  }
  
  /// Copy with modified values
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

/// Extension on DateTime for business operations
extension BusinessDateExtension on DateTime {
  /// Get Indonesian month name
  String get indonesianMonthName {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month - 1];
  }
  
  /// Get Indonesian day name
  String get indonesianDayName {
    const days = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    return days[weekday - 1];
  }
  
  /// Get short Indonesian month name
  String get shortIndonesianMonthName {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Ags', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return months[month - 1];
  }
  
  /// Get short Indonesian day name
  String get shortIndonesianDayName {
    const days = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return days[weekday - 1];
  }
  
  /// Check if date falls on Indonesian public holiday
  bool get isIndonesianPublicHoliday {
    // Note: This is a simplified version. In a real app, you might want to
    // use a proper holiday calculation library or API
    
    // New Year's Day
    if (month == 1 && day == 1) return true;
    
    // Independence Day
    if (month == 8 && day == 17) return true;
    
    // Christmas
    if (month == 12 && day == 25) return true;
    
    // Add more holidays as needed
    return false;
  }
  
  /// Get quarter of the year (1-4)
  int get quarter {
    return ((month - 1) ~/ 3) + 1;
  }
  
  /// Get week number of the year
  int get weekOfYear {
    final startOfYear = DateTime(year, 1, 1);
    final days = difference(startOfYear).inDays;
    return (days / 7).ceil();
  }
  
  /// Check if leap year
  bool get isLeapYear {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }
  
  /// Get days in current month
  int get daysInMonth {
    return DateTime(year, month + 1, 0).day;
  }
}

/// Extension on DateTime for time zone operations
extension TimeZoneExtension on DateTime {
  /// Convert to Indonesian time zone (WIB - UTC+7)
  DateTime get toIndonesianTime {
    return toUtc().add(const Duration(hours: 7));
  }
  
  /// Check if daylight saving time (not applicable in Indonesia)
  bool get isDaylightSavingTime {
    return false; // Indonesia doesn't use daylight saving time
  }
  
  /// Get timezone offset in hours
  int get timezoneOffsetHours {
    return timeZoneOffset.inHours;
  }
  
  /// Format timezone offset as string (+07:00)
  String get timezoneOffsetString {
    final hours = timeZoneOffset.inHours;
    final minutes = timeZoneOffset.inMinutes % 60;
    final sign = hours >= 0 ? '+' : '-';
    return '$sign${hours.abs().toString().padLeft(2, '0')}:${minutes.abs().toString().padLeft(2, '0')}';
  }
}

/// Extension on nullable DateTime
extension NullableDateTimeExtension on DateTime? {
  /// Check if nullable DateTime is null
  bool get isNull => this == null;
  
  /// Check if nullable DateTime is not null
  bool get isNotNull => this != null;
  
  /// Get formatted date or default string if null
  String formatOrDefault(String defaultValue) {
    return this?.formatAsIndonesianDate ?? defaultValue;
  }
  
  /// Get relative time or default string if null
  String relativeTimeOrDefault(String defaultValue) {
    return this?.relativeTimeInIndonesian ?? defaultValue;
  }
  
  /// Safe comparison with another nullable DateTime
  bool isAfterOrNull(DateTime? other) {
    if (this == null || other == null) return false;
    return this!.isAfter(other);
  }
  
  /// Safe comparison with another nullable DateTime
  bool isBeforeOrNull(DateTime? other) {
    if (this == null || other == null) return false;
    return this!.isBefore(other);
  }
}

/// Utility functions for DateTime operations
class DateTimeUtils {
  /// Parse Indonesian date string (dd/MM/yyyy)
  static DateTime? parseIndonesianDate(String dateString) {
    try {
      return DateFormat('dd/MM/yyyy').parse(dateString);
    } catch (e) {
      return null;
    }
  }
  
  /// Parse Indonesian date time string (dd/MM/yyyy HH:mm)
  static DateTime? parseIndonesianDateTime(String dateTimeString) {
    try {
      return DateFormat('dd/MM/yyyy HH:mm').parse(dateTimeString);
    } catch (e) {
      return null;
    }
  }
  
  /// Get date range for a specific period
  static DateTimeRange getDateRangeForPeriod(String period) {
    final now = DateTime.now();
    
    switch (period.toLowerCase()) {
      case 'today':
        return DateTimeRange(
          start: now.startOfDay,
          end: now.endOfDay,
        );
      case 'yesterday':
        final yesterday = now.subtract(const Duration(days: 1));
        return DateTimeRange(
          start: yesterday.startOfDay,
          end: yesterday.endOfDay,
        );
      case 'this_week':
        return DateTimeRange(
          start: now.startOfWeek,
          end: now.endOfWeek,
        );
      case 'last_week':
        final lastWeek = now.subtract(const Duration(days: 7));
        return DateTimeRange(
          start: lastWeek.startOfWeek,
          end: lastWeek.endOfWeek,
        );
      case 'this_month':
        return DateTimeRange(
          start: now.startOfMonth,
          end: now.endOfMonth,
        );
      case 'last_month':
        final lastMonth = DateTime(now.year, now.month - 1);
        return DateTimeRange(
          start: lastMonth.startOfMonth,
          end: lastMonth.endOfMonth,
        );
      case 'this_year':
        return DateTimeRange(
          start: now.startOfYear,
          end: now.endOfYear,
        );
      default:
        return DateTimeRange(
          start: now.startOfDay,
          end: now.endOfDay,
        );
    }
  }
  
  /// Calculate business days between two dates
  static int businessDaysBetween(DateTime start, DateTime end) {
    if (start.isAfter(end)) return 0;
    
    int businessDays = 0;
    DateTime current = start;
    
    while (current.isBefore(end) || current.isSameDate(end)) {
      if (current.isWeekday) {
        businessDays++;
      }
      current = current.add(const Duration(days: 1));
    }
    
    return businessDays;
  }
}