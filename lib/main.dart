import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final streamProvider = StreamProvider<int>((ref) async* {
  await for (final value in Stream.periodic(
    const Duration(seconds: 1),
    (computationCount) => computationCount,
  )) {
    debugPrint("streamProvider – value: $value");
    yield value;
  }
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<Future<int>>(streamProvider.future, (previous, next) async {
      debugPrint("listen – previous: ${await previous}");
      debugPrint("listen – next: ${await next}");
    });

    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text('first_stream_listen_issue')),
      ),
    );
  }
}
