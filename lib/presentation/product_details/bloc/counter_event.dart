abstract class CounterEvent {}

class Increment extends CounterEvent {
  int maxCount;
  Increment(this.maxCount);
}

class Decrement extends CounterEvent {
  int initalCount;
  Decrement(this.initalCount);
}
class InitialCountEvent extends CounterEvent{
  int initalCount;
  InitialCountEvent(this.initalCount);


}
