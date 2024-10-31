import 'package:equatable/equatable.dart';

class ReserveModel extends Equatable {
  final String layanan;
  final String? provinsi;
  final String? kota;
  final String rumahSakit;
  final String? poli;
  final String dokter;
  final String keluhan;
  final DateTime? tanggal;

  const ReserveModel({
    required this.layanan,
    required this.provinsi,
    required this.kota,
    required this.rumahSakit,
    required this.poli,
    required this.dokter,
    required this.keluhan,
    required this.tanggal,
  });

  ReserveModel copyWith({
    String? layanan,
    String? provinsi,
    String? kota,
    String? rumahSakit,
    String? poli,
    String? dokter,
    String? keluhan,
    DateTime? tanggal,
  }) {
    return ReserveModel(
      layanan: layanan ?? this.layanan,
      provinsi: provinsi ?? this.provinsi,
      kota: kota ?? this.kota,
      rumahSakit: rumahSakit ?? this.rumahSakit,
      poli: poli ?? this.poli,
      dokter: dokter ?? this.dokter,
      keluhan: keluhan ?? this.keluhan,
      tanggal: tanggal ?? this.tanggal,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'layanan': layanan,
      'provinsi': provinsi,
      'kota': kota,
      'rumah_sakit': rumahSakit,
      'poli': poli,
      'dokter': dokter,
      'keluhan': keluhan,
      'tanggal': tanggal?.toIso8601String(), // Mengonversi DateTime ke String
    };
  }

  @override
  List<Object?> get props => [
        layanan,
        provinsi,
        kota,
        rumahSakit,
        poli,
        dokter,
        keluhan,
        tanggal,
      ];
}
