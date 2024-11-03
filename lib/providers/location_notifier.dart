import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/reserve_model.dart';

class LocationNotifier extends ChangeNotifier {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final SupabaseClient supabase = Supabase.instance.client;
  final double targetLatitude = -7.94236147715521;
  final double targetLongitude = 110.31084771403597;
  Timer? _locationTimer;

  Future<void> init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await (flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>())
        ?.requestNotificationsPermission();

    _initializeLocationTracking();
  }

  void _initializeLocationTracking() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    _locationTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      await _updateLocationAndCheckStatus();
    });
  }

  Future<void> _updateLocationAndCheckStatus() async {
    var position = await Geolocator.getCurrentPosition();

    // Hitung jarak dari pasien ke area tunggu
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      targetLatitude,
      targetLongitude,
    );

    // Ambil data reservasi pasien dari Supabase
    final response = await supabase
        .from('reservations')
        .select()
        .eq('status', 'Check In')
        .maybeSingle();

    if (response == null) {
      return;
    }
    final reservation = ReserveModel.fromJson(response);

    // Update status jika pasien meninggalkan area tunggu (jarak lebih dari 2000m)
    if (distanceInMeters > 2000) {
      await supabase
          .from('reservations')
          .update({'status': 'Belum Datang'}).eq('status', 'Check In');
    }

    // Cek waktu layanan dan tampilkan notifikasi jika sudah dekat
    if (reservation.status == 'Check In') {
      DateTime now = DateTime.now();
      DateTime serviceTime = reservation.tanggal ?? DateTime.now();
      int minutesBeforeService = _calculateNotificationTime(distanceInMeters);
      DateTime notificationThreshold =
          serviceTime.subtract(Duration(minutes: minutesBeforeService));

      // Tampilkan notifikasi jika waktu sekarang melewati ambang notifikasi
      if (now.isAfter(notificationThreshold)) {
        await _showNotification();
      }
    }
  }

  int _calculateNotificationTime(double distance) {
    if (distance > 2000) return 30; // 30 menit sebelum layanan untuk jarak jauh
    if (distance > 1000) return 15; // 15 menit untuk jarak sedang
    return 5; // 5 menit jika dekat
  }

  Future<void> _showNotification() async {
    await flutterLocalNotificationsPlugin.show(
      0,
      'Pemberitahuan Layanan',
      'Segera tiba di area tunggu, layanan akan dimulai dalam beberapa menit',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channelDescription',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _locationTimer
        ?.cancel(); // Pastikan untuk membatalkan timer saat notifikasi dibuang
    super.dispose();
  }
}
