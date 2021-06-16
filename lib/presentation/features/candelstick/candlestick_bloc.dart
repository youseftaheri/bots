import 'package:bloc/bloc.dart';
import 'package:my_flutter_test_app1/data/model/candlestickData.dart';
import 'package:my_flutter_test_app1/domain/usecases/candlestick_list_usecase.dart';
import '../../../locator.dart';
import 'candlestick_event.dart';
import 'candlestick_state.dart';

class CandlestickListBloc extends Bloc<CandlestickListEvent, CandlestickListState> {
  final CandlestickListUseCase candlestickListUseCase;

  CandlestickListBloc(): candlestickListUseCase = sl(), super(null);

  CandlestickListState get initialState => CandlestickListLoadingState();

  @override
  Stream<CandlestickListState> mapEventToState(CandlestickListEvent event) async* {
    if (event is ShowCandlestickListEvent) {
      yield CandlestickListLoadingState();
      List<CandlestickData> candlesticks = await _getExchangesList(event.page);
      yield AllCandlestickListViewState(
          candlesticks: candlesticks, page: event.page);
    }
  }

  Future<List<CandlestickData>> _getExchangesList(String page) async{
    final candlesticksData = await candlestickListUseCase.execute(
        CandlestickListParams(
          page: page,
        )
    );
    return candlesticksData.candlesticks;
  }


}