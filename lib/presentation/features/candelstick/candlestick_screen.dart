import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_test_app1/presentation/features/candelstick/views/candlestick_list_view.dart';
import 'package:my_flutter_test_app1/utils/constants/strings.dart';
import '../../widgets/independent/loading_view.dart';
import '../wrapper.dart';
import 'candlestick_bloc.dart';
import 'candlestick_event.dart';
import 'candlestick_state.dart';

class CandlestickListScreen extends StatefulWidget {
  final CandlestickListParameters parameters;

  const CandlestickListScreen({Key key, this.parameters}) : super(key: key);

  @override
  _CandlestickListScreenState createState() => _CandlestickListScreenState();
}

class CandlestickListParameters {
  final String page;

  const CandlestickListParameters(this.page);
}

class _CandlestickListScreenState extends State<CandlestickListScreen> {
  @override
  Widget build(BuildContext context) {
    print('widget parameters at candlestick list screen ${widget.parameters}');
    return SafeArea(
        child: BlocProvider<CandlestickListBloc>(
            create: (context) {
              return CandlestickListBloc()
                ..add(widget.parameters == null
                    ?
                ShowCandlestickListEvent(Strings.limit)
                    :
                ShowCandlestickListEvent(widget.parameters.page));
            },
            child:
            CandlestickListWrapper()
        ));
  }
}

class CandlestickListWrapper extends StatefulWidget {
  @override
  _CandlestickListWrapperState createState() => _CandlestickListWrapperState();
}

class _CandlestickListWrapperState extends MyWrapperState<CandlestickListWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CandlestickListBloc, CandlestickListState>(
        child: getPageView(<Widget>[
          LoadingView(),
          buildListScreen(context),
        ]),
        listener: (BuildContext context, CandlestickListState state) {
          final index = state is CandlestickListLoadingState ? 0 : 1;
          changePage(changeType: ViewChangeType.Exact, index: index);
        });
  }

  Widget buildListScreen(BuildContext context) {
    return CandlestickListView();
  }
}
