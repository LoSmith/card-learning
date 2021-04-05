import 'package:card_learning/exceptions/no_connection_exception.dart';
import 'package:card_learning/models/flashCard.dart';
import 'package:flutter/foundation.dart';

import '../irepository.dart';

class RemoteAndCacheFlashCardRepository implements IRepository<FlashCard> {
  final IRepository<FlashCard> source;
  final IRepository<FlashCard> cache;
  final bool Function() hasConnection;
  RemoteAndCacheFlashCardRepository({
    @required this.source,
    @required this.cache,
    @required this.hasConnection,
  });

  @override
  Future<FlashCard> read(dynamic id) async {
    final cachedFlashCard = await this.cache.read(id);

    if (cachedFlashCard != null) {
      return cachedFlashCard;
    }

    if (!this.hasConnection()) {
      throw NoConnectionException();
    }

    final remoteFlashCard = await this.source.read(id);
    this.cache.create(remoteFlashCard);

    return remoteFlashCard;
  }

  @override
  Future<void> create(FlashCard object) async {
    if (!this.hasConnection()) {
      throw NoConnectionException();
    }

    await this.source.create(object);
    await this.cache.create(object);
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
