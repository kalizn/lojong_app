import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../viewmodels/home/home.viewmodel.dart';
import 'components/article_content.dart';
import 'components/quote_content.dart';
import 'components/video_content.dart';

class HomeView extends StatefulWidget {
  static String routeName = '/home';

  const HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView>  {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget _buildNavItem(int index, String title) {
    double screenWidth = MediaQuery.of(context).size.width;
    double horizontalPadding = screenWidth * 0.05;
    double verticalPadding = 6;

    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: verticalPadding, horizontal: horizontalPadding),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? const Color.fromRGBO(199, 128, 128, 1)
                : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeViewModel = Provider.of<HomeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: kSecondaryColor,
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 40),
                child: Center(
                  child: Text(
                    'INSPIRAÇÕES',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight * 0.9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: kSecondaryColor,
                borderRadius: BorderRadius.circular(80),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, 'VÍDEOS'),
                  _buildNavItem(1, 'ARTIGOS'),
                  _buildNavItem(2, 'CITAÇÕES'),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: [
            Center(
              child: _buildPage(homeViewModel.isLoading, homeViewModel.isError,
                  ()  {
                return ListView.builder(
                  itemCount: homeViewModel.videos.length,
                  itemBuilder: (context, index) {
                    final video = homeViewModel.videos[index];
                    return CardVideo(data: video);
                  },
                );
              }, homeViewModel),
            ),
            Center(
              child: _buildPage(homeViewModel.isLoading, homeViewModel.isError,
                   () {
                return ListView.builder(
                  itemCount: homeViewModel.articlesContent.length,
                  itemBuilder: (context, index) {
                    final article = homeViewModel.articlesContent[index];
                    return CardArticle(data: article);
                  },
                );
              }, homeViewModel),
            ),
            Center(
              child: _buildPage(homeViewModel.isLoading, homeViewModel.isError,
                  ()  {
                return QuotesPage(quotes: homeViewModel.quotes);
              }, homeViewModel),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildPage(bool isLoading, bool isError,
    Widget Function() contentBuilder, homeViewModel) {
  if (isLoading) {
    return const CircularProgressIndicator();
  } else if (isError) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'OPS!',
          style: TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          width: 180,
          child: Text(
            'Não foi possível conectar ao servidor, verifique se está conectado à internet.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: 150,
          child: ElevatedButton(
            onPressed: () {
              homeViewModel.loadVideos();
              homeViewModel.loadArticlesList();
              homeViewModel.loadQuotes();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kButtonShare,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            ),
            child: const Text(
              'Recarregar',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),

      ],
    );
  } else {
    final content = contentBuilder();
    return content;
  }
}
