import 'package:bloc/bloc.dart';
import 'package:my_flutter_test_app1/data/model/cubicData.dart';
import 'package:my_flutter_test_app1/domain/usecases/cubic_list_usecase.dart';
import '../../../locator.dart';
import 'cubic_event.dart';
import 'cubic_state.dart';

class CubicListBloc extends Bloc<CubicListEvent, CubicListState> {
  final CubicListUseCase cubicListUseCase;

  CubicListBloc(): cubicListUseCase = sl(), super(null);

  CubicListState get initialState => CubicListLoadingState();

  @override
  Stream<CubicListState> mapEventToState(CubicListEvent event) async* {
    if (event is ShowCubicListEvent) {
      yield CubicListLoadingState();
      List<CubicData> cubics = await _getExchangesList(event.page);
      yield AllCubicListViewState(
          cubics: cubics, page: event.page);
    }
  }

  Future<List<CubicData>> _getExchangesList(String page) async{
    final cubicsData = await cubicListUseCase.execute(
        CubicListParams(
          page: page,
        )
    );
    return cubicsData.cubics;
  }


}