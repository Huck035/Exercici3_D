import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M0489 - Apps - Form (D)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

InputDecoration deco(String label, {Widget? suffix}) => InputDecoration(
  labelText: label,
  suffixIcon: suffix,
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
);

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final String title = 'Salesians Sarrià 26/27';
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    FormBuilderField<String>(
                      name: 'autocomplete',
                      builder: (FormFieldState<String> field) {
                        const countries = [
                          'Angola',
                          'Angular',
                          'Argentina',
                          'Alemania',
                          'Andorra',
                        ];
                        return Autocomplete<String>(
                          optionsBuilder: (TextEditingValue v) {
                            if (v.text.isEmpty) {
                              return const Iterable<String>.empty();
                            }
                            return countries.where(
                              (c) =>
                                  c.toLowerCase().contains(v.text.toLowerCase()),
                            );
                          },
                          onSelected: (String s) => field.didChange(s),
                          fieldViewBuilder:
                              (context, controller, focusNode, onSubmitted) {
                            return TextField(
                              controller: controller,
                              focusNode: focusNode,
                              onChanged: (v) => field.didChange(v),
                              decoration: deco('Autocomplete'),
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    FormBuilderDateTimePicker(
                      name: 'date',
                      inputType: InputType.date,
                      decoration: deco(
                        'Date Picker',
                        suffix: const Icon(Icons.calendar_today),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderDateRangePicker(
                      name: 'range',
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                      decoration: deco(
                        'Date Range',
                        suffix: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => _formKey
                              .currentState?.fields['range']
                              ?.didChange(null),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FormBuilderDateTimePicker(
                      name: 'time',
                      inputType: InputType.time,
                      decoration: deco('Time Picker',
                          suffix: const Icon(Icons.access_time)),
                    ),
                    const SizedBox(height: 20),
                     FormBuilderFilterChips<String>(
                      name: 'chips',
                      decoration: deco('Input Chips (Filter Chip)'),
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      backgroundColor: const Color(0xFF2F5B8A),
                      selectedColor: const Color(0xFF1F3F61),
                      checkmarkColor: Colors.white,
                      labelStyle: const TextStyle(color: Colors.white),
                      options: const [
                        FormBuilderChipOption(value: 'HTML'),
                        FormBuilderChipOption(value: 'CSS'),
                        FormBuilderChipOption(value: 'React'),
                        FormBuilderChipOption(value: 'Dart'),
                        FormBuilderChipOption(value: 'TypeScript'),
                        FormBuilderChipOption(value: 'Angular'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload),
        onPressed: () {
          _formKey.currentState?.saveAndValidate();
          String? formString = _formKey.currentState?.value.toString();
          alertDialog(context, formString!);
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class FormLabelGroup extends StatelessWidget {
  FormLabelGroup({super.key, required this.title, this.subtitle});

  String title;
  String? subtitle;

  Widget conditionalSubtitle(BuildContext context) {
    if (subtitle != null) {
      return Text(
        subtitle!,
        style: Theme.of(context).textTheme.labelLarge?.apply(
          fontSizeFactor: 1.25,
          // ignore: deprecated_member_use
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20.0, 0, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.labelLarge?.apply(fontSizeFactor: 1.25),
          ),
          conditionalSubtitle(context),
        ],
      ),
    );
  }
}

class FormTitle extends StatelessWidget {
  const FormTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            'Form title',
            style: Theme.of(
              context,
            ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text('description', style: Theme.of(context).textTheme.labelLarge),
        ],
      ),
    );
  }
}

void alertDialog(BuildContext context, String contentText) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text("Submission Completed"),
      icon: const Icon(Icons.check_circle),
      content: Text(contentText),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Tancar'),
          child: const Text('Tancar'),
        ),
      ],
    ),
  );
}
