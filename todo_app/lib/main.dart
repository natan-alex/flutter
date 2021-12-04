import 'package:todo_app/todo_item.dart';
import 'package:todo_app/todos_db.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de tarefas'),
          centerTitle: true,
        ),
        body: AppBody());
  }
}

class AppBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppBodyState();
}

class AppBodyState extends State<AppBody> {
  final _formKey = GlobalKey<FormState>();
  final TodosDb _todosDb = TodosDb.instance;
  List<TodoItem> allTodos = List.empty(growable: true);
  List<bool> todosExpanded = List.empty(growable: true);
  final TextEditingController newTodoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _retrieveAllTodos();
  }

  void _retrieveAllTodos() async {
    var allItems = await _todosDb.getAllItems();
    setState(() {
      allTodos = allItems;
      for (int i = 0; i < allTodos.length; i++) {
        todosExpanded.add(false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      _getForm(),
      ListView(scrollDirection: Axis.vertical, shrinkWrap: true, children: [
        ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              todosExpanded[panelIndex] = !isExpanded;
            });
          },
          children: allTodos.mapIndexed((index, todo) {
            return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(title: Text(todo.description));
                },
                isExpanded: todosExpanded[index],
                body: _getTodoExpansionPanelBody(todo));
          }).toList(),
        )
      ])
    ]));
  }

  Form _getForm() {
    return Form(
        key: _formKey,
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextFormField(
                controller: newTodoController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'A descrição da tarefa não pode ser vazia!';
                  }
                  return null;
                },
                decoration:
                    const InputDecoration(hintText: 'Descrição da nova tarefa'),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ElevatedButton(
                  onPressed: () {
                    _addTodoItem();
                  },
                  child: const Text('Adicionar tarefa')))
        ]));
  }

  void _addTodoItem() async {
    if (_formKey.currentState!.validate()) {
      await _todosDb.createItem(
          TodoItem(id: 0, description: newTodoController.value.text));

      var allItems = await _todosDb.getAllItems();

      setState(() {
        allTodos = allItems;
        todosExpanded.add(false);
      });

      newTodoController.clear();
    }
  }

  Padding _getTodoExpansionPanelBody(TodoItem todo) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _getRowWithIsDoneCheckbox(todo),
            _getGestureDetectorWithDeleteIcon(todo)
          ]),
          _getWithTextFieldToEditTodoDescription(todo)
        ]));
  }

  Row _getRowWithIsDoneCheckbox(TodoItem todo) {
    return Row(children: [
      const Text('Tarefa já feita?'),
      Checkbox(
          value: todo.isDone,
          onChanged: (newValue) {
            _changeIsTodoDone(todo, newValue);
          })
    ]);
  }

  void _changeIsTodoDone(TodoItem todo, bool? isTodoDone) async {
    setState(() {
      todo.isDone = (isTodoDone as bool);
    });
    await _todosDb.updateItem(todo.id, todo);
  }

  GestureDetector _getGestureDetectorWithDeleteIcon(TodoItem todo) {
    return GestureDetector(
      child: const Icon(
        Icons.delete,
        size: 25,
      ),
      onTap: () {
        _deleteTodo(todo.id);
      },
    );
  }

  void _deleteTodo(int id) async {
    if (await _todosDb.deleteItemById(id)) {
      var remainingItems = await _todosDb.getAllItems();

      setState(() {
        allTodos = remainingItems;
      });
    }
  }

  TextField _getWithTextFieldToEditTodoDescription(TodoItem todo) {
    TextEditingController textEditingController = TextEditingController();

    return TextField(
      decoration: const InputDecoration(hintText: 'Nova descrição da tarefa'),
      controller: textEditingController,
      onSubmitted: (newDescription) {
        _changeTodoDescription(todo, newDescription);
        textEditingController.clear();
      },
    );
  }

  void _changeTodoDescription(TodoItem todo, String newDescription) async {
    setState(() {
      todo.description = newDescription;
    });
    await _todosDb.updateItem(todo.id, todo);
  }
}
