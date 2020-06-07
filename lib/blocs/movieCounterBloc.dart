import 'dart:async';

class MovieCounterBloc {
  int _movieCounter = 0;

  final _movieCounterStateController = StreamController<int>();
  final _movieCounterEventController = StreamController<CounterEvent>();

  StreamSink<int> get _addCounter => _movieCounterStateController.sink;

  Stream<int> get counter => _movieCounterStateController.stream;

  StreamSink<CounterEvent> get counterEventSink =>
      _movieCounterEventController.sink;

  MovieCounterBloc() {
    _movieCounterEventController.stream.listen(_mapEventToState);
  }

  void _mapEventToState(CounterEvent event) {
    if (event is AddMovie) {
      _movieCounter++;
    } else {
      _movieCounter--;
    }
    _addCounter.add(_movieCounter);
  }

  void dispose() {
    _movieCounterEventController.close();
    _movieCounterStateController.close();
  }
}

abstract class CounterEvent {}

class AddMovie extends CounterEvent {}

class RemoveMovie extends CounterEvent {}
