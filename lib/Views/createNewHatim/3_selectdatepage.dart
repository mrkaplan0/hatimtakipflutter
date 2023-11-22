import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hatimtakipflutter/Views/Widgets/custom_button.dart';
import 'package:hatimtakipflutter/riverpod/providers.dart';

final dateChosenProv = StateProvider<bool>((ref) => false);
final date = StateProvider<DateTime>((ref) => DateTime.now());

// ignore: must_be_immutable
class SelectDatePage extends ConsumerWidget {
  SelectDatePage({super.key});

  final String deadlineChosenInfoText =
      "Hatimin icin bitis tarihi ayarlamak ister misin?";
  final String timepickerInfoText = "Hatimin planlanan bitis tarihi:";
  final String yesButtonText = "Evet";
  final String noButtonText = "Hayir";
  final String cancelSelectAndContiueButtonText = "Vazgeç ve Devam Et";
  final String completeProcessButtonText = "Tamamla";
  final String nextButtonText = "Sonraki";

  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size / 4,
            ),
            Icon(
              Icons.access_time,
              size: 100,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(
              height: 20,
            ),
            if (ref.watch(dateChosenProv) == false) ...[
              doYouWantDeadline(context, ref)
            ],
            if (ref.watch(dateChosenProv) == true) ...[
              iWantToDeadline(context, ref)
            ],
            SizedBox(height: size / 3),
          ],
        ),
      ),
    );
  }

  Widget doYouWantDeadline(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(deadlineChosenInfoText),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: CustomButton(
                    btnText: yesButtonText,
                    onPressed: () {
                      ref.read(dateChosenProv.notifier).state = true;
                      myDateTimePicker(context, ref);
                    })),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: CustomButton(
                    btnText: noButtonText,
                    onPressed: () {
                      ref.read(myPageController.notifier).state.jumpToPage(4);
                    })),
          ],
        )
      ],
    );
  }

  Widget iWantToDeadline(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(timepickerInfoText),
        GestureDetector(
          child: Text(ref.watch(date).isUtc == DateTime.now().isUtc
              ? ""
              : DateFormat.yMd().add_Hm().format(ref.watch(date))),
          onTap: () {
            myDateTimePicker(context, ref);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        CustomButton(
            btnText: completeProcessButtonText,
            onPressed: () {
              ref.invalidate(date);
              ref.read(myPageController.notifier).state.jumpToPage(4);
            }),
        const SizedBox(
          width: 8,
        ),
        CustomButton(
            btnText: cancelSelectAndContiueButtonText,
            onPressed: () {
              ref.invalidate(date);
              ref.read(myPageController.notifier).state.jumpToPage(4);
            }),
      ],
    );
  }

  myDateTimePicker(BuildContext context, WidgetRef ref) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime(DateTime.now().year + 3),
    ).then((selectedDate) {
      // After selecting the date, display the time picker.
      if (selectedDate != null) {
        showTimePicker(
          initialEntryMode: TimePickerEntryMode.dial,
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          // Handle the selected date and time here.
          if (selectedTime != null) {
            _selectedDate = DateTime(
              selectedDate.year,
              selectedDate.month,
              selectedDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );

            ref.read(date.notifier).state = _selectedDate;
            ref.read(newHatimProvider).deadline = _selectedDate;
            print(_selectedDate);
          }
        });
      }
    });
  }
}
