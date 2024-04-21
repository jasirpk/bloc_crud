part of 'logic_bloc.dart';

@immutable
sealed class LogicEvent {}

// add user...!

class AddUser extends LogicEvent {
  final User user;

  AddUser({required this.user});
}

// delete user...!

class DelteUser extends LogicEvent {
  final User user;

  DelteUser({required this.user});
}

// Update user...!

class UpdateUser extends LogicEvent {
  final User user;

  UpdateUser({required this.user});
}
