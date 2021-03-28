import 'package:card_learning/domain/models/flashCard.dart';

import '../irepository.dart';

class FlashCardApiRepository implements IRepository<FlashCard> {
  @override
  Future<void> add(object) => Future.delayed(Duration(seconds: 2), () {
        //Send to a remote data source
      });

  @override
  Future<FlashCard> get(id) => Future.delayed(Duration(seconds: 2),
      () => FlashCard("$id", "mock question", 'mock answer'));
}
