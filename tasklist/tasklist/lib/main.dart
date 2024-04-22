import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TarefasProvider(),
      child: MaterialApp(
        title: 'Minhas Tarefas',
        theme: ThemeData(
          primaryColor: Colors.lightGreen,
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: Colors.blueAccent,
          ),
        ),
        home: TarefasApp(),
      ),
    ),
  );
}

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

class TarefasApp extends StatefulWidget {
  @override
  _TarefasAppState createState() => _TarefasAppState();
}

class _TarefasAppState extends State<TarefasApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Consumer<TarefasProvider>(
              builder: (context, provider, _) {
                List<String> tarefas = provider.tarefas;
                return ListView.builder(
                  itemCount: tarefas.length,
                  itemBuilder: (_, index) {
                    final item = tarefas[index];
                    return Dismissible(
                      key: Key(item),
                      onDismissed: (direction) {
                        provider.removerTarefa(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("$item removida"),
                            backgroundColor: Colors.redAccent,
                          ),
                        );
                      },
                      background: Container(color: Colors.red),
                      child: ListTile(
                        title: Text(
                          item,
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdicionarTarefa(),
                ),
              );
            },
            child: Text('Adicionar Tarefa'),
          ),
        ],
      ),
    );
  }
}

class AdicionarTarefa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controladorTarefa = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Tarefa"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controladorTarefa,
                decoration: InputDecoration(
                  labelText: 'Nova Tarefa',
                  fillColor: Colors.grey[200],
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final novaTarefa = _controladorTarefa.text;
                if (novaTarefa.isNotEmpty) {
                  Provider.of<TarefasProvider>(context, listen: false)
                      .adicionarTarefa(novaTarefa);
                  _controladorTarefa.clear();
                  Navigator.pop(context);
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
