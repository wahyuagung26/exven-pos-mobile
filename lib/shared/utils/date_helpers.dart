/// Date and timestamp utilities for offline-first POS system
/// All timestamps are stored as Unix milliseconds for consistency
class DateHelpers {
  /// Get current timestamp in Unix milliseconds
  static int now() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  /// Convert DateTime to Unix milliseconds
  static int toUnixMillis(DateTime dateTime) {
    return dateTime.millisecondsSinceEpoch;
  }

  /// Convert Unix milliseconds to DateTime
  static DateTime fromUnixMillis(int unixMillis) {
    return DateTime.fromMillisecondsSinceEpoch(unixMillis);
  }

  /// Get start of day in Unix milliseconds (local time)
  static int startOfDay([DateTime? date]) {
    final targetDate = date ?? DateTime.now();
    final startOfDay = DateTime(targetDate.year, targetDate.month, targetDate.day);
    return startOfDay.millisecondsSinceEpoch;
  }

  /// Get end of day in Unix milliseconds (local time)
  static int endOfDay([DateTime? date]) {
    final targetDate = date ?? DateTime.now();
    final endOfDay = DateTime(targetDate.year, targetDate.month, targetDate.day, 23, 59, 59, 999);
    return endOfDay.millisecondsSinceEpoch;
  }

  /// Get start of month in Unix milliseconds (local time)
  static int startOfMonth([DateTime? date]) {
    final targetDate = date ?? DateTime.now();
    final startOfMonth = DateTime(targetDate.year, targetDate.month, 1);
    return startOfMonth.millisecondsSinceEpoch;
  }

  /// Get end of month in Unix milliseconds (local time)
  static int endOfMonth([DateTime? date]) {
    final targetDate = date ?? DateTime.now();
    final endOfMonth = DateTime(targetDate.year, targetDate.month + 1, 1)
        .subtract(const Duration(milliseconds: 1));
    return endOfMonth.millisecondsSinceEpoch;
  }

  /// Get timestamp for N days ago
  static int daysAgo(int days) {
    return DateTime.now()
        .subtract(Duration(days: days))
        .millisecondsSinceEpoch;
  }

  /// Get timestamp for N days from now
  static int daysFromNow(int days) {
    return DateTime.now()
        .add(Duration(days: days))
        .millisecondsSinceEpoch;
  }

  /// Check if timestamp is today (local time)
  static bool isToday(int unixMillis) {
    final date = DateTime.fromMillisecondsSinceEpoch(unixMillis);
    final now = DateTime.now();
    return date.year == now.year && 
           date.month == now.month && 
           date.day == now.day;
  }

  /// Check if timestamp is this month (local time)
  static bool isThisMonth(int unixMillis) {
    final date = DateTime.fromMillisecondsSinceEpoch(unixMillis);
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month;
  }

  /// Format Unix milliseconds to readable date string
  static String formatDate(int unixMillis, [String pattern = 'yyyy-MM-dd']) {
    final date = DateTime.fromMillisecondsSinceEpoch(unixMillis);
    
    switch (pattern) {
      case 'yyyy-MM-dd':
        return '${date.year.toString().padLeft(4, '0')}-'
               '${date.month.toString().padLeft(2, '0')}-'
               '${date.day.toString().padLeft(2, '0')}';
      
      case 'dd/MM/yyyy':
        return '${date.day.toString().padLeft(2, '0')}/'
               '${date.month.toString().padLeft(2, '0')}/'
               '${date.year}';
      
      case 'dd MMM yyyy':
        return '${date.day} ${_getMonthName(date.month)} ${date.year}';
      
      case 'HH:mm':
        return '${date.hour.toString().padLeft(2, '0')}:'
               '${date.minute.toString().padLeft(2, '0')}';
      
      case 'dd/MM/yyyy HH:mm':
        return '${formatDate(unixMillis, 'dd/MM/yyyy')} '
               '${formatDate(unixMillis, 'HH:mm')}';
      
      default:
        return date.toString();
    }
  }

  /// Format Unix milliseconds to Indonesian date string
  static String formatDateIndonesian(int unixMillis, [bool includeTime = false]) {
    final date = DateTime.fromMillisecondsSinceEpoch(unixMillis);
    final day = date.day;
    final month = _getIndonesianMonthName(date.month);
    final year = date.year;
    
    String result = '$day $month $year';
    
    if (includeTime) {
      final hour = date.hour.toString().padLeft(2, '0');
      final minute = date.minute.toString().padLeft(2, '0');
      result += ' $hour:$minute';
    }
    
    return result;
  }

