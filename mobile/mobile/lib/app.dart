import 'package:flutter/cupertino.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

import 'screens/account_screen.dart';
import 'screens/dns_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lookup_screen.dart';

class IpTestApp extends StatelessWidget {
  const IpTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'IP TEST',
      debugShowCheckedModeBanner: false,
      theme: const CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF0071E3),
        scaffoldBackgroundColor: Color(0xFFF3F7FB),
        barBackgroundColor: CupertinoColors.transparent,
      ),
      home: const AppShell(),
    );
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  static const _titles = ['IP TEST', 'IP 查询', 'DNS 查询', '我的'];
  static const _tabs = [
    GlassTab(icon: Icon(CupertinoIcons.house_fill), label: '首页'),
    GlassTab(icon: Icon(CupertinoIcons.search), label: '查询'),
    GlassTab(icon: Icon(CupertinoIcons.globe), label: 'DNS'),
    GlassTab(icon: Icon(CupertinoIcons.person_crop_circle), label: '我的'),
  ];

  void _go(int index) {
    if (index == _index) {
      return;
    }
    setState(() => _index = index);
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      background: const AuroraBackground(),
      statusBarStyle: GlassStatusBarStyle.auto,
      appBar: GlassAppBar(title: Text(_titles[_index])),
      bottomBar: GlassTabBar.bottom(
        tabs: _tabs,
        selectedIndex: _index,
        onTabSelected: _go,
      ),
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(onNavigate: _go),
          const LookupScreen(),
          const DnsScreen(),
          const AccountScreen(),
        ],
      ),
    );
  }
}

class AuroraBackground extends StatelessWidget {
  const AuroraBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE8FFF4),
            Color(0xFFE8F7FF),
            Color(0xFFF4ECFF),
            Color(0xFFFFF0F6),
          ],
          stops: [0, 0.38, 0.72, 1],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}
