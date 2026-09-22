enum TaskStatus {
  pending,
  inProgress,
  done
}

class Task {
  final int? id;
  final String title;
  final TaskStatus status;

  const Task({
    this.id,
    required this.title,
    this.status = TaskStatus.pending,
  });

  // 1. Converter do objeto Dart para o Map do SQFlite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': title,
      'status': status.name, // Converte enum para String (ex: 'pending')
    };
  }

  // 2. Converter do Map do SQFlite para o objeto Dart
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int?,
      title: map['name'] as String,
      // Converte a String do banco de volta para o Enum
      status: TaskStatus.values.firstWhere(
        (e) => e.name == map['status'],
        orElse: () => TaskStatus.pending,
      ),
    );
  }

  // Método copyWith atualizado com o id
  Task copyWith({
    int? id,
    String? title,
    TaskStatus? status,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
    );
  }
}
