// lib/models/wasteplan_model.dart
import 'dart:convert';

class WastePlan {
  final String id;
  final int type; // 1 for pemilahan sampah, 2 for rencana setoran
  final DateTime? startDate; // Nullable, not used for type 2
  final int? frequency; // Nullable, 1 for harian, 2 for mingguan, 3 for bulanan, null for type 2
  final int startingHours; // 1 for 07.00, 2 for 09.00, 3 for 11.00, 4 for 17.00
  final DateTime? planDate; // Only used for type 2 (rencana setoran)

  WastePlan({
    required this.id,
    required this.type,
    this.startDate,
    this.frequency,
    required this.startingHours,
    this.planDate,
  }) {
    // Validation
    if (type == 1 && (startDate == null || frequency == null)) {
      throw ArgumentError('Pemilahan sampah must have start_date and frequency');
    }
    if (type == 2 && planDate == null) {
      throw ArgumentError('Rencana setoran must have plan_date');
    }
  }

  factory WastePlan.fromJson(Map<String, dynamic> json) {
    return WastePlan(
      id: json['id'].toString(),
      type: json['type'],
      startDate: json['type'] == 1 ? DateTime.parse(json['start_date']) : null,
      frequency: json['type'] == 1 ? json['frequency'] : null,
      startingHours: json['starting_hours'],
      planDate: json['type'] == 2 ? DateTime.parse(json['plan_date']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'type': type,
      'starting_hours': startingHours,
    };

    // Add type-specific fields
    if (type == 1) {
      data['start_date'] = startDate!.toIso8601String();
      data['frequency'] = frequency;
    } else if (type == 2) {
      data['plan_date'] = planDate!.toIso8601String();
    }

    return data;
  }

  // Helper methods to get readable values
  String get typeDescription {
    return type == 1 ? 'Pemilahan Sampah' : 'Rencana Setoran';
  }

  String get startingHoursDescription {
    switch (startingHours) {
      case 1: return '07:00';
      case 2: return '09:00';
      case 3: return '11:00';
      case 4: return '17:00';
      default: return 'Tidak Valid';
    }
  }

  String get frequencyDescription {
    if (type != 1) return 'Tidak Berlaku';
    switch (frequency) {
      case 1: return 'Harian';
      case 2: return 'Mingguan';
      case 3: return 'Bulanan';
      default: return 'Tidak Valid';
    }
  }
}