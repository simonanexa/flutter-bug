import 'dart:async';

class TextBloc{
  final _textStateController = StreamController<String>();
  StreamSink<String> get textSink => _textStateController.sink;
  Stream<String> get textStream => _textStateController.stream;

  final _text2StateController = StreamController<String>();
  StreamSink<String> get text2Sink => _text2StateController.sink;
  Stream<String> get text2Stream => _text2StateController.stream;
}