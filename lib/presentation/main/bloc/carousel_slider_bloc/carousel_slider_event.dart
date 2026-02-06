abstract class CarouselSLiderEvent {}
class PageChangedEvent extends CarouselSLiderEvent {
  final int newIndex;

  PageChangedEvent(this.newIndex);
}