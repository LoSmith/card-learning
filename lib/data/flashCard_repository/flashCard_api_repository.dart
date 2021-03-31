import 'package:card_learning/models/flashCard.dart';

import '../irepository.dart';

class FlashCardApiRepository implements IRepository<FlashCard> {
  @override
  Future<void> create(object) => Future.delayed(Duration(seconds: 2), () {
        //Send to a remote data source
      });

  @override
  Future<FlashCard> read(id) => Future.delayed(Duration(seconds: 2),
      () => FlashCard("$id", "question from remote", 'solution from remote'));

  @override
  Future<void> delete(id) => Future.delayed(Duration(seconds: 2), () {
        // delete data on remote
      });

  @override
  Future<void> update(dynamic id, FlashCard object) =>
      Future.delayed(Duration(seconds: 2), () {
        // update data on remote
      });
}
