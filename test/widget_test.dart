import 'package:crypto_track/data/repository_implementation/api_repository_impl.dart';
import 'package:crypto_track/data/repository_implementation/auth_repository_impl.dart';
import 'package:crypto_track/data/repository_implementation/db_repository_impl.dart';
import 'package:crypto_track/data/repository_implementation/sorting_repository_impl.dart';
import 'package:crypto_track/domain/use_cases/api_use_cases.dart';
import 'package:crypto_track/domain/use_cases/auth_use_cases.dart';
import 'package:crypto_track/domain/use_cases/firebase_use_cases.dart';
import 'package:crypto_track/domain/use_cases/sort_coins_use_cases.dart';
import 'package:crypto_track/presentation/states/api_bloc/api_bloc.dart';
import 'package:crypto_track/presentation/states/authentication_bloc/authentication_bloc.dart';
import 'package:crypto_track/presentation/states/db_bloc/db_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crypto_track/main.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // Make sure you have the Firebase configuration for testing
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create the repository and use cases
    final authRepository = AuthRepositoryImpl();
    final apiRepository = ApiRepositoryImpl();
    final dbRepository = DbRepositoryImpl();
    final sortRepository = SortingRepositoryImpl();
    final SortCoinsByRank sortCoinsByRank = SortCoinsByRank(repository: sortRepository);
    final sortCoinsByAmount = SortCoinsByAmount(repository: sortRepository);
    final addCoinToPortfolio = AddCoinToPortfolio(repository: dbRepository);
    final fetchPortfolioData = FetchPortfolioData(repository: dbRepository);
    final fetchMarketApi = FetchMarketData(repository: apiRepository);
    final fetchApi = FetchAllCoins(repository: apiRepository);
    final logIn = LogInUseCase(repository: authRepository);
    final signUp = SignUpUseCase(repository: authRepository);
    final logOut = LogOutUseCase(repository: authRepository);
    final DeleteCoinFromPortfolio deleteCoinFromPortfolio = DeleteCoinFromPortfolio(repository: dbRepository);
    final getCurrentUser = GetCurrentUserUseCase(repository: authRepository);
    final dbBloc = DbBloc(addCoinToPortfolio, getCurrentUser, fetchPortfolioData, deleteCoinFromPortfolio, sortCoinsByAmount: sortCoinsByAmount);
    final SortCoinsByPrice sortCoinsByPrice = SortCoinsByPrice(ropository: sortRepository);

    // Create the authentication bloc
    final authenticationBloc = AuthenticationBloc(
      logIn, 
      signUp, 
      logOut, 
      getCurrentUser, 
    );
    final apiBloc = ApiBloc(
      fetchApi, 
      fetchMarketApi, 
      sortCoinsByPrice,
      sortCoinsByRank
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(authenticationBloc: authenticationBloc, apiBloc: apiBloc, dbBloc: dbBloc,));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
