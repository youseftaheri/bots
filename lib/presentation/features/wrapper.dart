import 'package:flutter/material.dart';

enum ViewChangeType { Start, Forward, Backward, Exact }

class MyWrapperState<T> extends State {
  PageController _viewController;

  PageView getPageView(List<Widget> widgets) {
    return PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _viewController,
        children: widgets);
  }

  void changePage({@required ViewChangeType changeType, int index}) {
    switch (changeType) {
      case ViewChangeType.Forward:
        _viewController.nextPage(
            duration: Duration(milliseconds: 3000), curve: Curves.ease);
        break;
      case ViewChangeType.Backward:
        _viewController.previousPage(
            duration: Duration(milliseconds: 3000), curve: Curves.ease);
        break;
      case ViewChangeType.Start:
        _viewController.jumpToPage(0);
        break;
      case ViewChangeType.Exact:
        _viewController.jumpToPage(index);
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _viewController = PageController();
  }

  @override
  void dispose() {
    _viewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    throw Exception('Build method should be implemented in child class');
  }
}
