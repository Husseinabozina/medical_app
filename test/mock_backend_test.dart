import 'package:flutter_test/flutter_test.dart';
import 'package:medical_app/core/health_domain.dart';
import 'package:medical_app/data/health_repository_impl.dart';
import 'package:medical_app/data/mock/mock_health_data_source.dart';

void main() {
  late HealthRepository repository;

  setUp(() {
    repository = HealthRepositoryImpl(
      dataSource: MockHealthDataSource(latency: Duration.zero),
    );
  });

  test('mock backend persists favorite mutations', () async {
    expect(repository.favoriteDoctorIds, contains('emma'));

    await repository.toggleFavorite('emma');
    expect(repository.favoriteDoctorIds, isNot(contains('emma')));

    await repository.toggleFavorite('chloe');
    expect(repository.favoriteDoctorIds, contains('chloe'));
  });

  test('mock backend appends sent messages', () async {
    final before = repository.messages.length;

    final message = await repository.sendMessage('Hello doctor');

    expect(repository.messages.length, before + 1);
    expect(message.text, 'Hello doctor');
    expect(message.incoming, isFalse);
  });

  test('mock backend cancels and rebooks appointments', () async {
    await repository.cancelAppointment('a1', 'rescheduling');
    expect(
      repository.appointments.singleWhere((item) => item.id == 'a1').status,
      'Cancelled',
    );

    await repository.rebookAppointment('a1');
    expect(
      repository.appointments.singleWhere((item) => item.id == 'a1').status,
      'Upcoming',
    );
  });

  test('mock backend stores records cards and profile updates', () async {
    await repository.addMedicalRecord(
      const MedicalRecordEntry(
        id: 'r-test',
        title: 'Vitals',
        category: 'Profile',
        summary: 'Demo vitals',
      ),
    );
    expect(
      repository.medicalRecords.any((item) => item.id == 'r-test'),
      isTrue,
    );

    await repository.addPaymentCard(
      const PaymentCard(
        id: 'card-test',
        holder: 'Jane Doe',
        last4: '1111',
        expiry: '12/30',
      ),
    );
    expect(repository.paymentCards.last.last4, '1111');

    await repository.updateProfile(
      const UserProfile(
        name: 'Jane Doe',
        phone: '+100000000',
        email: 'jane@example.com',
        dateOfBirth: '01 / 01 / 2000',
      ),
    );
    expect(repository.profile.name, 'Jane Doe');
  });
}
