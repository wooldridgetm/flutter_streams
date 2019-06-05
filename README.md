# Reactive Streams in Flutter

Example Project showing how to observe data in a Presenter & respond to it in the UI.

* StreamController
* StreamBuilder - useful for rebuilding UI when stream is updated.
* RxDart - PublishSubject


## StreamController

Programmatic Interface for Creating Streams that are single-subscription. Even after the subscription has been cancelled, Flutter throws an exception if you try & listen to it again.

### Sink vs Stream

**Sink** & **Stream** are both part of the **StreamController**. Outside entities add data to the StreamController with a Sink. We can listen to it via the Stream

refer to [Sink vs Stream on StackOverflow](https://stackoverflow.com/questions/50350235/what-is-the-difference-between-sink-and-stream-in-flutter) for more.

## PublishSubject

Broadcast StreamController
