import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';

import '../widgets/calendar.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';

class TimePage extends StatelessWidget {
  const TimePage({super.key});

  Widget buildTimeSlots() {
    final timeSlots = ['08.00', '08.30', '09.00', '09.30'];
    return Wrap(
      spacing: 12,
      alignment: WrapAlignment.center,
      runSpacing: 12,
      children: timeSlots.map((time) {
        return ChoiceChip(
          label: Text(
            time,
            style: blackText.copyWith(fontSize: 14),
          ),
          selected: false,
          onSelected: (selected) {
            // Handle time slot selection
          },
          backgroundColor: Colors.grey.shade200,
          selectedColor: Colors.blue,
          // labelStyle: selected ? whiteText : blackText,
        );
      }).toList(),
    );
  }

  Widget body() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kapan Anda Membutuhkan Layanan? 🗓️',
                style: blackText.copyWith(fontSize: 24, fontWeight: bold),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 8),
              Text(
                'Tentukan waktu untuk mendapatkan layanan kesehatan.',
                style: greyText.copyWith(fontSize: 12),
                textAlign: TextAlign.justify,
              ),
              Calendar(
                selected: DateTime.utc(2024, 10, 13),
                onSelected: (DateTime date) {},
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jumat, 8 Mei 2024',
                    style: blackText.copyWith(fontSize: 16, fontWeight: bold),
                  ),
                  Text(
                    '08.00 - 16.00',
                    style: greyText.copyWith(fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              buildTimeSlots(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(progress: 4 / 5),
      body: body(),
      bottomNavigationBar: CustomBottomNavigation(
        onPressed: () => Navigator.pushNamed(context, '/summary'),
      ),
    );
  }
}
