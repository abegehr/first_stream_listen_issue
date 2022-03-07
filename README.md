# first_stream_listen_issue

Issue: [WidgetRef.listen](https://pub.dev/documentation/flutter_riverpod/latest/flutter_riverpod/WidgetRef/listen.html) does not catch first yield from a StreamProvider

![screenshot](./screenshot.png)

I expect the log to be:

```text
Restarted application in 607ms.
flutter: streamProvider – value: 0
flutter: listen – previous: null
flutter: listen – next: 0
flutter: streamProvider – value: 1
flutter: listen – previous: 0
flutter: listen – next: 1
[...]
```

However, it is:

```text
Restarted application in 607ms.
flutter: streamProvider – value: 0
flutter: streamProvider – value: 1
flutter: listen – previous: 0
flutter: listen – next: 1
[...]
```

=> listener() is called only once the stream has two values.
