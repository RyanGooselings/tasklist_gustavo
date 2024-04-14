import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Minhas Tarefas',
    theme: ThemeData(
      primaryColor: Colors.lightGreen,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.blueAccent,
      ),
    ),
    home: TarefasApp(),
  ));
}

class TarefasApp extends StatefulWidget {
  @override
  _TarefasAppState createState() => _TarefasAppState();
}

class _TarefasAppState extends State<TarefasApp> {
  final List<String> _tarefas = <String>[];

  void _adicionarTarefa(String novaTarefa) {
    setState(() {
      _tarefas.add(novaTarefa);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minhas Tarefas'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _tarefas.length,
              itemBuilder: (_, index) {
                final item = _tarefas[index];
                return Dismissible(
                  key: Key(item),
                  onDismissed: (direction) {
                    setState(() {
                      _tarefas.removeAt(index);
                    });
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
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AdicionarTarefa(adicionarTarefa: _adicionarTarefa),
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
  final Function(String) adicionarTarefa;

  const AdicionarTarefa({Key? key, required this.adicionarTarefa})
      : super(key: key);

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
                  adicionarTarefa(novaTarefa);
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
