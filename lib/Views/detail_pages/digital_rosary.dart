import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final counter = StateProvider.autoDispose<int>((ref) => 0);

class DigitalRosary extends ConsumerWidget {
  const DigitalRosary({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
              child: Container(
            alignment: Alignment.center,
            child: Text(
              ref.watch(counter).toString(),
              style: const TextStyle(fontSize: 50),
            ),
          )),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => ref.watch(counter.notifier).state++,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.cyan.shade100.withOpacity(0.4),
                      border: const Border(
                          right: BorderSide(color: Colors.black12),
                          bottom: BorderSide(color: Colors.black12)),
                      boxShadow: const [
                        BoxShadow(
                          blurStyle: BlurStyle.outer,
                          spreadRadius: 0,
                          blurRadius: 1,
                          color: Colors.black12,
                        ),
                      ]),
                  width: double.infinity,
                  height: double.infinity / 2,
                  child: Text(
                    "TIKLA".tr(),
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
