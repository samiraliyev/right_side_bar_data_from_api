part of 'post_cubit.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class PostLoading extends PostState {}

final class PostLoaded extends PostState {}

final class PostFailure extends PostState {}

final class PostEmpty extends PostState {}

final class PostError extends PostState {}
