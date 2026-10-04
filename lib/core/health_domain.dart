class Specialty {
  const Specialty(this.title, this.symbol);

  final String title;
  final String symbol;
}

class Doctor {
  const Doctor({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.location,
    required this.experience,
    required this.fee,
    required this.initials,
  });

  final String id;
  final String name;
  final String specialty;
  final double rating;
  final String location;
  final String experience;
  final double fee;
  final String initials;
}

class Appointment {
  const Appointment({
    required this.id,
    required this.doctor,
    required this.date,
    required this.time,
    required this.status,
  });

  final String id;
  final Doctor doctor;
  final String date;
  final String time;
  final String status;
}

class Pharmacy {
  const Pharmacy(this.name, this.distance, this.rating);

  final String name;
  final String distance;
  final double rating;
}

abstract interface class HealthDataSource {
  List<Specialty> get specialties;
  List<Doctor> get doctors;
  List<Appointment> get appointments;
  List<Pharmacy> get pharmacies;
}

final class DemoHealthDataSource implements HealthDataSource {
  static const _specialties = <Specialty>[
    Specialty('Cardiology', '♡'),
    Specialty('Dermatology', '✦'),
    Specialty('General', '+'),
    Specialty('Gynecology', '◌'),
    Specialty('Odontology', '◇'),
    Specialty('Oncology', '✣'),
    Specialty('Ophthalmology', '◉'),
    Specialty('Orthopedics', '⌁'),
  ];

  static const _doctors = <Doctor>[
    Doctor(
      id: 'emma',
      name: 'Dr. Emma Wilson',
      specialty: 'Cardiologist',
      rating: 4.9,
      location: 'Central Medical Center',
      experience: '12 years',
      fee: 45,
      initials: 'EW',
    ),
    Doctor(
      id: 'chloe',
      name: 'Dr. Chloe Martin',
      specialty: 'Dermatologist',
      rating: 4.8,
      location: 'Health Point Clinic',
      experience: '9 years',
      fee: 40,
      initials: 'CM',
    ),
    Doctor(
      id: 'benjamin',
      name: 'Dr. Benjamin Lee',
      specialty: 'General Doctor',
      rating: 4.7,
      location: 'Wellness Medical Hub',
      experience: '11 years',
      fee: 35,
      initials: 'BL',
    ),
    Doctor(
      id: 'ava',
      name: 'Dr. Ava Carter',
      specialty: 'Ophthalmologist',
      rating: 4.9,
      location: 'Vision Care Center',
      experience: '10 years',
      fee: 50,
      initials: 'AC',
    ),
  ];

  @override
  List<Appointment> get appointments => [
        Appointment(
          id: 'a1',
          doctor: _doctors[0],
          date: 'Monday, 12 Oct',
          time: '10:30 AM',
          status: 'Upcoming',
        ),
        Appointment(
          id: 'a2',
          doctor: _doctors[1],
          date: 'Friday, 02 Oct',
          time: '04:00 PM',
          status: 'Completed',
        ),
      ];

  @override
  List<Doctor> get doctors => _doctors;

  @override
  List<Pharmacy> get pharmacies => const [
        Pharmacy('Vitality Pharmacy', '0.8 km', 4.8),
        Pharmacy('PureHealth Pharmacy', '1.2 km', 4.7),
        Pharmacy('Stay Health Pharmacy', '1.8 km', 4.6),
      ];

  @override
  List<Specialty> get specialties => _specialties;
}

abstract interface class HealthRepository {
  List<Specialty> get specialties;
  List<Doctor> get doctors;
  List<Appointment> get appointments;
  List<Pharmacy> get pharmacies;
}

final class DemoHealthRepository implements HealthRepository {
  DemoHealthRepository({HealthDataSource? dataSource})
      : _dataSource = dataSource ?? DemoHealthDataSource();

  final HealthDataSource _dataSource;

  @override
  List<Appointment> get appointments => _dataSource.appointments;

  @override
  List<Doctor> get doctors => _dataSource.doctors;

  @override
  List<Pharmacy> get pharmacies => _dataSource.pharmacies;

  @override
  List<Specialty> get specialties => _dataSource.specialties;
}
