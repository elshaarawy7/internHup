abstract class GogooleState {}

class GogooleInitial extends GogooleState {}

class GogooleLoading extends GogooleState {}

class GogooleSuccess extends GogooleState {
  GogooleSuccess();
}

class GogooleFailure extends GogooleState {
  final String fuiler;

  GogooleFailure(this.fuiler);
}
