import 'package:card_learning/models/flashCard.dart';
import 'package:flutter/foundation.dart';

import '../irepository.dart';

class LocalFlashCardRepository implements IRepository<FlashCard> {
  final IRepository<FlashCard> source;
  LocalFlashCardRepository({
    @required this.source,
  });

  @override
  Future<FlashCard> read(dynamic id) async {
    final remoteFlashCard = await this.source.read(id);
    return remoteFlashCard;
  }

  @override
  Future<void> create(FlashCard object) async {
    await this.source.create(object);
  }

  @override
  Future<void> delete(dynamic id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<void> update(dynamic id, FlashCard object) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
