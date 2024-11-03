import 'package:bpjs_customer/providers/reserve_provider.dart';
import 'package:bpjs_customer/shared/theme.dart';
import 'package:bpjs_customer/ui/pages/facility_page.dart';
import 'package:bpjs_customer/ui/pages/location_page.dart';
import 'package:bpjs_customer/ui/pages/poli_page.dart';
import 'package:bpjs_customer/ui/pages/reserved_page.dart';
import 'package:bpjs_customer/ui/pages/splash_page.dart';
import 'package:bpjs_customer/ui/pages/summary_page.dart';
import 'package:bpjs_customer/ui/pages/time_page.dart';
import 'package:bpjs_customer/ui/pages/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/location_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['YOUR_SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['YOUR_SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ReserveProvider()),
        ChangeNotifierProvider(
          create: (_) => LocationNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: blueColor),
          useMaterial3: true,
        ),
        routes: {
          '/': (context) => const SplashPage(),
          '/facility': (context) => const FacilityPage(),
          '/location': (context) => const LocationPage(),
          '/poli': (context) => const PoliPage(),
          '/time': (context) => const TimePage(),
          '/summary': (context) => const SummaryPage(),
          '/reserved': (context) => const ReservedPage(),
          '/tracking': (context) => const TrackingPage(),
        },
      ),
    );
  }
}
