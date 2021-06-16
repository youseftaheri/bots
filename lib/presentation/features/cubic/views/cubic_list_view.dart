import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_flutter_test_app1/utils/animations/AnimatedBackground.dart';
import '../../../../config/theme.dart';
import '../../../../utils/constants/strings.dart';
import '../cubic_bloc.dart';
import '../cubic_state.dart';
import 'cubicChart.dart';

class CubicListView extends StatefulWidget {
  const CubicListView({Key key}) : super(key: key);

  @override
  _CubicListViewState createState() => _CubicListViewState();
}

class _CubicListViewState extends State<CubicListView>  with TickerProviderStateMixin {

  final _listItems = <Widget>[];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadItems(List<Widget> cubics) {
    // fetching data from web api, db...
    final fetchedList = cubics;
    var future = Future(() {});
    for (var i = 0; i < fetchedList.length; i++) {
      future = future.then((_) {
        return Future.delayed(Duration(milliseconds: 100), () {
//          Future.delayed(Duration(milliseconds: 1500));
          _listItems.add(fetchedList[i]);
          _listKey.currentState.insertItem(_listItems.length - 1, duration: Duration(milliseconds: 300));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var widgetWidth = width - AppSizes.sidePadding * 4;
    var _theme = Theme.of(context);
    return BlocListener<CubicListBloc, CubicListState>(
        listener: (context, state) {
          if (state is CubicListErrorState) {
            return Container(
                padding: EdgeInsets.all(AppSizes.sidePadding),
                child: Text(Strings.an_error_occurred,
                    style: _theme.textTheme.headline4
                        .copyWith(color: _theme.errorColor)));
          }
          return Container();
        },
        child:
        BlocBuilder<CubicListBloc, CubicListState>(builder: (context, state) {
          if (state is AllCubicListViewState) {
            return
              Scaffold(
                  body: Stack(children: <Widget>[
                    AnimatedBackground(),
                    state.cubics == null
                        ?
                    // CubicChartScreen()
                    Align(
                        alignment: Alignment.center,
                        child:
                        Padding(
                          padding: EdgeInsets.only(top: 100),
                          child:
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Text(
                              Strings.empty_cubic, textAlign: TextAlign.center,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: AppColors.colorPrimary, fontSize: 18),
                            ),
                          ),
                        )
                    )
                        :
                    state.cubics.isEmpty
                        ?
                    Align(
                        alignment: Alignment.center,
                        child:
                        Padding(
                          padding: EdgeInsets.only(top: 100),
                          child:
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Text(
                              Strings.empty_cubic, textAlign: TextAlign.center,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: AppColors.red, fontSize: 18),
                            ),
                          ),
                        )
                    )
                        :
                    Padding(
                      padding: EdgeInsets.only(top: 60, bottom: 0),
                    child: CubicChartScreen(cubicList: state.cubics),
                    ),

                    Stack(children: <Widget>[
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              Strings.cubicListTitle
                              , textAlign: TextAlign.center, style: TextStyle(fontSize: 19,
                                fontFamily: 'Iransans', fontWeight: FontWeight.bold,
                                color: AppColors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                    ),
                  ],
                  )
              );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}