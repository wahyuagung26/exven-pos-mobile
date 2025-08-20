import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// Application name
  ///
  /// In en, this message translates to:
  /// **'ExVen POS'**
  String get appName;

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'ExVen POS'**
  String get appTitle;

  /// Application version display
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String appVersion(String version);

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Error message title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Success message title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Yes button text
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No button text
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Next button text
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Previous button text
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// Done button text
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Logout button text
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Register button text
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// Remember me checkbox label
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// Invalid email error message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// Invalid password error message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get invalidPassword;

  /// Login success message
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccess;

  /// Login failed error message
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials'**
  String get loginFailed;

  /// Dashboard section title
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// Products section title
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// Customers section title
  ///
  /// In en, this message translates to:
  /// **'Customers'**
  String get customers;

  /// Transactions section title
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// Reports section title
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reports;

  /// Settings section title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Profile section title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Home navigation text
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Back navigation text
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Menu navigation text
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// Required field validation message
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get requiredField;

  /// Invalid format validation message
  ///
  /// In en, this message translates to:
  /// **'Invalid format'**
  String get invalidFormat;

  /// Field too short validation message
  ///
  /// In en, this message translates to:
  /// **'Field is too short'**
  String get fieldTooShort;

  /// Field too long validation message
  ///
  /// In en, this message translates to:
  /// **'Field is too long'**
  String get fieldTooLong;

  /// Password requirements message
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 characters, including uppercase, lowercase, and numbers'**
  String get passwordRequirements;

  /// Form saved success message
  ///
  /// In en, this message translates to:
  /// **'Form saved successfully'**
  String get formSaved;

  /// Form error message
  ///
  /// In en, this message translates to:
  /// **'Error saving form. Please try again'**
  String get formError;

  /// Product name field label
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// Product code field label
  ///
  /// In en, this message translates to:
  /// **'Product Code'**
  String get productCode;

  /// Price field label
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// Category field label
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Stock field label
  ///
  /// In en, this message translates to:
  /// **'Stock'**
  String get stock;

  /// Description field label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Add product button text
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// Edit product button text
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// Delete product button text
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProduct;

  /// Product saved success message
  ///
  /// In en, this message translates to:
  /// **'Product saved successfully'**
  String get productSaved;

  /// Product deleted success message
  ///
  /// In en, this message translates to:
  /// **'Product deleted successfully'**
  String get productDeleted;

  /// Customer label
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// Transaction label
  ///
  /// In en, this message translates to:
  /// **'Transaction'**
  String get transaction;

  /// Payment label
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// Discount label
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// Tax label
  ///
  /// In en, this message translates to:
  /// **'Tax'**
  String get tax;

  /// Total label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Subtotal label
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// Cash payment method
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// Card payment method
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// Transfer payment method
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection'**
  String get networkError;

  /// Server error message
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later'**
  String get serverError;

  /// Unauthorized access error message
  ///
  /// In en, this message translates to:
  /// **'Unauthorized access'**
  String get unauthorizedAccess;

  /// Forbidden access error message
  ///
  /// In en, this message translates to:
  /// **'Access forbidden'**
  String get forbidden;

  /// Not found error message
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get notFound;

  /// Validation error message
  ///
  /// In en, this message translates to:
  /// **'Validation error. Please check your input'**
  String get validationError;

  /// Analytics section title
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get analytics;

  /// Sales report title
  ///
  /// In en, this message translates to:
  /// **'Sales Report'**
  String get salesReport;

  /// Inventory section title
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get inventory;

  /// Cashier label
  ///
  /// In en, this message translates to:
  /// **'Cashier'**
  String get cashier;

  /// Manager label
  ///
  /// In en, this message translates to:
  /// **'Manager'**
  String get manager;

  /// Owner label
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get owner;

  /// Outlet label
  ///
  /// In en, this message translates to:
  /// **'Outlet'**
  String get outlet;

  /// Tenant label
  ///
  /// In en, this message translates to:
  /// **'Tenant'**
  String get tenant;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Theme setting label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Currency setting label
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// Date format setting label
  ///
  /// In en, this message translates to:
  /// **'Date Format'**
  String get dateFormat;

  /// Time format setting label
  ///
  /// In en, this message translates to:
  /// **'Time Format'**
  String get timeFormat;

  /// Search placeholder text
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Filter button text
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// Sort button text
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// Refresh button text
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No data found message
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get noDataFound;

  /// Empty list message
  ///
  /// In en, this message translates to:
  /// **'List is empty'**
  String get emptyList;

  /// Pull to refresh instruction
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh'**
  String get pullToRefresh;

  /// Release to refresh instruction
  ///
  /// In en, this message translates to:
  /// **'Release to refresh'**
  String get releaseToRefresh;

  /// Refreshing indicator text
  ///
  /// In en, this message translates to:
  /// **'Refreshing...'**
  String get refreshing;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
