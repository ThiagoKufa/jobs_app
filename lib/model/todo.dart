class ToDo {
  String? id;
  String? todoText;
  late bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Exercícios Matinal', isDone: true),
      ToDo(id: '02', todoText: 'Comprar Pão', isDone: true),
      ToDo(id: '03', todoText: 'Verificar os E-mails'),
      ToDo(id: '04', todoText: 'Reunião com o Time'),
      ToDo(id: '05', todoText: 'Trabalhar no mobile App por 2h'),
      ToDo(id: '06', todoText: 'Estudar Flutter'),
      ToDo(id: '07', todoText: 'Jantar com a Talita'),
    ];
  }
}
