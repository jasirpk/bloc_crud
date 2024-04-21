part of 'logic_bloc.dart';

sealed class LogicState {
  List<User> users;
  LogicState({required this.users});
}

class LogicInitial extends LogicState {
  LogicInitial({required super.users});
}

class LogicUpdated extends LogicState {
  LogicUpdated({required super.users});
}
