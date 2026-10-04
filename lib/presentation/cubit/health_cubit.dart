import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/appointment.dart';
import '../../domain/entities/doctor.dart';
import '../../domain/entities/pharmacy.dart';
import '../../domain/repositories/health_repository.dart';

class HealthState extends Equatable {
  const HealthState({
    this.loading = true,
    this.doctors = const [],
    this.appointments = const [],
    this.pharmacies = const [],
    this.appointmentStatus = AppointmentStatus.upcoming,
  });

  final bool loading;
  final List<Doctor> doctors;
  final List<Appointment> appointments;
  final List<Pharmacy> pharmacies;
  final AppointmentStatus appointmentStatus;

  HealthState copyWith({
    bool? loading,
    List<Doctor>? doctors,
    List<Appointment>? appointments,
    List<Pharmacy>? pharmacies,
    AppointmentStatus? appointmentStatus,
  }) =>
      HealthState(
        loading: loading ?? this.loading,
        doctors: doctors ?? this.doctors,
        appointments: appointments ?? this.appointments,
        pharmacies: pharmacies ?? this.pharmacies,
        appointmentStatus: appointmentStatus ?? this.appointmentStatus,
      );

  @override
  List<Object?> get props => [loading, doctors, appointments, pharmacies, appointmentStatus];
}

class HealthCubit extends Cubit<HealthState> {
  HealthCubit(this._repository) : super(const HealthState());

  final HealthRepository _repository;

  Future<void> load() async {
    final values = await Future.wait<Object>([
      _repository.getDoctors(),
      _repository.getAppointments(),
      _repository.getPharmacies(),
    ]);
    emit(
      state.copyWith(
        loading: false,
        doctors: values[0] as List<Doctor>,
        appointments: values[1] as List<Appointment>,
        pharmacies: values[2] as List<Pharmacy>,
      ),
    );
  }

  void selectAppointmentStatus(AppointmentStatus status) {
    emit(state.copyWith(appointmentStatus: status));
  }

  void toggleFavorite(String doctorId) {
    emit(
      state.copyWith(
        doctors: state.doctors
            .map((doctor) => doctor.id == doctorId ? doctor.copyWith(favorite: !doctor.favorite) : doctor)
            .toList(growable: false),
      ),
    );
  }
}
