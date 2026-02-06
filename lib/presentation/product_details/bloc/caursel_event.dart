abstract class CarouselEvent {}

class MoveNext extends CarouselEvent {
  final int itemCount;
  MoveNext(this.itemCount);
}

class MovePrevious extends CarouselEvent {
  final int itemCount;
  MovePrevious(this.itemCount);
}

class MoveToIndex extends CarouselEvent {
  final int index;
  final int itemCount;
  MoveToIndex(this.index, this.itemCount);
}
