import 'package:hersafar/screens/selection_screen.dart';
import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(HerSafarApp());
}

class HerSafarApp extends StatelessWidget {
  const HerSafarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HerSafar',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/selection': (context) => SelectionScreen(),
        

    //    '/login': (context) => LoginScreen(),
    //    '/otp': (context) => OTPVerificationScreen(),
     //   '/otp': (context) => OTPVerificationScreen(),
     //   '/facialRecognition': (context) => FacialRecognitionScreen(),
     //   '/home': (context) => HomeScreen(),
     //   '/rideBooking': (context) => RiderBookingScreen(),
     //   '/rideDetails': (context) => RideDetailsScreen(),
     //   '/payment': (context) => PaymentScreen(),
     //   '/profile': (context) => ProfileScreen(),
     //   '/history': (context) => RideHistoryScreen(),
     //   '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
