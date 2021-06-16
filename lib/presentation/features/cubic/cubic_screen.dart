import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_test_app1/presentation/features/cubic/views/cubic_list_view.dart';
import 'package:my_flutter_test_app1/utils/constants/strings.dart';
import '../../widgets/independent/loading_view.dart';
import '../wrapper.dart';
import 'cubic_bloc.dart';
import 'cubic_event.dart';
import 'cubic_state.dart';

class CubicListScreen extends StatefulWidget {
  final CubicListParameters parameters;

  const CubicListScreen({Key key, this.parameters}) : super(key: key);

  @override
  _CubicListScreenState createState() => _CubicListScreenState();
}

class CubicListParameters {
  final String page;

  const CubicListParameters(this.page);
}

class _CubicListScreenState extends State<CubicListScreen> {
  @override
  Widget build(BuildContext context) {
    print('widget parameters at cubic list screen ${widget.parameters}');
    return SafeArea(
        child: BlocProvider<CubicListBloc>(
            create: (context) {
              return CubicListBloc()
                ..add(widget.parameters == null
                    ?
                ShowCubicListEvent(Strings.limit)
                    :
                ShowCubicListEvent(widget.parameters.page));
            },
            child:
            CubicListWrapper()
        ));
  }
}

class CubicListWrapper extends StatefulWidget {
  @override
  _CubicListWrapperState createState() => _CubicListWrapperState();
}

class _CubicListWrapperState extends MyWrapperState<CubicListWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CubicListBloc, CubicListState>(
        child: getPageView(<Widget>[
          LoadingView(),
          buildListScreen(context),
        ]),
        listener: (BuildContext context, CubicListState state) {
          final index = state is CubicListLoadingState ? 0 : 1;
          changePage(changeType: ViewChangeType.Exact, index: index);
        });
  }

  Widget buildListScreen(BuildContext context) {
    return CubicListView();
  }
}
