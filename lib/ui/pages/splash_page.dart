// Import Packages
import 'dart:async';
import 'package:bpjs_customer/providers/location_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Import Styles
import '../../shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // Init state to fetch the application data when start the apps
  getInit() async {
    Timer(const Duration(seconds: 3), () async {
      // Init final context
      final navigator = Navigator.of(context);

      final LocationNotifier locationNotifier =
          Provider.of<LocationNotifier>(context, listen: false);
      await locationNotifier.init();

      navigator.pushNamedAndRemoveUntil('/facility', (route) => false);
    });
  }

  @override
  void initState() {
    getInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png', width: 200),
                const SizedBox(height: 12),
                Text(
                  'an innovative solution for a better\nhealthcare in Indonesia',
                  style: greyText.copyWith(
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  'by SiKAT 🤓',
                  style: greyText.copyWith(
                    fontSize: 14,
                    fontWeight: bold,
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ],
      ),
    );
  }
}
