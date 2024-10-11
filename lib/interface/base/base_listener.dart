import '../../listener/listener.dart';

abstract class BaseListener {
  void setListener<T extends Listener>(T listener);

  void removeListener<T extends Listener>(T listener);
}
