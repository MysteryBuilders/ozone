abstract class RatingEvent {}

class RatingChanged extends RatingEvent {
  final double rating;
  RatingChanged(this.rating);
}
