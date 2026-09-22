# Lista de tarefas (BLoC)

Aplicação desenvolvida para fins de estudo e prática do padrão de gerenciamento de estado **BLoC** e persistência de dados local com **sqflite** no **Flutter**.

---

## Funcionalidades
O aplicativo permite gerenciar uma lista de tarefas com os seguintes status:
- **A fazer**
- **Fazendo**
- **Concluído**

---

## Tecnologias Utilizadas

- **[Flutter](https://flutter.dev/)**
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)** — Gerenciamento de Estado
- **[sqflite](https://pub.dev/packages/sqflite)** — Banco de dados SQLite local

---

## Como Executar 

### Pré-requisitos

- **[Flutter SDK](https://docs.flutter.dev/get-started/install)** instalado e configurado.
- Emulador Android/iOS ativo ou dispositivo físico com modo de depuração ativado.

#### Passos

Instale as dependências:
```bash
flutter pub get
```
Execute a aplicação
```bash
flutter run
```

## Arquitetura

```Plaintext
lib/
├── bloc/
│   ├── task_bloc.dart    # Lógica de negócios
│   ├── task_event.dart   # Eventos enviados para o BLoC
│   └── task_state.dart   # Estados emitidos pelo BLoC
│
├── data/
│   ├── database.dart     # Conexão e inicialização do SQLite
│   └── task_dao.dart     # Data Access Object (métodos do banco)
│
├── pages/
│   └── task_page.dart    # Interface do usuário (UI)
│
└── main.dart             # Ponto de entrada da aplicação
```
