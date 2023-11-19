import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

final sliderValueProvider = StateProvider<double>((ref) => 0.0);

class CuzSettingsPage extends ConsumerStatefulWidget {
  const CuzSettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CuzSettingsPageState();
}

class _CuzSettingsPageState extends ConsumerState<CuzSettingsPage> {
  @override
  Widget build(BuildContext context) {
    var list = ref.watch(hatimPartsProvider);

    print(list.length);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Cüz Ayarları'),
      ),
      body: ListView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          itemBuilder: (context, i) {
            return Slidable(
              endActionPane:
                  ActionPane(motion: const ScrollMotion(), children: [
                SlidableAction(
                  onPressed: (BuildContext context) {
                    _showCuzSplitDialog(i);
                  },
                  label: 'Böl',
                  backgroundColor: Theme.of(context).primaryColorLight,
                )
              ]),
              child: Card(
                shape: Border.all(style: BorderStyle.none),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text((i + 1).toString()),
                      Text(ref
                          .read(hatimPartsProvider.notifier)
                          .setPartName(list[i].pages)),
                      TextButton(
                          onPressed: () {},
                          child: Text(list[i].ownerOfPart != null
                              ? list[i].ownerOfPart!.username
                              : 'Kişi Ata'))
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  _showCuzSplitDialog(int index) {
    var selectedCuz = ref.watch(hatimPartsProvider)[index];

    return showDialog(
        context: context,
        builder: (context) {
          return Consumer(
            builder: (context, watch, child) {
              final sliderValue = watch.watch(sliderValueProvider);

              return Dialog(
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Adjust the value: ${sliderValue.toInt()}'),
                        Slider(
                          value: sliderValue,
                          onChanged: (value) {
                            // Update the slider value when it's changed
                            watch.read(sliderValueProvider.notifier).state =
                                value;
                            print(value);
                            print(sliderValue);
                          },
                          min: 0.0,
                          max: 100.0,
                          label: sliderValue.toStringAsFixed(1),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Close the dialog when the button is pressed
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    )),
              );
            },
          );
        });
  }
}
