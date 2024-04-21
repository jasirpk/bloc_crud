import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_crud/model/user_model.dart';
import 'package:meta/meta.dart';

part 'logic_event.dart';
part 'logic_state.dart';

class LogicBloc extends Bloc<LogicEvent, LogicState> {
  LogicBloc() : super(LogicInitial(users: [])) {
    on<AddUser>(_addUser);
    on<DelteUser>(_deleteUser);
    on<UpdateUser>(_updateUser);
  }

  FutureOr<void> _addUser(AddUser event, Emitter<LogicState> emit) {
    state.users.add(event.user);
    emit(LogicUpdated(users: state.users));
  }

  FutureOr<void> _deleteUser(DelteUser event, Emitter<LogicState> emit) {
    state.users.remove(event.user);
    emit(LogicUpdated(users: state.users));
  }

  FutureOr<void> _updateUser(UpdateUser event, Emitter<LogicState> emit) {
    for (int i = 0; i < state.users.length; i++) {
      if (event.user.id == state.users[i].id) {
        state.users[i] = event.user;
      }
    }
    emit(LogicUpdated(users: state.users));
  }
}
