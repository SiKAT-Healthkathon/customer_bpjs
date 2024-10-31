import 'package:bpjs_customer/dummy/data.dart';
import 'package:bpjs_customer/providers/reserve_provider.dart';
import 'package:bpjs_customer/shared/theme.dart';
import 'package:bpjs_customer/ui/widgets/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReserveProvider reserveProvider =
        Provider.of<ReserveProvider>(context);

    List<String> districtsAvail = districts
        .where((element) =>
            element['province'] == reserveProvider.reserve.provinsi)
        .map((e) => e['city']!)
        .toList();

    List<Map<String, dynamic>> hospitalsAvail = hospitals
        .where((element) => element['city'] == reserveProvider.reserve.kota)
        .toList();

    void launchURL(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
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
                  '📍 Dimana Lokasi Pilihan Anda?',
                  style: blackText.copyWith(fontSize: 24, fontWeight: bold),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 8),
                Text(
                  'Tentukan lokasi kantor cabang terkait untuk melayani kebutuhan anda.',
                  style: greyText.copyWith(fontSize: 12),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                    label: 'Provinsi',
                    hintText: 'Pilih lokasi provinsi',
                    items: provinces,
                    selectedItem: reserveProvider.reserve.provinsi,
                    onChanged: (val) {
                      if (val == null) return;
                      reserveProvider.setKota(null);
                      reserveProvider.setProvinsi(val);
                    }),
                const SizedBox(height: 20),
                CustomDropdown(
                    label: 'Kota/Kab',
                    hintText: 'Pilih lokasi kota/kab',
                    items: districtsAvail,
                    selectedItem:
                        !districtsAvail.contains(reserveProvider.reserve.kota)
                            ? null
                            : reserveProvider.reserve.kota,
                    onChanged: (val) {
                      if (val == null) return;
                      reserveProvider.setKota(val);
                    }),
                const SizedBox(height: 32),
                Visibility(
                  visible: hospitalsAvail.isNotEmpty,
                  child: Text(
                    'Hasil Terkait',
                    style: blackText.copyWith(
                      fontSize: 16,
                      fontWeight: bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: hospitalsAvail.length,
                  itemBuilder: (context, index) {
                    bool isSelected = hospitalsAvail[index]['title'] ==
                        reserveProvider.reserve.rumahSakit;
                    return GestureDetector(
                      onTap: () {
                        reserveProvider
                            .setRumahSakit('${hospitalsAvail[index]['title']}');
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? blueColor : lightBlueColor,
                            width: 1,
                          ),
                          color: isSelected ? lightBlueColor : whiteColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${hospitalsAvail[index]['title']}',
                              style: blackText.copyWith(
                                fontSize: 12,
                                fontWeight: semibold,
                              ),
                            ),
                            Text(
                              '${hospitalsAvail[index]['description']}, ${hospitalsAvail[index]['city']}, ${hospitalsAvail[index]['province']}',
                              style: greyText.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                final String googleMapsUrl =
                                    'https://www.google.com/maps/search/?api=1&query=${hospitalsAvail[index]['coordinates']['latitude']},${hospitalsAvail[index]['coordinates']['longitude']}';
                                launchURL(googleMapsUrl);
                              },
                              child: Text(
                                'View on Google Maps',
                                style: blueText.copyWith(
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(progress: 2 / 5),
      body: body(),
      bottomNavigationBar: CustomBottomNavigation(
        onPressed: () => Navigator.pushNamed(context, '/poli'),
      ),
    );
  }
}
