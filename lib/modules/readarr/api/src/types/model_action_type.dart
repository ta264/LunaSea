part of readarr_types;

enum ModelAction { UNKNOWN, CREATED, UPDATED, DELETED, SYNC }

extension ModelActionTypeExtension on ModelAction {
  ModelAction? from(String? type) {
    switch (type) {
      case 'unknown':
        return ModelAction.UNKNOWN;
      case 'created':
        return ModelAction.CREATED;
      case 'updated':
        return ModelAction.UPDATED;
      case 'deleted':
        return ModelAction.DELETED;
      case 'sync':
        return ModelAction.SYNC;
      default:
        return null;
    }
  }

  String? get value {
    switch (this) {
      case ModelAction.UNKNOWN:
        return 'unknown';
      case ModelAction.CREATED:
        return 'created';
      case ModelAction.UPDATED:
        return 'updated';
      case ModelAction.DELETED:
        return 'deleted';
      case ModelAction.SYNC:
        return 'sync';
      default:
        return null;
    }
  }
}
