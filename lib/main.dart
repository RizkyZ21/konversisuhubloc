import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: KonversiSuhu(), debugShowCheckedModeBanner: false);
  }
}

class KonversiSuhu extends StatefulWidget {
  @override
  _KonversiSuhuState createState() => _KonversiSuhuState();
}

class _KonversiSuhuState extends State<KonversiSuhu> {
  TextEditingController suhuController = TextEditingController();

  String satuanInput = "Celsius";
  String hasil = "";

  void konversi() {
    double suhu = double.parse(suhuController.text);

    double c, f, r, k;

    if (satuanInput == "Celsius") {
      c = suhu;
      f = (c * 9 / 5) + 32;
      r = c * 4 / 5;
      k = c + 273.15;
    } else if (satuanInput == "Fahrenheit") {
      c = (suhu - 32) * 5 / 9;
      f = suhu;
      r = c * 4 / 5;
      k = c + 273.15;
    } else if (satuanInput == "Reamur") {
      c = suhu * 5 / 4;
      f = (c * 9 / 5) + 32;
      r = suhu;
      k = c + 273.15;
    } else {
      c = suhu - 273.15;
      f = (c * 9 / 5) + 32;
      r = c * 4 / 5;
      k = suhu;
    }

    setState(() {
      if (satuanInput == "Celsius") {
        hasil =
            "Fahrenheit (°F) : ${f.toStringAsFixed(2)}\nReamur (°R) : ${r.toStringAsFixed(2)}\nKelvin (K) : ${k.toStringAsFixed(2)}";
      } else if (satuanInput == "Fahrenheit") {
        hasil =
            "Celsius (°C) : ${c.toStringAsFixed(2)}\nReamur (°R) : ${r.toStringAsFixed(2)}\nKelvin (K) : ${k.toStringAsFixed(2)}";
      } else if (satuanInput == "Reamur") {
        hasil =
            "Celsius (°C) : ${c.toStringAsFixed(2)}\nFahrenheit (°F) : ${f.toStringAsFixed(2)}\nKelvin (K) : ${k.toStringAsFixed(2)}";
      } else {
        hasil =
            "Celsius (°C) : ${c.toStringAsFixed(2)}\nFahrenheit (°F) : ${f.toStringAsFixed(2)}\nReamur (°R) : ${r.toStringAsFixed(2)}";
      }
    });
  }

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

            DropdownButton<String>(
              value: satuanInput,
              items: ["Celsius", "Fahrenheit", "Reamur", "Kelvin"]
                  .map(
                    (String value) =>
                        DropdownMenuItem(value: value, child: Text(value)),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  satuanInput = value!;
                });
              },
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: konversi, child: Text("Konversi")),

            SizedBox(height: 20),

            Text(hasil, style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