  /// Get time difference in human readable format
  static String getTimeAgo(int unixMillis) {
    final now = DateTime.now();
    final date = DateTime.fromMillisecondsSinceEpoch(unixMillis);
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays} hari lalu';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} menit lalu';
    } else {
      return 'Baru saja';
    }
  }

  /// Parse date string to Unix milliseconds
  static int parseDate(String dateString, [String pattern = 'yyyy-MM-dd']) {
    DateTime date;
    
    try {
      switch (pattern) {
        case 'yyyy-MM-dd':
          final parts = dateString.split('-');
          date = DateTime(
            int.parse(parts[0]), // year
            int.parse(parts[1]), // month
            int.parse(parts[2]), // day
          );
          break;
        
        case 'dd/MM/yyyy':
          final parts = dateString.split('/');
          date = DateTime(
            int.parse(parts[2]), // year
            int.parse(parts[1]), // month
            int.parse(parts[0]), // day
          );
          break;
        
        default:
          date = DateTime.parse(dateString);
      }
      
      return date.millisecondsSinceEpoch;
    } catch (e) {
      throw FormatException('Invalid date format: $dateString');
    }
  }

  /// Get readable duration between two timestamps
  static String getDuration(int startUnixMillis, int endUnixMillis) {
    final duration = Duration(milliseconds: endUnixMillis - startUnixMillis);
    
    if (duration.inDays > 0) {
      return '${duration.inDays} hari';
    } else if (duration.inHours > 0) {
      return '${duration.inHours} jam ${duration.inMinutes % 60} menit';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes} menit';
    } else {
      return '${duration.inSeconds} detik';
    }
  }

  /// Get English month name
  static String _getMonthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  /// Get Indonesian month name
  static String _getIndonesianMonthName(int month) {
    const months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return months[month];
  }

  /// Get day name in Indonesian
  static String getIndonesianDayName(int unixMillis) {
    final date = DateTime.fromMillisecondsSinceEpoch(unixMillis);
    const days = [
      '', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    return days[date.weekday];
  }

  /// Get business day boundaries (9 AM to 9 PM)
  static (int start, int end) getBusinessDay([DateTime? date]) {
    final targetDate = date ?? DateTime.now();
    final startTime = DateTime(
      targetDate.year, 
      targetDate.month, 
      targetDate.day, 
      9, 0, 0
    );
    final endTime = DateTime(
      targetDate.year, 
      targetDate.month, 
      targetDate.day, 
      21, 0, 0
    );
    
    return (startTime.millisecondsSinceEpoch, endTime.millisecondsSinceEpoch);
  }
}

/// Extension methods for easier date operations
extension DateTimeExtensions on DateTime {
  /// Convert to Unix milliseconds
  int get unixMillis => millisecondsSinceEpoch;
  
  /// Get start of day
  DateTime get startOfDay => DateTime(year, month, day);
  
  /// Get end of day
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
  
  /// Format to Indonesian date
  String get indonesianDate => DateHelpers.formatDateIndonesian(unixMillis);
  
  /// Format to Indonesian date with time
  String get indonesianDateTime => DateHelpers.formatDateIndonesian(unixMillis, true);
  
  /// Get time ago string
  String get timeAgo => DateHelpers.getTimeAgo(unixMillis);
}

extension IntDateExtensions on int {
  /// Convert Unix milliseconds to DateTime
  DateTime get toDateTime => DateTime.fromMillisecondsSinceEpoch(this);
  
  /// Format Unix milliseconds to date string
  String toDateString([String pattern = 'yyyy-MM-dd']) => 
      DateHelpers.formatDate(this, pattern);
  
  /// Format to Indonesian date
  String get toIndonesianDate => DateHelpers.formatDateIndonesian(this);
  
  /// Check if timestamp is today
  bool get isToday => DateHelpers.isToday(this);
  
  /// Check if timestamp is this month
  bool get isThisMonth => DateHelpers.isThisMonth(this);
  
  /// Get time ago string
  String get timeAgo => DateHelpers.getTimeAgo(this);
}