import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_test_app1/presentation/features/stack/stack_screen.dart';
import 'package:my_flutter_test_app1/presentation/features/streem/streamScreen.dart';
import 'package:my_flutter_test_app1/utils/alertStyle.dart';
import 'package:my_flutter_test_app1/utils/show_custom_alert_popup.dart';
import '../../config/routes.dart';
import '../../config/theme.dart';
import '../../utils/constants/strings.dart';
import 'candelstick/candlestick_screen.dart';
import 'cubic/cubic_screen.dart';

class MainScreen extends StatefulWidget {
  final int index;

  const MainScreen({Key key, this.index = 0}) : super(key: key);
  @override
  MainScreenState createState() => new MainScreenState();
}

class MainScreenState extends State<MainScreen>{

  int _currentIndex = 0;
  PageController _pageController;
  int currentIndex = 0;
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.index);
    _currentIndex = widget.index;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (
        showCustomAlertPopup(context: context,
          type: 'fail',
          style: alertStyle(),
          title: '',
          message: 'Are you sure you want to EXIT?',
          button1: 'Yes',
          onTap1:() {
            SystemNavigator.pop();
          },
          button2: 'No',
          onTap2: () {
            Navigator.of(context).pop(false);
          },)
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    // setState(() => _currentIndex = widget.index);
    return
      WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
        body: SizedBox.expand(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: <Widget>[
              Container(child: CandlestickListScreen(parameters:CandlestickListParameters(Strings.limit))),
              Container(child: CubicListScreen(parameters:CubicListParameters(Strings.limit))),
              Container(child: StackListScreen(parameters:StackListParameters(Strings.limit))),
              Container(child: StreamScreen(),),
            ],
          ),
        ),

        bottomNavigationBar:
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15), topLeft: Radius.circular(15)
            ),
            boxShadow: [
              BoxShadow(color: Theme.of(context).shadowColor == AppColors.colorPrimaryBackDark ?
              Colors.white : Colors.black38 ,
                  spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child:
          BottomNavyBar(
            selectedIndex: _currentIndex,
            showElevation: true,
            animationDuration: Duration(milliseconds: 500),
            backgroundColor: _theme.scaffoldBackgroundColor,
//        curve: Curves.easeInBack,
            onItemSelected: (index) => setState(() {
              _currentIndex = index;
              _pageController.animateToPage(index,
                  duration: Duration(milliseconds:500), curve: Curves.ease);
              setState(() => _currentIndex = index);

            }),

            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                title: Text(Strings.candlestick, style: TextStyle(fontSize: 14, fontFamily: 'Iransans', color: AppColors.colorPrimary)),
                icon: Icon(Icons.waterfall_chart),
                activeColor: AppColors.colorPrimary,
              ),
              BottomNavyBarItem(
                title: Text(Strings.cubic, style: TextStyle(fontSize: 14, fontFamily: 'Iransans', color: AppColors.colorPrimary)),
                icon: Icon(Icons.multiline_chart_outlined),
                activeColor: AppColors.colorPrimary,
              ),
              BottomNavyBarItem(
                  title: Text(Strings.stack, style: TextStyle(fontSize: 14, fontFamily: 'Iransans', color: AppColors.colorPrimary)),
                  icon: Icon(Icons.bar_chart),
                  activeColor: AppColors.colorPrimary
              ),
              BottomNavyBarItem(
                  title: Text(Strings.stream, style: TextStyle(fontSize: 14, fontFamily: 'Iransans', color: AppColors.colorPrimary)),
                  icon: Icon(Icons.stream),
                  activeColor: AppColors.colorPrimary
              ),
            ],

          ),
        )
    )
      );
  }
}