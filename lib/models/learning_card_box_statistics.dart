class CardBoxStatistics {
  // indicates if the statistics are valid
  bool isValid = false;
  // number of total cards
  int numberOfCards = 0;
  // number of card has been tested
  int numberOfCardsStudied = 0;
  // number of cards which are at a success rate above the matureThreshold
  int numberOfCardsMatured = 0;

  double percentageOfCardsStudied = 0;
  // threshold when a cards rank is matured
  static final double matureThreshold = 0.8;

  static final int minimumTimesTested = 2;

}
