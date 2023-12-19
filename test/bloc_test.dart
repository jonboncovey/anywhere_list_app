import 'package:anywhere_list_app/bloc/SimpsonsBloc.dart';
import 'package:anywhere_list_app/repository/SimpsonsRepository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mockito/mockito.dart';

class MockSimpsonsRepository extends Mock implements SimpsonsRepository {}

void main() {
  SimpsonsBloc simpsonsBloc;
  MockSimpsonsRepository simpsonsRepository;

  setup(() {
    simpsonsRepository = MockSimpsonsRepository();
    simpsonsBloc = SimpsonsBloc(simpsonsRepository: simpsonsRepository);
  })
}