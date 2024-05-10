
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/weather_period.dart';
import '../component/weather_period_component.dart';
import '../component/page_indicator.dart';
import '../service/weather_service.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<StatefulWidget> createState() => _WeatherViewState();

}

class _WeatherViewState extends State<WeatherView> with TickerProviderStateMixin {

  final PageController _pageController = PageController();
  late TabController _tabController;
  late Future<void> _load;
  List<WeatherPeriod> _periods = [];
  int _currentPageIndex = 0;

  Future<void> _doLoad() async {
    _periods = await WeatherService.weatherPeriods();
    _tabController = TabController(length: _periods.length, vsync: this);
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isOnDesktopAndWeb {
    if (kIsWeb) {
      return true;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return true;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        return false;
    }
  }

  void _onPageViewChange(int currentPageIndex) {
    if (!_isOnDesktopAndWeb) {
      return;
    }
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  @override
  void initState() {
    _load = _doLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Indianapolis Weather", style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder(
        future: _load,
        builder: (context, snapshot) {
          if (snapshot.connectionState==ConnectionState.done) {
            return content();
          }
          return const CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 5,
          );
        },
      )
    );
  }

  Widget content() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(16),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageViewChange,
            children: _periods.map<WeatherPeriodComponent>((WeatherPeriod period) => WeatherPeriodComponent(weatherPeriod: period)).toList(),
          ),
          PageIndicator(
            tabController: _tabController,
            currentPageIndex: _currentPageIndex,
            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
            isOnDesktopAndWeb: _isOnDesktopAndWeb,
          ),
        ],
      ), 
    );
  }
  
}