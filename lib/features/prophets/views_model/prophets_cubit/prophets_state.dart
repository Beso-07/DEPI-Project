part of 'prophets_cubit.dart';

abstract class ProphetsState extends Equatable {
  const ProphetsState();

  @override
  List<Object?> get props => [];
}

class ProphetsInitial extends ProphetsState {}

class ProphetsLoading extends ProphetsState {}

class ProphetsSuccess extends ProphetsState {
  final List<ProphetsModel> prophets;

  const ProphetsSuccess(this.prophets);

  @override
  List<Object?> get props => [prophets];
}

class ProphetsFailure extends ProphetsState {
  final String error;

  const ProphetsFailure(this.error);

  @override
  List<Object?> get props => [error];
}
