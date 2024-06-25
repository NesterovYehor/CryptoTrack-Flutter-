part of 'db_bloc.dart';

sealed class DbBlocEvent extends Equatable {
  const DbBlocEvent();

  @override
  List<Object> get props => [];
}

class PushDataEvent extends DbBlocEvent{
  final PortfolioCoinModel portfolioCoin;
  const PushDataEvent({required this.portfolioCoin});
}

class FetchPortfolioDataEvent extends DbBlocEvent{}

class SortCoinsByAmountEvent extends DbBlocEvent {}

