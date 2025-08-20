class FormValidators {
  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]+$');
    if (!phoneRegex.hasMatch(value) || value.length < 10) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  static String? Function(String?) minLength(int minLength, [String? fieldName]) {
    return (String? value) {
      if (value == null || value.length < minLength) {
        return '${fieldName ?? 'This field'} must be at least $minLength characters long';
      }
      return null;
    };
  }

  static String? Function(String?) maxLength(int maxLength, [String? fieldName]) {
    return (String? value) {
      if (value != null && value.length > maxLength) {
        return '${fieldName ?? 'This field'} must be no more than $maxLength characters long';
      }
      return null;
    };
  }

  static String? Function(String?) lengthRange(int minLength, int maxLength, [String? fieldName]) {
    return (String? value) {
      if (value == null || value.length < minLength) {
        return '${fieldName ?? 'This field'} must be at least $minLength characters long';
      }
      if (value.length > maxLength) {
        return '${fieldName ?? 'This field'} must be no more than $maxLength characters long';
      }
      return null;
    };
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least one number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      }
      if (value != password) {
        return 'Passwords do not match';
      }
      return null;
    };
  }

  static String? numeric(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (double.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a valid number';
    }

    return null;
  }

  static String? integer(String? value, [String? fieldName]) {
    if (value == null || value.isEmpty) {
      return '${fieldName ?? 'This field'} is required';
    }

    if (int.tryParse(value) == null) {
      return '${fieldName ?? 'This field'} must be a whole number';
    }

    return null;
  }

  static String? Function(String?) minValue(double minValue, [String? fieldName]) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '${fieldName ?? 'This field'} is required';
      }

      final numValue = double.tryParse(value);
      if (numValue == null) {
        return '${fieldName ?? 'This field'} must be a valid number';
      }

      if (numValue < minValue) {
        return '${fieldName ?? 'This field'} must be at least $minValue';
      }

      return null;
    };
  }

  static String? Function(String?) maxValue(double maxValue, [String? fieldName]) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '${fieldName ?? 'This field'} is required';
      }

      final numValue = double.tryParse(value);
      if (numValue == null) {
        return '${fieldName ?? 'This field'} must be a valid number';
      }

      if (numValue > maxValue) {
        return '${fieldName ?? 'This field'} must be no more than $maxValue';
      }

      return null;
    };
  }

  static String? Function(String?) valueRange(double minValue, double maxValue, [String? fieldName]) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return '${fieldName ?? 'This field'} is required';
      }

      final numValue = double.tryParse(value);
      if (numValue == null) {
        return '${fieldName ?? 'This field'} must be a valid number';
      }

      if (numValue < minValue || numValue > maxValue) {
        return '${fieldName ?? 'This field'} must be between $minValue and $maxValue';
      }

      return null;
    };
  }

  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$'
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  static String? Function(String?) pattern(RegExp pattern, String message) {
    return (String? value) {
      if (value != null && value.isNotEmpty && !pattern.hasMatch(value)) {
        return message;
      }
      return null;
    };
  }

  static String? Function(String?) compose(List<String? Function(String?)> validators) {
    return (String? value) {
      for (final validator in validators) {
        final result = validator(value);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }

  static String? productName(String? value) {
    return compose([
      required,
      minLength(2, 'Product name'),
      maxLength(100, 'Product name'),
    ])(value);
  }

  static String? productPrice(String? value) {
    return compose([
      required,
      numeric,
      minValue(0.01, 'Price'),
    ])(value);
  }

  static String? productCode(String? value) {
    return compose([
      required,
      pattern(RegExp(r'^[A-Za-z0-9\-_]+$'), 'Product code can only contain letters, numbers, hyphens, and underscores'),
      lengthRange(2, 50, 'Product code'),
    ])(value);
  }

  static String? customerName(String? value) {
    return compose([
      required,
      minLength(2, 'Customer name'),
      maxLength(100, 'Customer name'),
    ])(value);
  }

  static String? businessName(String? value) {
    return compose([
      required,
      minLength(2, 'Business name'),
      maxLength(100, 'Business name'),
    ])(value);
  }

  static String? address(String? value) {
    return compose([
      required,
      minLength(10, 'Address'),
      maxLength(200, 'Address'),
    ])(value);
  }

  static String? taxNumber(String? value) {
    if (value != null && value.isNotEmpty) {
      return compose([
        pattern(RegExp(r'^[A-Za-z0-9\-\.]+$'), 'Tax number contains invalid characters'),
        lengthRange(5, 50, 'Tax number'),
      ])(value);
    }
    return null;
  }
}