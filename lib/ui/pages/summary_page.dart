import 'package:bpjs_customer/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/reserve_provider.dart';
import '../../services/reservation_services.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_navigation.dart';
import '../widgets/facility_card.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    final ReserveProvider reserveProvider =
        Provider.of<ReserveProvider>(context);
    final ReservationService reservationService = ReservationService();
    const String nik = '3273105503040004';

    Future<void> createReservation() async {
      try {
        await reservationService.createReservation(
          reservation: reserveProvider.reserve,
          nik: nik,
        );
        navigator.pushNamed('/reserved');
      } catch (e) {
        rethrow;
      }
    }

    Widget card(
        {required IconData icon, required String title, Widget? child}) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: blackColor,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: blackText.copyWith(
                      fontSize: 14,
                      fontWeight: semibold,
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.mode_edit_outlined,
                  color: blueColor,
                ),
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(left: 40, bottom: 12),
              child: child ?? const SizedBox()),
          const Divider(),
        ],
      );
    }

    Widget body() {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              card(
                icon: Icons.account_circle_outlined,
                title: 'Nomor Induk Kependudukan',
                child: Text(
                  nik,
                  style: greyText.copyWith(fontSize: 12),
                ),
              ),
              card(
                icon: Icons.description_outlined,
                title: 'Fasilitas Kesehatan',
                child: reserveProvider.reserve.layanan ==
                        '🏡 Faskes Tingkat Pertama'
                    ? const FacilityCard(
                        title: '🏡 Faskes Tingkat Pertama',
                        description:
                            'Membuat janji pertemuan pada faskes tingkat pertama sebagai tindakan dini penaganan',
                      )
                    : const FacilityCard(
                        title: '🏥 Faskes Rujukan Tingkat Lanjut',
                        description:
                            'Membuat janji dengan faskes rujukan setelah mendapat rujukan pada faskes tingkat pertama',
                      ),
              ),
              card(
                icon: Icons.location_on_outlined,
                title: 'Lokasi',
                child: Text(
                  reserveProvider.reserve.rumahSakit,
                  style: greyText.copyWith(fontSize: 12),
                ),
              ),
              card(
                icon: Icons.calendar_today_outlined,
                title: 'Waktu',
                child: Text(
                  reserveProvider.reserve.tanggal == null
                      ? ''
                      : DateFormat('EE, dd MMMM yyyy, HH:mm')
                          .format(reserveProvider.reserve.tanggal!),
                  style: greyText.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: const CustomAppBar(
        title: 'Kesimpulan',
      ),
      body: body(),
      bottomNavigationBar: CustomBottomNavigation(
        text: 'Konfirmasi',
        onPressed: createReservation,
      ),
    );
  }
}
