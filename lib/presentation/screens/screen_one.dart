import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/screenone/screenone_bloc.dart';
import '../blocs/toggleTabs/toggle_bloc.dart';
class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toggle Button Design'),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ToggleBloc>(
            create: (context) => ToggleBloc(),
          ),
          BlocProvider<TabToggleBloc>(
            create: (context) => TabToggleBloc(),
          ),
        ],
        child: _ToggleWithTabs(),
      ),
    );
  }
}

class _ToggleWithTabs extends StatefulWidget {
  @override
  State<_ToggleWithTabs> createState() => _ToggleWithTabsState();
}

class _ToggleWithTabsState extends State<_ToggleWithTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleBloc, ToggleState>(
      builder: (context, toggleState) {
        int numTabs = toggleState == ToggleState.OFF ? 3 : 4;

        // Update the TabController's length when the number of tabs changes
        if (_tabController.length != numTabs) {
          _tabController.dispose();
          _tabController = TabController(length: numTabs, vsync: this);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              child: Text(
                toggleState == ToggleState.ON ? 'Show 4 Tabs' : 'Show 3 Tabs',
              ),
              onPressed: () {
                context.read<ToggleBloc>().add(ToggleButtonPressed());
              },
            ),
            Expanded(
              child: BlocProvider.value(
                value: BlocProvider.of<TabToggleBloc>(context),
                child: TabViewWidget(
                  numTabs: numTabs,
                  tabController: _tabController,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}




class TabViewWidget extends StatelessWidget {
  final int numTabs;
  final TabController tabController;

  const TabViewWidget({
    Key? key,
    required this.numTabs,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: tabController,
          tabs: List.generate(
            numTabs,
                (index) => Tab(text: 'Tab ${index + 1}'),
          ),
          onTap: (index) {
            context.read<TabToggleBloc>().add(TabSelected(index));
          },
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: List.generate(
              numTabs,
                  (index) => Center(child: Text('Content of Tab ${index + 1}')),
            ),
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }
}

