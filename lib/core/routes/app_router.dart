import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/otp_verification_screen.dart';
import '../../features/auth/presentation/screens/password_screen.dart';
import '../../features/auth/presentation/screens/recover_account_screen.dart';
import '../../features/auth/presentation/screens/verification_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/home/presentation/screens/home_dashboard_screen.dart';
import '../../features/home/presentation/screens/bluetooth_connect_screen.dart';
import '../../features/home/presentation/screens/climate_control_screen.dart';
// import '../../features/home/presentation/screens/vehicle_status_screen.dart';
import '../../features/home/presentation/screens/safety_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/home/presentation/screens/car_selection_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String otpVerification = '/otp-verification';
  static const String password = '/password';
  static const String recoverAccount = '/recover-account';
  static const String verification = '/verification';
  static const String home = '/home';
  static const String homeDashboard = '/home-dashboard';
  static const String bluetoothConnect = '/bluetooth-connect';
  static const String climateControl = '/climate-control';
  static const String vehicleStatus = '/vehicle-status';
  static const String safety = '/safety';
  static const String settings = '/settings';
  static const String carSelection = '/car-selection';
  
  static GoRouter get router => _router;
  
  static final GoRouter _router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: otpVerification,
        name: 'otp-verification',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final isRegistration = state.uri.queryParameters['isRegistration'] == 'true';
          return OTPVerificationScreen(
            email: email,
            isRegistration: isRegistration,
          );
        },
      ),
      GoRoute(
        path: password,
        name: 'password',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'] ?? '';
          final isRegistration = state.uri.queryParameters['isRegistration'] == 'true';
          return PasswordScreen(
            email: email,
            isRegistration: isRegistration,
          );
        },
      ),
      GoRoute(
        path: recoverAccount,
        name: 'recover-account',
        builder: (context, state) => const RecoverAccountScreen(),
      ),
      GoRoute(
        path: verification,
        name: 'verification',
        builder: (context, state) => const VerificationScreen(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: homeDashboard,
        name: 'home-dashboard',
        builder: (context, state) => const HomeDashboardScreen(),
      ),
      GoRoute(
        path: bluetoothConnect,
        name: 'bluetooth-connect',
        builder: (context, state) => const BluetoothConnectScreen(),
      ),
      GoRoute(
        path: climateControl,
        name: 'climate-control',
        builder: (context, state) => const ClimateControlScreen(),
      ),
      // GoRoute(
      //   path: vehicleStatus,
      //   name: 'vehicle-status',
      //   builder: (context, state) => const VehicleStatusScreen(),
      // ),
      GoRoute(
        path: safety,
        name: 'safety',
        builder: (context, state) => const SafetyScreen(),
      ),
      GoRoute(
        path: settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: carSelection,
        name: 'car-selection',
        builder: (context, state) => const CarSelectionScreen(),
      ),
    ],
  );
}

