import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/suhu/suhu_bloc.dart';
import 'bloc/suhu/suhu_event.dart';
import 'bloc/suhu/suhu_state.dart';

void main() {
  runApp(BlocProvider(create: (_) => SuhuBloc(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: KonversiSuhu());
  }
}

class KonversiSuhu extends StatelessWidget {
  final TextEditingController suhuController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Konversi Suhu")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: suhuController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan Suhu",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            BlocBuilder<SuhuBloc, SuhuState>(
              builder: (context, state) {
                return DropdownButton<String>(
                  value: state.satuan,
                  items: ["Celsius", "Fahrenheit", "Reamur", "Kelvin"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    context.read<SuhuBloc>().add(SetSatuanEvent(value!));
                  },
                );
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                context.read<SuhuBloc>().add(
                  KonversiEvent(suhuController.text),
                );
              },
              child: Text("Konversi"),
            ),

            SizedBox(height: 20),

            BlocBuilder<SuhuBloc, SuhuState>(
              builder: (context, state) {
                return Text(
                  state.hasil,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
