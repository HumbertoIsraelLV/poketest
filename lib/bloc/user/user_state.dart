part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final String? name;
  final bool wasRequested;

  const UserState({
    this.name,
    this.wasRequested = false,
  });  
}

class UserInitial extends UserState {
  const UserInitial() : super(name: null);
}

class UserUpdated extends UserState {
  final String? updatedName;
  const UserUpdated( this.updatedName ) : super(name: updatedName, wasRequested: true);
}
