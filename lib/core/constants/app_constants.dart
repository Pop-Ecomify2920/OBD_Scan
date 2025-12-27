class AppConstants {
  // App Info
  static const String appName = 'OBD Scan';
  static const String appVersion = '1.0.0';
  
  // API Constants
  static const String baseUrl = 'https://api.example.com'; // TODO: Update with actual API
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000;
  
  // Storage Keys
  static const String tokenKey = 'auth_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userIdKey = 'user_id';
  static const String userEmailKey = 'user_email';
  static const String rememberMeKey = 'remember_me';
  static const String selectedCarKey = 'selected_car';
  static const String creditBalanceKey = 'credit_balance';
  
  // OBD/ELM327 Constants
  static const String elm327DefaultBaudRate = '38400';
  static const int elm327Timeout = 2000; // milliseconds
  static const String elm327LineEnding = '\r';
  
  // OBD-II PIDs
  static const String mode01 = '01'; // Show current data
  static const String mode03 = '03'; // Show stored DTCs
  static const String mode04 = '04'; // Clear DTCs
  static const String mode09 = '09'; // Read vehicle info (VIN)
  
  // VIN PID
  static const String vinPid = '02'; // Mode 09, PID 02 for VIN
  
  // Validation
  static const int minPasswordLength = 8;
  static const int otpLength = 4;
  
  // Pagination
  static const int defaultPageSize = 20;
}

