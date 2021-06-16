import 'package:bloc/bloc.dart';
import 'package:my_flutter_test_app1/data/model/stackData.dart';
import 'package:my_flutter_test_app1/domain/usecases/stack_list_usecase.dart';
import '../../../locator.dart';
import 'stack_event.dart';
import 'stack_state.dart';

class StackListBloc extends Bloc<StackListEvent, StackListState> {
  final StackListUseCase stackListUseCase;

  StackListBloc(): stackListUseCase = sl(), super(null);

  StackListState get initialState => StackListLoadingState();

  @override
  Stream<StackListState> mapEventToState(StackListEvent event) async* {
    if (event is ShowStackListEvent) {
      yield StackListLoadingState();
      List<StackData> stacks = await _getExchangesList(event.page);
      yield AllStackListViewState(
          stacks: stacks, page: event.page);
    }
  }

  Future<List<StackData>> _getExchangesList(String page) async{
    final stacksData = await stackListUseCase.execute(
        StackListParams(
          page: page,
        )
    );
    return stacksData.stacks;
  }


}