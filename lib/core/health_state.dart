import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<Set<String>> {
  FavoritesCubit() : super(<String>{'emma'});

  void toggle(String doctorId) {
    final next = Set<String>.from(state);
    next.contains(doctorId) ? next.remove(doctorId) : next.add(doctorId);
    emit(next);
  }
}

class BookingState extends Equatable {
  const BookingState({
    this.date = '12',
    this.time = '10:30 AM',
    this.paymentMethod = 'Card',
  });

  final String date;
  final String time;
  final String paymentMethod;

  BookingState copyWith({
    String? date,
    String? time,
    String? paymentMethod,
  }) {
    return BookingState(
      date: date ?? this.date,
      time: time ?? this.time,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [date, time, paymentMethod];
}

class BookingCubit extends Cubit<BookingState> {
  BookingCubit() : super(const BookingState());

  void selectDate(String date) => emit(state.copyWith(date: date));
  void selectTime(String time) => emit(state.copyWith(time: time));
  void selectPayment(String method) =>
      emit(state.copyWith(paymentMethod: method));
}
