import 'package:path/path.dart';
import 'package:stack_trace/stack_trace.dart';

bool loggingEnabled = false;

void log(dynamic message) {
  print("logging");
  if (loggingEnabled) {
    final frame = Trace.current().frames.firstWhere(
        (element) => !element.uri.toString().contains("logger.dart"));
    final file = basename(frame.uri.path);
    final line = '${DateTime.now()} [$file:${frame.line}] $message';
    print(line);
  }
}
