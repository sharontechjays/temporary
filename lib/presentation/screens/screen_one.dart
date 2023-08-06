import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter/presentation/utils/styles/custom_colors.dart';
import 'package:test_flutter/presentation/utils/styles/custom_styles.dart';
import '../blocs/screenone/toggle_bloc.dart';
import '../blocs/screenone/toggle_event.dart';
import '../blocs/screenone/toggle_state.dart';
import '../blocs/toggleTabs/toggle_bloc.dart';

class ScreenOne extends StatelessWidget {
  const ScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Toggle Button Design'),
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
        if (_tabController.length != numTabs) {
          _tabController.dispose();
          _tabController = TabController(length: numTabs, vsync: this);
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: AnimatedToggle(
                  values: const ['My Picks', 'Scoreboard'],
                  onToggleCallback: (index) {
                    context.read<ToggleBloc>().add(ToggleButtonPressed(index));
                  },
                ),
              ),
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
          labelStyle: const TextStyle(color: AppColors.Secondary_purple),
          unselectedLabelColor: AppColors.Secondary_purple,
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
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
              numTabs,
              (index) => Center(child: Text('Content of Tab ${index + 1}')),
            ),
          ),
        ),
      ],
    );
  }
}
