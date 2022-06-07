import 'package:shared_preferences/shared_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserInitial()) {

    on<UpdateUser>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user', event.updatedName);
      emit(UserUpdated(event.updatedName));
    });

    on<RequestUser>((event, emit) {
      emit(const UserUpdated(null));
    });
  }
}
