import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../viewmodels/home/home.video.viewmodel.dart';
import '../../viewmodels/home/home.viewmodel.dart';
import 'components/video_content.dart';

class HomeView extends StatefulWidget {
  static String routeName = '/home';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = HomeViewModel(
      vsync: this,
      onTabSelectionChanged: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('INSPIRAÇÕES'),
          backgroundColor: kPrimaryColor,
          leading: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: kSecondaryColor,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight * 1.5),
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: viewModel.tabBarBackgroundColor,
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TabBar(
                controller: viewModel.tabController,
                padding: const EdgeInsets.all(5),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                tabs: [
                  for (var tab in viewModel.tabs)
                    _buildTab(tab.title, tab.index),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: viewModel.tabController,
          children: [
            // Use Provider para obter a instância de HomeVideoViewModel
            VideoContent(viewModel: Provider.of<HomeVideoViewModel>(context)),
            Center(child: Text('Favorites Content')),
            Center(child: Text('Profile Content')),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = index == viewModel.tabController.index;

    return Tab(
      child: Text(
        text,
        style: TextStyle(
          color: isSelected
              ? viewModel.selectedTabColor
              : viewModel.unselectedTabColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
