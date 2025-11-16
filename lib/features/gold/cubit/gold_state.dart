// lib/features/gold/presentation/cubit/gold_state.dart
import '../data/gold_model.dart';

abstract class GoldState {}

class GoldInitial extends GoldState {}

class GoldLoading extends GoldState {}

class GoldLoaded extends GoldState {
  final List<GoldItem> items;

  GoldLoaded(this.items);
}

class GoldError extends GoldState {
  final String message;

  GoldError(this.message);
}
