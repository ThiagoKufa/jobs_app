import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';
import '../widgets/todo_title.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBgColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 15),
            child: Column(children: [
              searchBox(),
              Expanded(
                child: ListView(
                  children: [
                    const TodoTitle(),
                    for (ToDo item in _foundToDo)
                      TodoItem(
                        todo: item,
                        onToDoChanged: _handleToDoChanged,
                        onDeleteToDoItem: () {
                          _deleteToDoItem(item.id!);
                        },
                      ),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              )
            ]),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 10.0,
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      hintText: 'Nova Tarefa',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    _addToDoItem(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: tdBlue,
                    minimumSize: Size(60, 60),
                    elevation: 10,
                  ),
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Buscar',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        SizedBox(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              color: tdGrey,
              child: const Icon(Icons.person),
            ),
          ),
        ),
      ]),
      backgroundColor: tdBgColor,
    );
  }

  void _handleToDoChanged(ToDo todo) {
    setState(() => todo.isDone = !todo.isDone);
  }

  void _deleteToDoItem(String id) {
    setState(() => todosList.removeWhere((item) => item.id == id));
  }

  void _addToDoItem(String toDo) {
    setState(() {
      if (toDo.isNotEmpty) {
        todosList.add(
          ToDo(
            id: DateTime.now().microsecond.toString(),
            todoText: toDo,
          ),
        );
      }
      _todoController.clear();
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((item) => item.todoText!
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
}
