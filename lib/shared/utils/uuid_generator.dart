import 'dart:math';
import 'dart:typed_data';

/// UUID v7 Generator for time-ordered identifiers
/// 
/// UUID v7 format:
/// - 48 bits: timestamp (milliseconds since Unix epoch)
/// - 12 bits: version (7) and random data
/// - 62 bits: random data
/// - 2 bits: variant (10)
class UuidV7Generator {
  static final Random _random = Random.secure();
  static const int _version = 7;
  static const int _variant = 2; // RFC 4122 variant (10 in binary)

  /// Generate a UUID v7 string
  static String generate() {
    final bytes = generateBytes();
    return _formatAsUuid(bytes);
  }

  /// Generate UUID v7 as raw bytes
  static Uint8List generateBytes() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final bytes = Uint8List(16);

    // 48 bits: timestamp (big-endian)
    bytes[0] = (now >> 40) & 0xFF;
    bytes[1] = (now >> 32) & 0xFF;
    bytes[2] = (now >> 24) & 0xFF;
    bytes[3] = (now >> 16) & 0xFF;
    bytes[4] = (now >> 8) & 0xFF;
    bytes[5] = now & 0xFF;

    // 12 bits: version (4 bits) + random (8 bits)
    bytes[6] = (_version << 4) | (_random.nextInt(16) & 0x0F);
    bytes[7] = _random.nextInt(256);

    // 62 bits: random data (8 bytes)
    for (int i = 8; i < 16; i++) {
      bytes[i] = _random.nextInt(256);
    }

    // 2 bits: variant (10 in binary)
    // Set the two most significant bits of byte 8 to 10
    bytes[8] = (bytes[8] & 0x3F) | 0x80; // 10xxxxxx

    return bytes;
  }

  /// Parse timestamp from UUID v7 string
  static DateTime getTimestamp(String uuid) {
    final cleanUuid = uuid.replaceAll('-', '');
    if (cleanUuid.length != 32) {
      throw ArgumentError('Invalid UUID format');
    }

    // Extract first 12 hex chars (48 bits = 6 bytes)
    final timestampHex = cleanUuid.substring(0, 12);
    final timestamp = int.parse(timestampHex, radix: 16);
    
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  /// Validate if string is a valid UUID v7
  static bool isValid(String uuid) {
    try {
      final cleanUuid = uuid.replaceAll('-', '');
      if (cleanUuid.length != 32) return false;
      
      // Check version (should be 7)
      final versionHex = cleanUuid.substring(12, 13);
      final version = int.parse(versionHex, radix: 16);
      if (version != _version) return false;
      
      // Check variant (2 most significant bits should be 10)
      final variantHex = cleanUuid.substring(16, 17);
      final variant = int.parse(variantHex, radix: 16);
      if ((variant & 0xC) != 0x8) return false; // 1000xxxx
      
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Generate multiple UUIDs in order (for testing)
  static List<String> generateBatch(int count) {
    final uuids = <String>[];
    for (int i = 0; i < count; i++) {
      uuids.add(generate());
      // Small delay to ensure different timestamps
      if (i < count - 1) {
        Future.delayed(const Duration(milliseconds: 1));
      }
    }
    return uuids;
  }

  /// Format bytes as UUID string with hyphens
  static String _formatAsUuid(Uint8List bytes) {
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    
    return '${hex.substring(0, 8)}-'
           '${hex.substring(8, 12)}-'
           '${hex.substring(12, 16)}-'
           '${hex.substring(16, 20)}-'
           '${hex.substring(20, 32)}';
  }
}

/// Extension methods for easier UUID operations
extension UuidV7String on String {
  /// Check if this string is a valid UUID v7
  bool get isValidUuidV7 => UuidV7Generator.isValid(this);
  
  /// Get timestamp from this UUID v7 string
  DateTime get uuidTimestamp => UuidV7Generator.getTimestamp(this);
  
  /// Remove hyphens from UUID string
  String get cleanUuid => replaceAll('-', '');
}