import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TarefasProvider extends ChangeNotifier {
  final List<String> _tarefas = [];

  List<String> get tarefas => _tarefas;

  void adicionarTarefa(String novaTarefa) {
    _tarefas.add(novaTarefa);
    notifyListeners();
  }

  void removerTarefa(int index) {
    _tarefas.removeAt(index);
    notifyListeners();
  }
}
