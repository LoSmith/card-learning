import 'package:card_learning/domain/models/flashCard.dart';
import 'package:card_learning/exceptions/no_connection_exception.dart';
import 'package:flutter/foundation.dart';

import '../irepository.dart';

class FlashCardRepository implements IRepository<FlashCard> {
  final IRepository<FlashCard> source;
  final IRepository<FlashCard> cache;
  final bool Function() hasConnection;
  FlashCardRepository({
    @required this.source,
    @required this.cache,
    @required this.hasConnection,
  });

  @override
  Future<FlashCard> get(dynamic id) async {
    final cachedFlashCard = await this.cache.get(id);

    if (cachedFlashCard != null) {
      return cachedFlashCard;
    }

    if (!this.hasConnection()) {
      throw NoConnectionException();
    }

    final remoteFlashCard = await this.source.get(id);
    this.cache.add(remoteFlashCard);

    return remoteFlashCard;
  }

  @override
  Future<void> add(FlashCard object) async {
    if (!this.hasConnection()) {
      throw NoConnectionException();
    }

    await this.source.add(object);
    await this.cache.add(object);
  }
}
