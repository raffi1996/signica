import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:signica/core/base/bloc_state_status.dart';
import 'package:signica/core/exceptions/result.dart';
import 'package:signica/features/main/domain/entities/document.dart';
import 'package:signica/features/main/domain/interactors/main_interactor.dart';
import 'package:signica/features/main/presentation/bloc/main_bloc.dart';

class _MockMainInteractor extends Mock implements MainInteractor {}

void main() {
  late _MockMainInteractor interactor;

  setUp(() {
    interactor = _MockMainInteractor();
    when(interactor.watchDocuments).thenAnswer((_) => const Stream.empty());
  });

  group('MainBloc', () {
    blocTest<MainBloc, MainState>(
      'emits [loading, success] when initial data loads',
      setUp: () {
        when(interactor.getDocuments).thenAnswer(
          (_) async => Result.success(const <Document>[]),
        );
      },
      build: () => MainBloc(interactor),
      expect: () => const [
        MainState(status: BlocStateStatus.loading),
        MainState(status: BlocStateStatus.success),
      ],
    );

    blocTest<MainBloc, MainState>(
      'emits [loading, error] when initial data fails',
      setUp: () {
        when(interactor.getDocuments).thenAnswer(
          (_) async => Result.errorString('failure'),
        );
      },
      build: () => MainBloc(interactor),
      expect: () => [
        const MainState(status: BlocStateStatus.loading),
        isA<MainState>().having(
          (s) => s.status,
          'status',
          BlocStateStatus.error,
        ),
      ],
    );

    blocTest<MainBloc, MainState>(
      'delete documents toggles processing flag',
      setUp: () {
        when(interactor.getDocuments).thenAnswer(
          (_) async => Result.success(const <Document>[]),
        );
        when(() => interactor.deleteDocuments(any())).thenAnswer(
          (_) async => Result.successVoid(),
        );
      },
      build: () => MainBloc(interactor),
      act: (bloc) => bloc.add(const MainDeleteDocumentsEvent(['a', 'b'])),
      expect: () => const [
        MainState(status: BlocStateStatus.loading),
        MainState(status: BlocStateStatus.success),
        MainState(status: BlocStateStatus.success, isProcessing: true),
        MainState(status: BlocStateStatus.success),
      ],
      verify: (_) {
        verify(() => interactor.deleteDocuments(['a', 'b'])).called(1);
      },
    );
  });
}
