import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'advance_router.dart';

class SecretPage extends StatefulWidget {
  const SecretPage({super.key});

  static const name = '/secret-page';

  @override
  State<SecretPage> createState() => _SecretPageState();
}

class _SecretPageState extends State<SecretPage> {
  void showCupertinoModal(cupertinoScaffoldContext) {
    CupertinoScaffold.showCupertinoModalBottomSheet(
      context: cupertinoScaffoldContext,
      builder: (_) => Center(
        child: ElevatedButton(
          onPressed: () {
            auth.update(false);
          },
          child: const Text('Log out'),
        ),
      ),
    );
  }

  late BuildContext cuperTinoContext;

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance
  //       .addPostFrameCallback((_) => showCupertinoModal(cuperTinoContext));
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoScaffold(
      body: Builder(
        builder: (cupertinoScaffoldContext) {
          cuperTinoContext = cupertinoScaffoldContext;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Secret Page'),
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: () {
                  showCupertinoModal(cupertinoScaffoldContext);
                },
                child: const Text('Open Cupertino Modal BottomSheet'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CounterApp extends HookWidget {
  const CounterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = useState<int>(0);
    return Material(
      child: CupertinoScaffold(
        body: Builder(
          builder: (c) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => counter.value--,
                      icon: const Icon(Icons.add),
                    ),
                    HookBuilder(
                      builder: (context) {
                        final value = useValueListenable(counter);
                        return Text('$value');
                      },
                    ),
                    IconButton(
                      onPressed: () => counter.value++,
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
