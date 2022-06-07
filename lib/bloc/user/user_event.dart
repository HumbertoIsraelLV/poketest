part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UpdateUser extends UserEvent {
  final String updatedName;
  UpdateUser(this.updatedName);
}

class RequestUser extends UserEvent {
  RequestUser();
}