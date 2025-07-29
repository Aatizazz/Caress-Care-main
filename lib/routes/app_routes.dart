import 'package:caress_care/view/screens/auth/agreement_screen.dart';
import 'package:caress_care/view/screens/auth/login_screen.dart';
import 'package:caress_care/view/screens/auth/register_screen.dart';
import 'package:caress_care/view/screens/check_list_screen.dart';
import 'package:caress_care/view/screens/doctor_ref_screen.dart';
import 'package:caress_care/view/screens/mod_sclection_screen.dart'; // ✅ using as Home
import 'package:caress_care/view/screens/motivational_screen.dart';
import 'package:caress_care/view/screens/profile/edit_profile_screen.dart';
import 'package:caress_care/view/screens/profile/profile_screen.dart';
import 'package:caress_care/view/screens/splash_screen.dart';
import 'package:caress_care/view/screens/video_ref_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String mood = '/mood';
  static const String motivation = '/motivation';
  static const String checklistScreen = '/ChecklistScreen';
  static const String videoRefScreen = '/VideoRefScreen';
  static const String doctorRefScreen = '/DoctorRefScreen';
  static const String agreementScreen = '/AgreementScreen';
  static const String editProfileScreen = '/EditProfileScreen';
  static const String profileScreen = '/ProfileScreen';
  static const String home = '/home'; // ✅ Home route uses ModSelectionScreen

  static final routes = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: mood, page: () => const ModSelectionScreen()),
    GetPage(name: motivation, page: () => const MotivationalScreen()),
    GetPage(name: checklistScreen, page: () => const ChecklistScreen()),
    GetPage(name: videoRefScreen, page: () => VideoRefScreen()),
    GetPage(name: doctorRefScreen, page: () => DoctorRefScreen()),
    GetPage(name: agreementScreen, page: () => AgreementScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: profileScreen, page: () => ProfileScreen()),
    GetPage(
      name: home,
      page: () => const ModSelectionScreen(),
    ), // ✅ your home screen
  ];
}
