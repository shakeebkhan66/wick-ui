import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:wick_ui/providers/tab_provider.dart";
import "package:wick_ui/utils/build_main_tab.dart";
import "package:wick_ui/utils/custom_appbar.dart";

class TabletHomeScaffold extends StatefulWidget {
  const TabletHomeScaffold({super.key});

  @override
  State<TabletHomeScaffold> createState() => _TabletHomeScaffoldState();
}

class _TabletHomeScaffoldState extends State<TabletHomeScaffold> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabControllerProvider>(
      builder: (context, tabControllerProvider, child) {
        return Scaffold(
          appBar: CustomAppBar(
            tabController: tabControllerProvider.tabController,
            tabNames: tabControllerProvider.tabNames,
            removeTab: tabControllerProvider.removeTab,
            addTab: tabControllerProvider.addTab,
          ),
          body: tabControllerProvider.tabNames.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: tabControllerProvider.tabController,
                    children: tabControllerProvider.tabContents
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 200),
                            child: BuildMainTab(index: entry.key, tabControllerProvider: tabControllerProvider),
                          ),
                        )
                        .toList(),
                  ),
                )
              : const Center(child: Text("No Tabs")),
        );
      },
    );
  }
}
