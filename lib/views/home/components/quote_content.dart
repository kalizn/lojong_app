import 'package:flutter/material.dart';

import '../../../models/home/quotes2_content.dart';
import '../../../utils/share.dart';

class QuotesPage extends StatelessWidget {
  final List<Quotes2Content> quotes;

  const QuotesPage({super.key, required this.quotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          int cardIndex = index % 3;
          return QuoteCard(
            quote: quotes[index],
            cardIndex: cardIndex,
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 3), // Adicionar espaçamento entre os cards
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final Quotes2Content quote;
  final int cardIndex;

  QuoteCard({required this.quote, required this.cardIndex});

  @override
  Widget build(BuildContext context) {

    String titleShare = 'Ei, se liga na mais nova citação que tem na Lojong:';
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Card(
        color: Colors.transparent,
        child: Container(
          height: 380.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: _getBackgroundColor(cardIndex),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    quote.text,
                    style: TextStyle(
                      color: _getTextColor(cardIndex),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 8,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  quote.author,
                  style: TextStyle(
                    color: _getTextColor(cardIndex),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () {
                    shareVideo(context, titleShare, quote.text, quote.author);
                  },
                  icon: const Icon(Icons.share, color: Colors.white),
                  label: const Text(
                    'Compartilhar',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getButtonColor(cardIndex),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

  }

  Color _getButtonColor(int cardIndex) {
    if (cardIndex == 0) {
      return const Color(0xFF4067AB); // Cor para o primeiro card
    } else if (cardIndex == 1) {
      return const Color(0xFFD0A884); // Cor para o segundo card
    } else {
      return const Color(0xFFBF7A8A); // Cor para o terceiro card
    }
  }

  LinearGradient _getBackgroundColor(int cardIndex) {
    // Determinar a decoração gradiente com base no índice do card
    if (cardIndex == 0) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF95C4E8),
          Color(0xFFF2F7FA),
        ],
      );
    } else if (cardIndex == 1) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFE8D5A2),
          Color(0xFFEEC09A),
        ],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFE8977E),
          Color(0xFFD98B9F),
        ],
      );
    }
  }

  Color _getTextColor(int cardIndex) {
    // Determinar a cor do texto com base no índice do card
    if (cardIndex == 0) {
      return const Color(0xFF446DAF); // Cor para o primeiro card
    } else if (cardIndex == 1) {
      return const Color(0xFF6B5E48); // Cor para o segundo card
    } else {
      return Colors.white; // Cor para o terceiro card
    }
  }
}
