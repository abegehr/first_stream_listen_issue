import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final streamProvider = StreamProvider<int>((ref) async* {
  await for (final value in Stream.periodic(
    const Duration(seconds: 1),
    (computationCount) => computationCount,
  )) {
    debugPrint("streamProvider – value: $value");
    yield value;
  }
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(streamProvider).value;

    ref.listen(streamProvider.future, (previous, next) {});

    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text("value: $value")),
      ),
    );
  }
}
