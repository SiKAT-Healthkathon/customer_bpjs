// pages/time_page.dart
import 'package:bpjs_customer/providers/reserve_provider.dart';
import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../widgets/calendar.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';

class TimePage extends StatelessWidget {
  const TimePage({super.key});

  @override
  Widget build(BuildContext context) {
    final reserveProvider = Provider.of<ReserveProvider>(context);
    final selectedDate = reserveProvider.reserve.tanggal;

    Widget buildTimeSlots() {
      final List<Map<String, dynamic>> timeSlots = [
        {'hour': 8, 'minute': 0, 'label': '08:00'},
        {'hour': 8, 'minute': 30, 'label': '08:30'},
        {'hour': 9, 'minute': 0, 'label': '09:00'},
        {'hour': 9, 'minute': 30, 'label': '09:30'},
        {'hour': 10, 'minute': 0, 'label': '10:00'},
        {'hour': 10, 'minute': 30, 'label': '10:30'},
        {'hour': 11, 'minute': 0, 'label': '11:00'},
        {'hour': 11, 'minute': 30, 'label': '11:30'},
        {'hour': 14, 'minute': 0, 'label': '14:00'},
        {'hour': 14, 'minute': 30, 'label': '14:30'},
        {'hour': 15, 'minute': 0, 'label': '15:00'},
        {'hour': 15, 'minute': 30, 'label': '15:30'},
        {'hour': 16, 'minute': 0, 'label': '16:00'},
        {'hour': 16, 'minute': 30, 'label': '16:30'},
        {'hour': 17, 'minute': 0, 'label': '17:00'},
        {'hour': 17, 'minute': 30, 'label': '17:30'},
      ];

      return Wrap(
        spacing: 8,
        children: timeSlots.map((slot) {
          final isSelected = selectedDate != null &&
              selectedDate.hour == slot['hour'] &&
              selectedDate.minute == slot['minute'];
          return SizedBox(
            width: 78,
            child: ChoiceChip(
              side: BorderSide(color: isSelected ? lightBlueColor : greyColor),
              label: Text(
                slot['label'],
              ),
              selected: false,
              onSelected: (selected) {
                if (selected) {
                  reserveProvider.setTimeSlot(slot['hour']!, slot['minute']!);
                }
              },
              backgroundColor: isSelected ? lightBlueColor : whiteColor,
            ),
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
                  selected: selectedDate,
                  onSelected: (DateTime date) {
                    final newDate = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      selectedDate?.hour ?? 0,
                      selectedDate?.minute ?? 0,
                    );
                    reserveProvider.setTanggal(newDate);
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedDate != null
                          ? DateFormat('EE, dd MMM yyyy').format(selectedDate)
                          : 'Tanggal belum dipilih',
                      style: blackText.copyWith(fontSize: 16, fontWeight: bold),
                    ),
                    Text(
                      selectedDate != null
                          ? DateFormat('HH:mm').format(selectedDate)
                          : 'Waktu belum dipilih',
                      style: greyText,
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
