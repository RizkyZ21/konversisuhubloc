import 'package:flutter_bloc/flutter_bloc.dart';
import 'suhu_event.dart';
import 'suhu_state.dart';

class SuhuBloc extends Bloc<SuhuEvent, SuhuState> {
  SuhuBloc() : super(SuhuState()) {
    on<SetSatuanEvent>((event, emit) {
      emit(state.copyWith(satuan: event.satuan));
    });

    on<KonversiEvent>((event, emit) {
      double? suhu = double.tryParse(event.input);

      if (suhu == null) {
        emit(state.copyWith(hasil: "Input tidak valid"));
        return;
      }

      double c, f, r, k;
      String hasil;

      if (state.satuan == "Celsius") {
        c = suhu;
        f = (c * 9 / 5) + 32;
        r = c * 4 / 5;
        k = c + 273.15;
        hasil =
            "Fahrenheit: ${f.toStringAsFixed(2)}\nReamur: ${r.toStringAsFixed(2)}\nKelvin: ${k.toStringAsFixed(2)}";
      } else if (state.satuan == "Fahrenheit") {
        c = (suhu - 32) * 5 / 9;
        f = suhu;
        r = c * 4 / 5;
        k = c + 273.15;
        hasil =
            "Celsius: ${c.toStringAsFixed(2)}\nReamur: ${r.toStringAsFixed(2)}\nKelvin: ${k.toStringAsFixed(2)}";
      } else if (state.satuan == "Reamur") {
        c = suhu * 5 / 4;
        f = (c * 9 / 5) + 32;
        r = suhu;
        k = c + 273.15;
        hasil =
            "Celsius: ${c.toStringAsFixed(2)}\nFahrenheit: ${f.toStringAsFixed(2)}\nKelvin: ${k.toStringAsFixed(2)}";
      } else {
        c = suhu - 273.15;
        f = (c * 9 / 5) + 32;
        r = c * 4 / 5;
        k = suhu;
        hasil =
            "Celsius: ${c.toStringAsFixed(2)}\nFahrenheit: ${f.toStringAsFixed(2)}\nReamur: ${r.toStringAsFixed(2)}";
      }

      emit(state.copyWith(hasil: hasil));
    });
  }
}
