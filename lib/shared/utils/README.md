# Utils Documentation

This directory contains utility classes for common operations in the POS System Flutter app.

## AuthUtil

Utility class for managing user authentication and user data persistence using SharedPreferences.

### Features:
- Set and get authentication token
- Set and get logged user data
- Check if user is logged in
- Logout functionality
- Update logged user data

### Usage:

```dart
import 'package:pos_system/shared/utils/auth_util.dart';
import 'package:pos_system/features/auth/domain/entities/user.dart';

// Set authentication token
await AuthUtil.setAuthToken('your_jwt_token');

// Get authentication token
final token = await AuthUtil.getAuthToken();

// Set logged user
final user = User(
  id: '1',
  email: 'user@example.com',
  name: 'John Doe',
  createdAt: DateTime.now(),
);
await AuthUtil.setLoggedUser(user);

// Get logged user
final loggedUser = await AuthUtil.getLoggedUser();

// Check if logged in
final isLoggedIn = await AuthUtil.isLoggedIn();

// Logout
await AuthUtil.logout();
```

## HttpUtil

Utility class for making HTTP requests with optional Bearer token authentication using Dio and functional error handling with Either type.

### Features:
- GET, POST, PUT, DELETE methods
- Optional authentication with Bearer token
- Additional headers support
- Functional error handling with Either<Failure, Response>
- Automatic error mapping to specific failure types

### Usage:

```dart
import 'package:pos_system/shared/utils/http_util.dart';

// GET request without authentication
final result = await HttpUtil.get('/api/public-data');
result.fold(
  (failure) => print('Error: ${failure.message}'),
  (response) => print('Success: ${response.data}'),
);

// POST request with authentication
final result = await HttpUtil.post(
  '/api/protected-data',
  data: {'key': 'value'},
  requireAuth: true,
);

// PUT request with additional headers
final result = await HttpUtil.put(
  '/api/update',
  data: {'id': 1, 'name': 'Updated Name'},
  requireAuth: true,
  additionalHeaders: {'X-Custom-Header': 'value'},
);

// DELETE request
final result = await HttpUtil.delete(
  '/api/delete/1',
  requireAuth: true,
);
```

### Error Handling

The HttpUtil automatically maps HTTP errors to specific failure types:
- `NetworkFailure` - Connection timeout, network errors
- `ValidationFailure` - 400, 422 status codes
- `AuthFailure` - 401, 403 status codes
- `NotFoundFailure` - 404 status code
- `ServerFailure` - 500+ status codes