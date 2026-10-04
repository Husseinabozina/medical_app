import 'package:equatable/equatable.dart';

enum AppointmentStatus { complete, upcoming, cancelled }

class Appointment extends Equatable {
  const Appointment({
    required this.id,
    required this.doctorId,
    required this.dateLabel,
    required this.timeLabel,
    required this.status,
  });

  final String id;
  final String doctorId;
  final String dateLabel;
  final String timeLabel;
  final AppointmentStatus status;

  @override
  List<Object?> get props => [id, doctorId, dateLabel, timeLabel, status];
}
