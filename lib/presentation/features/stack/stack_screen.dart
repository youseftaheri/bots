import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_test_app1/presentation/features/stack/views/stack_list_view.dart';
import 'package:my_flutter_test_app1/utils/constants/strings.dart';
import '../../widgets/independent/loading_view.dart';
import '../wrapper.dart';
import 'stack_bloc.dart';
import 'stack_event.dart';
import 'stack_state.dart';

class StackListScreen extends StatefulWidget {
  final StackListParameters parameters;

  const StackListScreen({Key key, this.parameters}) : super(key: key);

  @override
  _StackListScreenState createState() => _StackListScreenState();
}

class StackListParameters {
  final String page;

  const StackListParameters(this.page);
}

class _StackListScreenState extends State<StackListScreen> {
  @override
  Widget build(BuildContext context) {
    print('widget parameters at stack list screen ${widget.parameters}');
    return SafeArea(
        child: BlocProvider<StackListBloc>(
            create: (context) {
              return StackListBloc()
                ..add(widget.parameters == null
                    ?
                ShowStackListEvent(Strings.limit)
                    :
                ShowStackListEvent(widget.parameters.page));
            },
            child:
            StackListWrapper()
        ));
  }
}

class StackListWrapper extends StatefulWidget {
  @override
  _StackListWrapperState createState() => _StackListWrapperState();
}

class _StackListWrapperState extends MyWrapperState<StackListWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<StackListBloc, StackListState>(
        child: getPageView(<Widget>[
          LoadingView(),
          buildListScreen(context),
        ]),
        listener: (BuildContext context, StackListState state) {
          final index = state is StackListLoadingState ? 0 : 1;
          changePage(changeType: ViewChangeType.Exact, index: index);
        });
  }

  Widget buildListScreen(BuildContext context) {
    return StackListView();
  }
}
