# api_example

## Google APIs

---

### **Dart and Google APIs**
Dart provides libraries and tools to interact with Google APIs, enabling developers to integrate services like Google Drive, Google Sheets, and Google Calendar into their Dart applications.

---

### **1. Using the `googleapis` Package**
The `googleapis` package provides generated Dart libraries for accessing Google APIs. You can install it via `pubspec.yaml`.

#### Example:
```yaml
dependencies:
  googleapis: ^9.0.0
  googleapis_auth: ^1.3.0
```

---

### **2. Authenticating with Google APIs**
To access Google APIs, you need to authenticate using OAuth 2.0. The `googleapis_auth` package simplifies this process.

#### Example:
```dart
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/drive/v3.dart' as drive;

final _credentials = auth.ServiceAccountCredentials.fromJson({
  "private_key": "YOUR_PRIVATE_KEY",
  "client_email": "YOUR_CLIENT_EMAIL",
});

final _scopes = [drive.DriveApi.driveScope];

void main() async {
  final client = await auth.clientViaServiceAccount(_credentials, _scopes);
  final driveApi = drive.DriveApi(client);

  // List files in Google Drive
  final files = await driveApi.files.list();
  print('Files: ${files.files?.map((file) => file.name).join(', ')}');

  client.close();
}
```

---

### **3. Accessing Google Drive**
You can use the `googleapis/drive/v3.dart` library to interact with Google Drive.

#### Example:
```dart
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis_auth/auth_io.dart' as auth;

final _credentials = auth.ServiceAccountCredentials.fromJson({
  "private_key": "YOUR_PRIVATE_KEY",
  "client_email": "YOUR_CLIENT_EMAIL",
});

final _scopes = [drive.DriveApi.driveScope];

void main() async {
  final client = await auth.clientViaServiceAccount(_credentials, _scopes);
  final driveApi = drive.DriveApi(client);

  // Upload a file to Google Drive
  final file = drive.File()..name = 'example.txt';
  final media = drive.Media(Stream.value('Hello, Google Drive!'.codeUnits), 19);
  await driveApi.files.create(file, uploadMedia: media);

  client.close();
}
```

---

### **4. Accessing Google Sheets**
You can use the `googleapis/sheets/v4.dart` library to interact with Google Sheets.

#### Example:
```dart
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis_auth/auth_io.dart' as auth;

final _credentials = auth.ServiceAccountCredentials.fromJson({
  "private_key": "YOUR_PRIVATE_KEY",
  "client_email": "YOUR_CLIENT_EMAIL",
});

final _scopes = [sheets.SheetsApi.spreadsheetsScope];

void main() async {
  final client = await auth.clientViaServiceAccount(_credentials, _scopes);
  final sheetsApi = sheets.SheetsApi(client);

  // Read data from a Google Sheet
  final spreadsheetId = 'YOUR_SPREADSHEET_ID';
  final range = 'Sheet1!A1:B2';
  final response = await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
  print('Data: ${response.values}');

  client.close();
}
```

---

### **5. Accessing Google Calendar**
You can use the `googleapis/calendar/v3.dart` library to interact with Google Calendar.

#### Example:
```dart
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart' as auth;

final _credentials = auth.ServiceAccountCredentials.fromJson({
  "private_key": "YOUR_PRIVATE_KEY",
  "client_email": "YOUR_CLIENT_EMAIL",
});

final _scopes = [calendar.CalendarApi.calendarScope];

void main() async {
  final client = await auth.clientViaServiceAccount(_credentials, _scopes);
  final calendarApi = calendar.CalendarApi(client);

  // List events from Google Calendar
  final events = await calendarApi.events.list('primary');
  print('Events: ${events.items?.map((event) => event.summary).join(', ')}');

  client.close();
}
```

---

### **6. Combining Properties**
Here’s an example combining multiple Google APIs:

#### Example:
```dart
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart' as auth;

final _credentials = auth.ServiceAccountCredentials.fromJson({
  "private_key": "YOUR_PRIVATE_KEY",
  "client_email": "YOUR_CLIENT_EMAIL",
});

final _scopes = [
  drive.DriveApi.driveScope,
  sheets.SheetsApi.spreadsheetsScope,
  calendar.CalendarApi.calendarScope,
];

void main() async {
  final client = await auth.clientViaServiceAccount(_credentials, _scopes);
  final driveApi = drive.DriveApi(client);
  final sheetsApi = sheets.SheetsApi(client);
  final calendarApi = calendar.CalendarApi(client);

  // List files in Google Drive
  final files = await driveApi.files.list();
  print('Files: ${files.files?.map((file) => file.name).join(', ')}');

  // Read data from a Google Sheet
  final spreadsheetId = 'YOUR_SPREADSHEET_ID';
  final range = 'Sheet1!A1:B2';
  final sheetResponse = await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
  print('Sheet Data: ${sheetResponse.values}');

  // List events from Google Calendar
  final events = await calendarApi.events.list('primary');
  print('Events: ${events.items?.map((event) => event.summary).join(', ')}');

  client.close();
}
```

---

### **Summary of Google APIs**
| API                   | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Google Drive**      | Interact with files and folders          | `drive.DriveApi(client).files.list()`     |
| **Google Sheets**     | Read/write data in spreadsheets          | `sheets.SheetsApi(client).spreadsheets.values.get()` |
| **Google Calendar**   | Manage events and calendars              | `calendar.CalendarApi(client).events.list()` |
| **Authentication**    | Authenticate using OAuth 2.0             | `auth.clientViaServiceAccount(...)`       |

---

### **Example: Full Usage**
Here’s a complete example of using multiple Google APIs in a Dart app:
```dart
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:googleapis/sheets/v4.dart' as sheets;
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart' as auth;

final _credentials = auth.ServiceAccountCredentials.fromJson({
  "private_key": "YOUR_PRIVATE_KEY",
  "client_email": "YOUR_CLIENT_EMAIL",
});

final _scopes = [
  drive.DriveApi.driveScope,
  sheets.SheetsApi.spreadsheetsScope,
  calendar.CalendarApi.calendarScope,
];

void main() async {
  final client = await auth.clientViaServiceAccount(_credentials, _scopes);
  final driveApi = drive.DriveApi(client);
  final sheetsApi = sheets.SheetsApi(client);
  final calendarApi = calendar.CalendarApi(client);

  // List files in Google Drive
  final files = await driveApi.files.list();
  print('Files: ${files.files?.map((file) => file.name).join(', ')}');

  // Read data from a Google Sheet
  final spreadsheetId = 'YOUR_SPREADSHEET_ID';
  final range = 'Sheet1!A1:B2';
  final sheetResponse = await sheetsApi.spreadsheets.values.get(spreadsheetId, range);
  print('Sheet Data: ${sheetResponse.values}');

  // List events from Google Calendar
  final events = await calendarApi.events.list('primary');
  print('Events: ${events.items?.map((event) => event.summary).join(', ')}');

  client.close();
}
```

---

## Web Sockets

Here’s a summary of the [Flutter documentation on **WebSockets**](https://docs.flutter.dev/cookbook/networking/web-sockets), using the same method with explanations and **code examples**:

---

### **Flutter WebSockets**
WebSockets provide a persistent, bidirectional communication channel between a client and a server. They are commonly used for real-time applications like chat apps, live updates, and gaming.

---

### **1. Basic Usage**
To use WebSockets in Flutter, you can use the `web_socket_channel` package.

#### Example:
1. Add the `web_socket_channel` package to your `pubspec.yaml`:
   ```yaml
   dependencies:
     web_socket_channel: ^2.2.0
   ```

2. Connect to a WebSocket server and send/receive messages:
   ```dart
   import 'package:flutter/material.dart';
   import 'package:web_socket_channel/web_socket_channel.dart';
   import 'package:web_socket_channel/io.dart';

   void main() {
     runApp(MyApp());
   }

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         home: WebSocketDemo(),
       );
     }
   }

   class WebSocketDemo extends StatefulWidget {
     @override
     _WebSocketDemoState createState() => _WebSocketDemoState();
   }

   class _WebSocketDemoState extends State<WebSocketDemo> {
     final _channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: Text('WebSocket Demo')),
         body: Column(
           children: [
             StreamBuilder(
               stream: _channel.stream,
               builder: (context, snapshot) {
                 if (snapshot.hasData) {
                   return Text('Received: ${snapshot.data}');
                 }
                 return Text('Waiting for messages...');
               },
             ),
             TextField(
               onSubmitted: (text) {
                 _channel.sink.add(text);
               },
               decoration: InputDecoration(labelText: 'Send a message'),
             ),
           ],
         ),
       );
     }

     @override
     void dispose() {
       _channel.sink.close();
       super.dispose();
     }
   }
   ```

---

### **2. Sending and Receiving Messages**
You can send messages using the `sink` and receive messages using the `stream`.

#### Example:
```dart
final _channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

// Send a message
_channel.sink.add('Hello, WebSocket!');

// Receive messages
_channel.stream.listen((message) {
  print('Received: $message');
});
```

---

### **3. Handling Errors**
You can handle errors by listening to the `stream`'s error events.

#### Example:
```dart
_channel.stream.listen(
  (message) {
    print('Received: $message');
  },
  onError: (error) {
    print('Error: $error');
  },
  onDone: () {
    print('Connection closed');
  },
);
```

---

### **4. Closing the Connection**
You can close the WebSocket connection using the `sink.close()` method.

#### Example:
```dart
@override
void dispose() {
  _channel.sink.close();
  super.dispose();
}
```

---

### **5. Combining Properties**
Here’s an example combining multiple properties:

#### Example:
```dart
class WebSocketDemo extends StatefulWidget {
  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final _channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebSocket Demo')),
      body: Column(
        children: [
          StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Received: ${snapshot.data}');
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Text('Waiting for messages...');
            },
          ),
          TextField(
            onSubmitted: (text) {
              _channel.sink.add(text);
            },
            decoration: InputDecoration(labelText: 'Send a message'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
```

---

### **Summary of WebSocket Properties**
| Property              | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| `IOWebSocketChannel.connect` | Connects to a WebSocket server   | `IOWebSocketChannel.connect('ws://...')`  |
| `sink.add`            | Sends a message                          | `_channel.sink.add('Hello')`              |
| `stream.listen`       | Listens for incoming messages            | `_channel.stream.listen((message) {...})` |
| `sink.close`          | Closes the WebSocket connection          | `_channel.sink.close()`                   |

---

### **Example: Full Usage**
Here’s a complete example of using WebSockets in a Flutter app:
```dart
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebSocketDemo(),
    );
  }
}

class WebSocketDemo extends StatefulWidget {
  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  final _channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebSocket Demo')),
      body: Column(
        children: [
          StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text('Received: ${snapshot.data}');
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Text('Waiting for messages...');
            },
          ),
          TextField(
            onSubmitted: (text) {
              _channel.sink.add(text);
            },
            decoration: InputDecoration(labelText: 'Send a message'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}
```

---

## GraphQL

Here’s a summary of the [GraphQL documentation](https://graphql.org/learn/), using the same method with explanations and **code examples**:

---

### **GraphQL: A Query Language for APIs**
GraphQL is a query language for APIs and a runtime for executing those queries by using a type system you define for your data. It provides a more efficient, powerful, and flexible alternative to REST.

---

### **1. Queries**
Queries are used to fetch data from a GraphQL API. They allow you to request specific fields on objects.

#### Example:
```graphql
query {
  user(id: 1) {
    name
    email
    posts {
      title
    }
  }
}
```

---

### **2. Mutations**
Mutations are used to modify data on the server (e.g., create, update, or delete records).

#### Example:
```graphql
mutation {
  createUser(name: "John Doe", email: "john@example.com") {
    id
    name
    email
  }
}
```

---

### **3. Types and Schemas**
GraphQL APIs are defined by a schema that specifies the types of data available and the relationships between them.

#### Example:
```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]
}

type Post {
  id: ID!
  title: String!
  content: String!
  author: User!
}

type Query {
  user(id: ID!): User
  posts: [Post!]
}

type Mutation {
  createUser(name: String!, email: String!): User
}
```

---

### **4. Resolvers**
Resolvers are functions that handle the logic for fetching or modifying data for a specific field in a query or mutation.

#### Example (JavaScript):
```javascript
const resolvers = {
  Query: {
    user: (parent, args, context, info) => {
      return users.find(user => user.id === args.id);
    },
  },
  Mutation: {
    createUser: (parent, args, context, info) => {
      const user = { id: users.length + 1, name: args.name, email: args.email };
      users.push(user);
      return user;
    },
  },
};
```

---

### **5. Variables**
Variables allow you to pass dynamic values into queries and mutations.

#### Example:
```graphql
query GetUser($id: ID!) {
  user(id: $id) {
    name
    email
  }
}
```

```json
{
  "id": 1
}
```

---

### **6. Fragments**
Fragments allow you to reuse common field selections across multiple queries.

#### Example:
```graphql
fragment UserDetails on User {
  name
  email
}

query {
  user(id: 1) {
    ...UserDetails
    posts {
      title
    }
  }
}
```

---

### **7. Directives**
Directives provide a way to dynamically change the structure and shape of queries using variables.

#### Example:
```graphql
query GetUser($id: ID!, $withPosts: Boolean!) {
  user(id: $id) {
    name
    email
    posts @include(if: $withPosts) {
      title
    }
  }
}
```

```json
{
  "id": 1,
  "withPosts": true
}
```

---

### **8. Subscriptions**
Subscriptions allow you to listen for real-time updates from the server.

#### Example:
```graphql
subscription {
  newPost {
    id
    title
    author {
      name
    }
  }
}
```

---

### **9. Combining Properties**
Here’s an example combining multiple GraphQL features:

#### Example:
```graphql
query GetUserWithPosts($id: ID!, $withPosts: Boolean!) {
  user(id: $id) {
    ...UserDetails
    posts @include(if: $withPosts) {
      title
    }
  }
}

fragment UserDetails on User {
  name
  email
}
```

```json
{
  "id": 1,
  "withPosts": true
}
```

---

### **Summary of GraphQL Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Queries**           | Fetch data from the server               | `query { user(id: 1) { name } }`          |
| **Mutations**         | Modify data on the server                | `mutation { createUser(name: "John") { id } }` |
| **Types and Schemas** | Define the structure of the API          | `type User { id: ID!, name: String! }`    |
| **Resolvers**         | Handle logic for fetching/modifying data | `resolvers.Query.user = (parent, args) => {...}` |
| **Variables**         | Pass dynamic values to queries/mutations | `query GetUser($id: ID!) { user(id: $id) { name } }` |
| **Fragments**         | Reuse common field selections            | `fragment UserDetails on User { name }`   |
| **Directives**        | Dynamically change query structure       | `posts @include(if: $withPosts)`          |
| **Subscriptions**     | Listen for real-time updates             | `subscription { newPost { title } }`      |

---

### **Example: Full Usage**
Here’s a complete example of a GraphQL schema, query, and resolver:

#### Schema:
```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]
}

type Post {
  id: ID!
  title: String!
  content: String!
  author: User!
}

type Query {
  user(id: ID!): User
  posts: [Post!]
}

type Mutation {
  createUser(name: String!, email: String!): User
}
```

#### Query:
```graphql
query GetUserWithPosts($id: ID!, $withPosts: Boolean!) {
  user(id: $id) {
    ...UserDetails
    posts @include(if: $withPosts) {
      title
    }
  }
}

fragment UserDetails on User {
  name
  email
}
```

#### Resolver (JavaScript):
```javascript
const users = [
  { id: 1, name: 'John Doe', email: 'john@example.com' },
];

const resolvers = {
  Query: {
    user: (parent, args, context, info) => {
      return users.find(user => user.id === args.id);
    },
  },
  Mutation: {
    createUser: (parent, args, context, info) => {
      const user = { id: users.length + 1, name: args.name, email: args.email };
      users.push(user);
      return user;
    },
  },
};
```

---

## GraphQL Schema 

Here’s a summary of the [GraphQL Schema documentation](https://graphql.org/learn/schema/), using the same method with explanations and **code examples**:

---

### **GraphQL Schema**
The GraphQL schema defines the structure of your API, including the types of data available and the relationships between them. It acts as a contract between the client and the server.

---

### **1. Types**
Types are the building blocks of a GraphQL schema. They define the shape of the data that can be queried.

#### Example:
```graphql
type User {
  id: ID!
  name: String!
  email: String!
}
```

---

### **2. Scalar Types**
GraphQL provides built-in scalar types like `ID`, `String`, `Int`, `Float`, and `Boolean`. You can also define custom scalar types.

#### Example:
```graphql
scalar Date

type Post {
  id: ID!
  title: String!
  content: String!
  publishedAt: Date!
}
```

---

### **3. Object Types**
Object types represent entities in your API. They consist of fields, each with a specific type.

#### Example:
```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]
}

type Post {
  id: ID!
  title: String!
  content: String!
  author: User!
}
```

---

### **4. Query Type**
The `Query` type defines the entry points for fetching data. It is the root type for all read operations.

#### Example:
```graphql
type Query {
  user(id: ID!): User
  posts: [Post!]
}
```

---

### **5. Mutation Type**
The `Mutation` type defines the entry points for modifying data. It is the root type for all write operations.

#### Example:
```graphql
type Mutation {
  createUser(name: String!, email: String!): User
  updateUser(id: ID!, name: String, email: String): User
  deleteUser(id: ID!): User
}
```

---

### **6. Input Types**
Input types are used to pass complex objects as arguments to queries or mutations.

#### Example:
```graphql
input UserInput {
  name: String!
  email: String!
}

type Mutation {
  createUser(input: UserInput!): User
}
```

---

### **7. Enum Types**
Enum types define a set of allowed values for a field.

#### Example:
```graphql
enum Role {
  ADMIN
  USER
  GUEST
}

type User {
  id: ID!
  name: String!
  email: String!
  role: Role!
}
```

---

### **8. Interfaces**
Interfaces define a set of fields that multiple types can implement. They are useful for polymorphism.

#### Example:
```graphql
interface Node {
  id: ID!
}

type User implements Node {
  id: ID!
  name: String!
  email: String!
}

type Post implements Node {
  id: ID!
  title: String!
  content: String!
}
```

---

### **9. Unions**
Unions allow a field to return one of several types.

#### Example:
```graphql
union SearchResult = User | Post

type Query {
  search(query: String!): [SearchResult!]
}
```

---

### **10. Directives**
Directives provide a way to dynamically change the structure and shape of queries using variables.

#### Example:
```graphql
directive @include(if: Boolean!) on FIELD | FRAGMENT_SPREAD | INLINE_FRAGMENT

type Query {
  user(id: ID!, withPosts: Boolean!): User @include(if: $withPosts)
}
```

---

### **11. Combining Properties**
Here’s an example combining multiple schema features:

#### Example:
```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]
}

type Post {
  id: ID!
  title: String!
  content: String!
  author: User!
}

type Query {
  user(id: ID!): User
  posts: [Post!]
}

type Mutation {
  createUser(input: UserInput!): User
}

input UserInput {
  name: String!
  email: String!
}

enum Role {
  ADMIN
  USER
  GUEST
}

interface Node {
  id: ID!
}

union SearchResult = User | Post

directive @include(if: Boolean!) on FIELD | FRAGMENT_SPREAD | INLINE_FRAGMENT
```

---

### **Summary of GraphQL Schema Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Types**             | Define the shape of data                 | `type User { id: ID!, name: String! }`    |
| **Scalar Types**      | Built-in or custom scalar types          | `scalar Date`                             |
| **Object Types**      | Represent entities in your API           | `type User { id: ID!, name: String! }`    |
| **Query Type**        | Entry points for fetching data           | `type Query { user(id: ID!): User }`      |
| **Mutation Type**     | Entry points for modifying data          | `type Mutation { createUser(name: String!): User }` |
| **Input Types**       | Pass complex objects as arguments        | `input UserInput { name: String! }`       |
| **Enum Types**        | Define a set of allowed values           | `enum Role { ADMIN, USER, GUEST }`        |
| **Interfaces**        | Define a set of fields for multiple types | `interface Node { id: ID! }`              |
| **Unions**            | Allow a field to return multiple types   | `union SearchResult = User | Post`        |
| **Directives**        | Dynamically change query structure       | `directive @include(if: Boolean!)`        |

---

### **Example: Full Usage**
Here’s a complete example of a GraphQL schema:

#### Schema:
```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]
}

type Post {
  id: ID!
  title: String!
  content: String!
  author: User!
}

type Query {
  user(id: ID!): User
  posts: [Post!]
}

type Mutation {
  createUser(input: UserInput!): User
}

input UserInput {
  name: String!
  email: String!
}

enum Role {
  ADMIN
  USER
  GUEST
}

interface Node {
  id: ID!
}

union SearchResult = User | Post

directive @include(if: Boolean!) on FIELD | FRAGMENT_SPREAD | INLINE_FRAGMENT
```

---

## GraphQL Queries 

Here’s a summary of the [GraphQL Queries documentation](https://graphql.org/learn/queries/), using the same method with explanations and **code examples**:

---

### **GraphQL Queries**
Queries are used to fetch data from a GraphQL API. They allow you to request specific fields on objects, making data retrieval efficient and flexible.

---

### **1. Basic Query**
A basic query requests specific fields from an object.

#### Example:
```graphql
query {
  user(id: 1) {
    name
    email
  }
}
```

---

### **2. Nested Queries**
You can request nested fields to fetch related data.

#### Example:
```graphql
query {
  user(id: 1) {
    name
    email
    posts {
      title
      content
    }
  }
}
```

---

### **3. Arguments**
You can pass arguments to fields to filter or customize the data returned.

#### Example:
```graphql
query {
  user(id: 1) {
    name
    email
    posts(limit: 5) {
      title
    }
  }
}
```

---

### **4. Aliases**
Aliases allow you to rename the result of a field to avoid conflicts or improve readability.

#### Example:
```graphql
query {
  firstUser: user(id: 1) {
    name
  }
  secondUser: user(id: 2) {
    name
  }
}
```

---

### **5. Fragments**
Fragments allow you to reuse common field selections across multiple queries.

#### Example:
```graphql
fragment UserDetails on User {
  name
  email
}

query {
  user(id: 1) {
    ...UserDetails
    posts {
      title
    }
  }
}
```

---

### **6. Variables**
Variables allow you to pass dynamic values into queries.

#### Example:
```graphql
query GetUser($id: ID!) {
  user(id: $id) {
    name
    email
  }
}
```

```json
{
  "id": 1
}
```

---

### **7. Directives**
Directives provide a way to dynamically change the structure and shape of queries using variables.

#### Example:
```graphql
query GetUser($id: ID!, $withPosts: Boolean!) {
  user(id: $id) {
    name
    email
    posts @include(if: $withPosts) {
      title
    }
  }
}
```

```json
{
  "id": 1,
  "withPosts": true
}
```

---

### **8. Inline Fragments**
Inline fragments allow you to conditionally include fields based on the type of an object.

#### Example:
```graphql
query {
  search(query: "John") {
    ... on User {
      name
      email
    }
    ... on Post {
      title
      content
    }
  }
}
```

---

### **9. Combining Properties**
Here’s an example combining multiple query features:

#### Example:
```graphql
query GetUserWithPosts($id: ID!, $withPosts: Boolean!) {
  user(id: $id) {
    ...UserDetails
    posts @include(if: $withPosts) {
      title
    }
  }
}

fragment UserDetails on User {
  name
  email
}
```

```json
{
  "id": 1,
  "withPosts": true
}
```

---

### **Summary of GraphQL Query Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Basic Query**       | Fetch specific fields                    | `query { user(id: 1) { name } }`          |
| **Nested Queries**    | Fetch related data                       | `user { posts { title } }`                |
| **Arguments**         | Pass arguments to fields                 | `user(id: 1) { name }`                    |
| **Aliases**           | Rename the result of a field             | `firstUser: user(id: 1) { name }`         |
| **Fragments**         | Reuse common field selections            | `fragment UserDetails on User { name }`   |
| **Variables**         | Pass dynamic values to queries           | `query GetUser($id: ID!) { user(id: $id) { name } }` |
| **Directives**        | Dynamically change query structure       | `posts @include(if: $withPosts)`          |
| **Inline Fragments**  | Conditionally include fields             | `... on User { name }`                    |

---

### **Example: Full Usage**
Here’s a complete example of a GraphQL query:

#### Query:
```graphql
query GetUserWithPosts($id: ID!, $withPosts: Boolean!) {
  user(id: $id) {
    ...UserDetails
    posts @include(if: $withPosts) {
      title
    }
  }
}

fragment UserDetails on User {
  name
  email
}
```

#### Variables:
```json
{
  "id": 1,
  "withPosts": true
}
```

#### Response:
```json
{
  "data": {
    "user": {
      "name": "John Doe",
      "email": "john@example.com",
      "posts": [
        {
          "title": "First Post"
        },
        {
          "title": "Second Post"
        }
      ]
    }
  }
}
```

---

## GraphQL Mutations

Here’s a summary of the [GraphQL Mutations documentation](https://graphql.org/learn/mutations/), using the same method with explanations and **code examples**:

---

### **GraphQL Mutations**
Mutations are used to modify data on the server, such as creating, updating, or deleting records. They are the write operations in GraphQL.

---

### **1. Basic Mutation**
A basic mutation performs a single operation to modify data.

#### Example:
```graphql
mutation {
  createUser(name: "John Doe", email: "john@example.com") {
    id
    name
    email
  }
}
```

---

### **2. Multiple Fields in a Mutation**
You can perform multiple operations in a single mutation.

#### Example:
```graphql
mutation {
  createUser(name: "John Doe", email: "john@example.com") {
    id
    name
    email
  }
  updateUser(id: 1, name: "Jane Doe") {
    id
    name
  }
}
```

---

### **3. Variables in Mutations**
Variables allow you to pass dynamic values into mutations.

#### Example:
```graphql
mutation CreateUser($name: String!, $email: String!) {
  createUser(name: $name, email: $email) {
    id
    name
    email
  }
}
```

```json
{
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **4. Input Types**
Input types allow you to pass complex objects as arguments to mutations.

#### Example:
```graphql
input UserInput {
  name: String!
  email: String!
}

mutation CreateUser($input: UserInput!) {
  createUser(input: $input) {
    id
    name
    email
  }
}
```

```json
{
  "input": {
    "name": "John Doe",
    "email": "john@example.com"
  }
}
```

---

### **5. Error Handling**
Mutations can return errors, which can be handled by the client.

#### Example:
```graphql
mutation {
  createUser(name: "John Doe", email: "john@example.com") {
    user {
      id
      name
      email
    }
    errors {
      field
      message
    }
  }
}
```

---

### **6. Combining Properties**
Here’s an example combining multiple mutation features:

#### Example:
```graphql
mutation CreateAndUpdateUser($createInput: UserInput!, $updateId: ID!, $updateName: String!) {
  createUser(input: $createInput) {
    id
    name
    email
  }
  updateUser(id: $updateId, name: $updateName) {
    id
    name
  }
}
```

```json
{
  "createInput": {
    "name": "John Doe",
    "email": "john@example.com"
  },
  "updateId": 1,
  "updateName": "Jane Doe"
}
```

---

### **Summary of GraphQL Mutation Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Basic Mutation**    | Perform a single write operation         | `mutation { createUser(name: "John") { id } }` |
| **Multiple Fields**   | Perform multiple operations in one mutation | `mutation { createUser(...), updateUser(...) }` |
| **Variables**         | Pass dynamic values to mutations         | `mutation CreateUser($name: String!) { createUser(name: $name) { id } }` |
| **Input Types**       | Pass complex objects as arguments        | `mutation CreateUser($input: UserInput!) { createUser(input: $input) { id } }` |
| **Error Handling**    | Handle errors returned by mutations      | `mutation { createUser(...) { user { id }, errors { message } } }` |

---

### **Example: Full Usage**
Here’s a complete example of a GraphQL mutation:

#### Schema:
```graphql
type User {
  id: ID!
  name: String!
  email: String!
}

type Mutation {
  createUser(input: UserInput!): User
  updateUser(id: ID!, name: String): User
}

input UserInput {
  name: String!
  email: String!
}
```

#### Mutation:
```graphql
mutation CreateAndUpdateUser($createInput: UserInput!, $updateId: ID!, $updateName: String!) {
  createUser(input: $createInput) {
    id
    name
    email
  }
  updateUser(id: $updateId, name: $updateName) {
    id
    name
  }
}
```

#### Variables:
```json
{
  "createInput": {
    "name": "John Doe",
    "email": "john@example.com"
  },
  "updateId": 1,
  "updateName": "Jane Doe"
}
```

#### Response:
```json
{
  "data": {
    "createUser": {
      "id": "2",
      "name": "John Doe",
      "email": "john@example.com"
    },
    "updateUser": {
      "id": "1",
      "name": "Jane Doe"
    }
  }
}
```

---

## GraphQL Subscriptions 

Here’s a summary of the [GraphQL Subscriptions documentation](https://graphql.org/learn/subscriptions/), using the same method with explanations and **code examples**:

---

### **GraphQL Subscriptions**
Subscriptions allow clients to receive real-time updates from the server. They are used for scenarios like live notifications, chat applications, or real-time data feeds.

---

### **1. Basic Subscription**
A basic subscription listens for real-time updates from the server.

#### Example:
```graphql
subscription {
  newPost {
    id
    title
    author {
      name
    }
  }
}
```

---

### **2. Subscriptions with Arguments**
You can pass arguments to subscriptions to filter the data received.

#### Example:
```graphql
subscription {
  newPost(authorId: 1) {
    id
    title
    author {
      name
    }
  }
}
```

---

### **3. Combining Subscriptions with Queries**
You can combine subscriptions with queries to fetch initial data and then receive updates.

#### Example:
```graphql
query GetPosts {
  posts {
    id
    title
    author {
      name
    }
  }
}

subscription NewPost {
  newPost {
    id
    title
    author {
      name
    }
  }
}
```

---

### **4. Handling Subscription Data**
Subscription data is typically handled using a WebSocket connection. Libraries like `graphql-ws` or `subscriptions-transport-ws` are commonly used.

#### Example (JavaScript with `graphql-ws`):
```javascript
import { createClient } from 'graphql-ws';

const client = createClient({
  url: 'ws://localhost:4000/graphql',
});

client.subscribe(
  {
    query: `
      subscription {
        newPost {
          id
          title
          author {
            name
          }
        }
      }
    `,
  },
  {
    next: (data) => {
      console.log('New post:', data);
    },
    error: (error) => {
      console.error('Subscription error:', error);
    },
    complete: () => {
      console.log('Subscription completed');
    },
  }
);
```

---

### **5. Error Handling**
You can handle errors in subscriptions by listening for error events.

#### Example:
```graphql
subscription {
  newPost {
    id
    title
    author {
      name
    }
    errors {
      message
    }
  }
}
```

---

### **6. Combining Properties**
Here’s an example combining multiple subscription features:

#### Example:
```graphql
subscription NewPost($authorId: ID!) {
  newPost(authorId: $authorId) {
    id
    title
    author {
      name
    }
    errors {
      message
    }
  }
}
```

```json
{
  "authorId": 1
}
```

---

### **Summary of GraphQL Subscription Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Basic Subscription**| Listen for real-time updates             | `subscription { newPost { id } }`         |
| **Arguments**         | Pass arguments to filter data            | `subscription { newPost(authorId: 1) { id } }` |
| **Combining with Queries** | Fetch initial data and receive updates | `query GetPosts { posts { id } }`         |
| **Handling Data**     | Use WebSocket libraries for real-time updates | `client.subscribe(...)`                  |
| **Error Handling**    | Handle errors in subscriptions           | `subscription { newPost { errors { message } } }` |

---

### **Example: Full Usage**
Here’s a complete example of a GraphQL subscription:

#### Schema:
```graphql
type Post {
  id: ID!
  title: String!
  author: User!
}

type User {
  id: ID!
  name: String!
}

type Subscription {
  newPost(authorId: ID): Post
}
```

#### Subscription:
```graphql
subscription NewPost($authorId: ID!) {
  newPost(authorId: $authorId) {
    id
    title
    author {
      name
    }
  }
}
```

#### Variables:
```json
{
  "authorId": 1
}
```

#### Response:
```json
{
  "data": {
    "newPost": {
      "id": "1",
      "title": "First Post",
      "author": {
        "name": "John Doe"
      }
    }
  }
}
```

---

## GraphQL Validation

Here’s a summary of the [GraphQL Validation documentation](https://graphql.org/learn/validation/), using the same method with explanations and **code examples**:

---

### **GraphQL Validation**
GraphQL validation ensures that queries and mutations are syntactically correct and adhere to the schema. The GraphQL server validates requests before executing them, providing clear error messages if the request is invalid.

---

### **1. Syntax Validation**
The server checks if the query is syntactically correct.

#### Example:
```graphql
query {
  user(id: 1) {
    name
    email
  }
}
```

If the query is malformed (e.g., missing a closing brace), the server will return an error:
```json
{
  "errors": [
    {
      "message": "Syntax Error: Expected Name, found <EOF>",
      "locations": [{ "line": 4, "column": 3 }]
    }
  ]
}
```

---

### **2. Schema Validation**
The server checks if the query adheres to the schema, including:
- Valid fields and types
- Correct argument types
- Required arguments

#### Example:
```graphql
query {
  user(id: 1) {
    name
    age
  }
}
```

If `age` is not a valid field in the `User` type, the server will return an error:
```json
{
  "errors": [
    {
      "message": "Cannot query field 'age' on type 'User'.",
      "locations": [{ "line": 4, "column": 5 }]
    }
  ]
}
```

---

### **3. Variable Validation**
The server validates variables used in queries and mutations to ensure they match the expected types.

#### Example:
```graphql
query GetUser($id: ID!) {
  user(id: $id) {
    name
  }
}
```

If the variable `$id` is not provided or is of the wrong type, the server will return an error:
```json
{
  "errors": [
    {
      "message": "Variable '$id' of required type 'ID!' was not provided.",
      "locations": [{ "line": 1, "column": 17 }]
    }
  ]
}
```

---

### **4. Fragment Validation**
The server validates fragments to ensure they are used correctly and refer to valid types.

#### Example:
```graphql
fragment UserDetails on User {
  name
  email
}

query {
  user(id: 1) {
    ...UserDetails
  }
}
```

If `UserDetails` is used on a type that doesn’t match `User`, the server will return an error:
```json
{
  "errors": [
    {
      "message": "Fragment 'UserDetails' cannot be spread here as objects of type 'Post' can never be of type 'User'.",
      "locations": [{ "line": 7, "column": 5 }]
    }
  ]
}
```

---

### **5. Directive Validation**
The server validates directives to ensure they are used correctly and refer to valid locations.

#### Example:
```graphql
query GetUser($id: ID!, $withPosts: Boolean!) {
  user(id: $id) {
    name
    posts @include(if: $withPosts) {
      title
    }
  }
}
```

If the `@include` directive is used incorrectly, the server will return an error:
```json
{
  "errors": [
    {
      "message": "Directive '@include' may not be used on FIELD_DEFINITION.",
      "locations": [{ "line": 4, "column": 12 }]
    }
  ]
}
```

---

### **6. Combining Validation Rules**
Here’s an example combining multiple validation rules:

#### Example:
```graphql
query GetUserWithPosts($id: ID!, $withPosts: Boolean!) {
  user(id: $id) {
    ...UserDetails
    posts @include(if: $withPosts) {
      title
    }
  }
}

fragment UserDetails on User {
  name
  email
}
```

If any of the validation rules are violated, the server will return an error:
```json
{
  "errors": [
    {
      "message": "Variable '$id' of required type 'ID!' was not provided.",
      "locations": [{ "line": 1, "column": 25 }]
    },
    {
      "message": "Fragment 'UserDetails' cannot be spread here as objects of type 'Post' can never be of type 'User'.",
      "locations": [{ "line": 3, "column": 5 }]
    }
  ]
}
```

---

### **Summary of GraphQL Validation Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Syntax Validation** | Ensures the query is syntactically correct | `query { user(id: 1) { name } }`          |
| **Schema Validation** | Ensures the query adheres to the schema  | `Cannot query field 'age' on type 'User'` |
| **Variable Validation** | Ensures variables match expected types | `Variable '$id' of required type 'ID!' was not provided` |
| **Fragment Validation** | Ensures fragments are used correctly   | `Fragment 'UserDetails' cannot be spread here` |
| **Directive Validation** | Ensures directives are used correctly | `Directive '@include' may not be used on FIELD_DEFINITION` |

---

### **Example: Full Usage**
Here’s a complete example of a GraphQL query with validation:

#### Schema:
```graphql
type User {
  id: ID!
  name: String!
  email: String!
  posts: [Post!]
}

type Post {
  id: ID!
  title: String!
  content: String!
  author: User!
}

type Query {
  user(id: ID!): User
  posts: [Post!]
}
```

#### Query:
```graphql
query GetUserWithPosts($id: ID!, $withPosts: Boolean!) {
  user(id: $id) {
    ...UserDetails
    posts @include(if: $withPosts) {
      title
    }
  }
}

fragment UserDetails on User {
  name
  email
}
```

#### Variables:
```json
{
  "id": 1,
  "withPosts": true
}
```

#### Response:
```json
{
  "data": {
    "user": {
      "name": "John Doe",
      "email": "john@example.com",
      "posts": [
        {
          "title": "First Post"
        },
        {
          "title": "Second Post"
        }
      ]
    }
  }
}
```

---

## GraphQL Execution

Here’s a summary of the [GraphQL Execution documentation](https://graphql.org/learn/execution/), using the same method with explanations and **code examples**:

---

### **GraphQL Execution**
Execution is the process of resolving a GraphQL query or mutation. It involves traversing the query, invoking resolvers, and returning the requested data.

---

### **1. Resolvers**
Resolvers are functions that handle the logic for fetching or modifying data for a specific field in a query or mutation.

#### Example:
```javascript
const resolvers = {
  Query: {
    user: (parent, args, context, info) => {
      return users.find(user => user.id === args.id);
    },
  },
  Mutation: {
    createUser: (parent, args, context, info) => {
      const user = { id: users.length + 1, name: args.name, email: args.email };
      users.push(user);
      return user;
    },
  },
};
```

---

### **2. Execution Process**
The execution process involves:
1. Parsing the query.
2. Validating the query against the schema.
3. Executing the query by invoking resolvers.

#### Example:
```graphql
query {
  user(id: 1) {
    name
    email
  }
}
```

The server will:
1. Parse the query.
2. Validate it against the schema.
3. Invoke the `user` resolver and then the `name` and `email` resolvers.

---

### **3. Resolver Arguments**
Resolvers receive four arguments:
- `parent`: The result of the parent resolver.
- `args`: The arguments provided in the query.
- `context`: A shared object for all resolvers (e.g., authentication info).
- `info`: Metadata about the query.

#### Example:
```javascript
const resolvers = {
  Query: {
    user: (parent, args, context, info) => {
      return users.find(user => user.id === args.id);
    },
  },
};
```

---

### **4. Default Resolvers**
If a field does not have a resolver, GraphQL uses a default resolver that looks for a property with the same name on the parent object.

#### Example:
```javascript
const user = {
  id: 1,
  name: 'John Doe',
  email: 'john@example.com',
};

const resolvers = {
  Query: {
    user: () => user,
  },
};
```

For the query:
```graphql
query {
  user {
    name
  }
}
```

The default resolver will return `user.name`.

---

### **5. Asynchronous Resolvers**
Resolvers can return promises for asynchronous operations like database queries or API calls.

#### Example:
```javascript
const resolvers = {
  Query: {
    user: async (parent, args, context, info) => {
      const user = await db.findUserById(args.id);
      return user;
    },
  },
};
```

---

### **6. Error Handling**
Resolvers can throw errors, which are returned in the response.

#### Example:
```javascript
const resolvers = {
  Query: {
    user: (parent, args, context, info) => {
      const user = users.find(user => user.id === args.id);
      if (!user) {
        throw new Error('User not found');
      }
      return user;
    },
  },
};
```

---

### **7. Combining Properties**
Here’s an example combining multiple execution features:

#### Example:
```javascript
const users = [
  { id: 1, name: 'John Doe', email: 'john@example.com' },
];

const resolvers = {
  Query: {
    user: async (parent, args, context, info) => {
      const user = users.find(user => user.id === args.id);
      if (!user) {
        throw new Error('User not found');
      }
      return user;
    },
  },
  Mutation: {
    createUser: (parent, args, context, info) => {
      const user = { id: users.length + 1, name: args.name, email: args.email };
      users.push(user);
      return user;
    },
  },
};
```

---

### **Summary of GraphQL Execution Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Resolvers**         | Functions that fetch or modify data      | `Query: { user: (parent, args) => {...} }` |
| **Execution Process** | Parsing, validation, and execution       | `query { user(id: 1) { name } }`          |
| **Resolver Arguments** | `parent`, `args`, `context`, `info`     | `user: (parent, args, context, info) => {...}` |
| **Default Resolvers** | Automatically resolve fields             | `user: () => ({ name: 'John' })`          |
| **Asynchronous Resolvers** | Handle async operations             | `user: async () => await db.findUser()`   |
| **Error Handling**    | Throw errors in resolvers                | `throw new Error('User not found')`       |

---

### **Example: Full Usage**
Here’s a complete example of GraphQL execution:

#### Schema:
```graphql
type User {
  id: ID!
  name: String!
  email: String!
}

type Query {
  user(id: ID!): User
}

type Mutation {
  createUser(name: String!, email: String!): User
}
```

#### Resolvers:
```javascript
const users = [
  { id: 1, name: 'John Doe', email: 'john@example.com' },
];

const resolvers = {
  Query: {
    user: async (parent, args, context, info) => {
      const user = users.find(user => user.id === args.id);
      if (!user) {
        throw new Error('User not found');
      }
      return user;
    },
  },
  Mutation: {
    createUser: (parent, args, context, info) => {
      const user = { id: users.length + 1, name: args.name, email: args.email };
      users.push(user);
      return user;
    },
  },
};
```

#### Query:
```graphql
query {
  user(id: 1) {
    name
    email
  }
}
```

#### Response:
```json
{
  "data": {
    "user": {
      "name": "John Doe",
      "email": "john@example.com"
    }
  }
}
```

---

## GraphQL Response 

Here’s a summary of the [GraphQL Response documentation](https://graphql.org/learn/response/), using the same method with explanations and **code examples**:

---

### **GraphQL Response**
The response to a GraphQL query or mutation is a JSON object that contains the requested data or error messages. It follows a specific structure to ensure consistency and clarity.

---

### **1. Basic Response Structure**
A GraphQL response typically contains a `data` field with the requested data and an optional `errors` field for any errors that occurred.

#### Example:
```graphql
query {
  user(id: 1) {
    name
    email
  }
}
```

#### Response:
```json
{
  "data": {
    "user": {
      "name": "John Doe",
      "email": "john@example.com"
    }
  }
}
```

---

### **2. Error Handling**
If an error occurs during execution, the response will include an `errors` field with details about the error.

#### Example:
```graphql
query {
  user(id: 999) {
    name
    email
  }
}
```

#### Response:
```json
{
  "errors": [
    {
      "message": "User not found",
      "locations": [{ "line": 2, "column": 3 }],
      "path": ["user"]
    }
  ],
  "data": {
    "user": null
  }
}
```

---

### **3. Partial Responses**
If a query partially succeeds, the response will include both `data` and `errors`.

#### Example:
```graphql
query {
  user(id: 1) {
    name
    invalidField
  }
}
```

#### Response:
```json
{
  "errors": [
    {
      "message": "Cannot query field 'invalidField' on type 'User'.",
      "locations": [{ "line": 4, "column": 5 }]
    }
  ],
  "data": {
    "user": {
      "name": "John Doe"
    }
  }
}
```

---

### **4. Error Format**
The `errors` field contains an array of error objects, each with:
- `message`: A description of the error.
- `locations`: The line and column in the query where the error occurred.
- `path`: The path to the field that caused the error.

#### Example:
```json
{
  "errors": [
    {
      "message": "User not found",
      "locations": [{ "line": 2, "column": 3 }],
      "path": ["user"]
    }
  ]
}
```

---

### **5. Extensions**
The response can include an `extensions` field for additional metadata or debugging information.

#### Example:
```json
{
  "data": {
    "user": {
      "name": "John Doe"
    }
  },
  "extensions": {
    "requestId": "12345",
    "debugInfo": {
      "executionTime": "50ms"
    }
  }
}
```

---

### **6. Combining Properties**
Here’s an example combining multiple response features:

#### Example:
```graphql
query {
  user(id: 1) {
    name
    invalidField
  }
}
```

#### Response:
```json
{
  "errors": [
    {
      "message": "Cannot query field 'invalidField' on type 'User'.",
      "locations": [{ "line": 4, "column": 5 }],
      "path": ["user", "invalidField"]
    }
  ],
  "data": {
    "user": {
      "name": "John Doe"
    }
  },
  "extensions": {
    "requestId": "12345"
  }
}
```

---

### **Summary of GraphQL Response Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Basic Response**    | Contains `data` with the requested data  | `{ "data": { "user": { "name": "John" } } }` |
| **Error Handling**    | Contains `errors` if an error occurs     | `{ "errors": [{ "message": "User not found" }] }` |
| **Partial Responses** | Includes both `data` and `errors`        | `{ "data": { "user": { "name": "John" } }, "errors": [...] }` |
| **Error Format**      | Detailed error information               | `{ "message": "...", "locations": [...], "path": [...] }` |
| **Extensions**        | Additional metadata or debugging info    | `{ "extensions": { "requestId": "12345" } }` |

---

### **Example: Full Usage**
Here’s a complete example of a GraphQL response:

#### Query:
```graphql
query {
  user(id: 1) {
    name
    email
  }
}
```

#### Response:
```json
{
  "data": {
    "user": {
      "name": "John Doe",
      "email": "john@example.com"
    }
  }
}
```

#### Query with Error:
```graphql
query {
  user(id: 999) {
    name
    email
  }
}
```

#### Response:
```json
{
  "errors": [
    {
      "message": "User not found",
      "locations": [{ "line": 2, "column": 3 }],
      "path": ["user"]
    }
  ],
  "data": {
    "user": null
  }
}
```

---

## GraphQL Introspection

Here’s a summary of the **[GraphQL Introspection documentation](https://graphql.org/learn/introspection/)** using the same method you provided, with explanations and **code examples**:

---

### **GraphQL Introspection**
Introspection is a powerful feature of GraphQL that allows clients to query the schema itself. This enables tools like GraphiQL and IDEs to provide autocomplete, type information, and documentation. Introspection is built into the GraphQL specification and is available on any compliant GraphQL server.

---

### **1. Basic Introspection Query**
Introspection queries allow you to retrieve information about the schema, such as types, fields, and directives.

#### Example:
```graphql
query {
  __schema {
    types {
      name
      kind
    }
  }
}
```

#### Response:
```json
{
  "data": {
    "__schema": {
      "types": [
        {
          "name": "Query",
          "kind": "OBJECT"
        },
        {
          "name": "User",
          "kind": "OBJECT"
        },
        {
          "name": "String",
          "kind": "SCALAR"
        }
      ]
    }
  }
}
```

---

### **2. Querying Specific Types**
You can query details about a specific type, including its fields, arguments, and return types.

#### Example:
```graphql
query {
  __type(name: "User") {
    name
    kind
    fields {
      name
      type {
        name
        kind
      }
    }
  }
}
```

#### Response:
```json
{
  "data": {
    "__type": {
      "name": "User",
      "kind": "OBJECT",
      "fields": [
        {
          "name": "id",
          "type": {
            "name": "ID",
            "kind": "SCALAR"
          }
        },
        {
          "name": "name",
          "type": {
            "name": "String",
            "kind": "SCALAR"
          }
        }
      ]
    }
  }
}
```

---

### **3. Introspection System Fields**
GraphQL provides special fields for introspection, such as `__schema`, `__type`, and `__typename`.

- `__schema`: Provides information about the entire schema.
- `__type(name: "TypeName")`: Provides details about a specific type.
- `__typename`: Returns the name of the current object type (useful in queries).

#### Example:
```graphql
query {
  user(id: 1) {
    __typename
    name
  }
}
```

#### Response:
```json
{
  "data": {
    "user": {
      "__typename": "User",
      "name": "John Doe"
    }
  }
}
```

---

### **4. Introspection Use Cases**
Introspection is commonly used for:
- **Schema Exploration**: Tools like GraphiQL use introspection to display the schema and its documentation.
- **Dynamic Queries**: Clients can build queries dynamically based on the schema.
- **Validation**: Ensuring that queries are valid against the schema.

---

### **5. Disabling Introspection**
For security reasons, introspection can be disabled in production environments to prevent exposing the schema to unauthorized users.

#### Example (Disabling Introspection in Apollo Server):
```javascript
const server = new ApolloServer({
  typeDefs,
  resolvers,
  introspection: false, // Disables introspection
});
```

---

### **6. Example: Full Introspection Query**
Here’s an example of a comprehensive introspection query:

#### Query:
```graphql
query {
  __schema {
    queryType {
      name
    }
    mutationType {
      name
    }
    types {
      name
      kind
      description
      fields {
        name
        type {
          name
          kind
        }
      }
    }
  }
}
```

#### Response:
```json
{
  "data": {
    "__schema": {
      "queryType": {
        "name": "Query"
      },
      "mutationType": {
        "name": "Mutation"
      },
      "types": [
        {
          "name": "Query",
          "kind": "OBJECT",
          "description": "Root query type",
          "fields": [
            {
              "name": "user",
              "type": {
                "name": "User",
                "kind": "OBJECT"
              }
            }
          ]
        },
        {
          "name": "User",
          "kind": "OBJECT",
          "description": "A user object",
          "fields": [
            {
              "name": "id",
              "type": {
                "name": "ID",
                "kind": "SCALAR"
              }
            },
            {
              "name": "name",
              "type": {
                "name": "String",
                "kind": "SCALAR"
              }
            }
          ]
        }
      ]
    }
  }
}
```

---

### **Summary of GraphQL Introspection Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Schema Exploration** | Query the entire schema structure        | `{ __schema { types { name kind } } }`   |
| **Type Details**      | Retrieve details about a specific type   | `{ __type(name: "User") { name fields { name type { name } } } }` |
| **System Fields**     | Special fields like `__typename`         | `{ user { __typename name } }`           |
| **Use Cases**         | Schema exploration, dynamic queries, etc. | Tools like GraphiQL use introspection    |
| **Disabling Introspection** | Disable introspection for security   | `introspection: false` in Apollo Server  |

---

### **Example: Full Usage**
Here’s a complete example of using introspection to explore a schema:

#### Query:
```graphql
query {
  __schema {
    types {
      name
      kind
      description
    }
  }
}
```

#### Response:
```json
{
  "data": {
    "__schema": {
      "types": [
        {
          "name": "Query",
          "kind": "OBJECT",
          "description": "Root query type"
        },
        {
          "name": "User",
          "kind": "OBJECT",
          "description": "A user object"
        },
        {
          "name": "String",
          "kind": "SCALAR",
          "description": "The `String` scalar type represents textual data."
        }
      ]
    }
  }
}
```

---

## RESTful API Introduction

Here’s a summary of the **[What is REST?](https://restapitutorial.com/introduction/whatisrest)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **What is REST?**
REST (Representational State Transfer) is an architectural style for designing networked applications. It relies on a stateless, client-server communication protocol, typically HTTP. RESTful systems are characterized by their simplicity, scalability, and performance.

---

### **1. Key Principles of REST**
REST is based on six guiding principles:

#### **1.1. Client-Server Architecture**
- Separation of concerns between the client and server.
- The client handles the user interface, while the server manages data storage and business logic.

#### **1.2. Statelessness**
- Each request from the client to the server must contain all the information needed to understand and process the request.
- The server does not store any client context between requests.

#### **1.3. Cacheability**
- Responses from the server can be cached by the client to improve performance.
- Cacheable responses must explicitly indicate whether they can be cached.

#### **1.4. Uniform Interface**
- A consistent and standardized way of interacting with the server.
- Includes:
  - Resource identification in requests (e.g., URIs).
  - Resource manipulation through representations (e.g., JSON or XML).
  - Self-descriptive messages (e.g., HTTP methods like GET, POST).
  - Hypermedia as the engine of application state (HATEOAS).

#### **1.5. Layered System**
- The architecture can be composed of multiple layers, such as proxies or gateways.
- Each layer only interacts with the adjacent layers, improving scalability and flexibility.

#### **1.6. Code on Demand (Optional)**
- Servers can temporarily extend or customize client functionality by transferring executable code (e.g., JavaScript).

---

### **2. RESTful Resources**
In REST, everything is a **resource**, which can be accessed via a unique URI (Uniform Resource Identifier).

#### Example:
- A resource representing a user:
  ```
  https://api.example.com/users/1
  ```

---

### **3. HTTP Methods in REST**
RESTful APIs use standard HTTP methods to perform CRUD (Create, Read, Update, Delete) operations:

| HTTP Method | Description           | Example Use Case                     |
|-------------|-----------------------|--------------------------------------|
| **GET**     | Retrieve a resource   | Fetch details of a user              |
| **POST**    | Create a resource     | Add a new user                       |
| **PUT**     | Update a resource     | Modify an existing user              |
| **DELETE**  | Delete a resource     | Remove a user                        |
| **PATCH**   | Partially update a resource | Update specific fields of a user |

#### Example:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **4. RESTful Response Formats**
RESTful APIs typically use JSON or XML to represent resources.

#### Example (JSON):
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### Example (XML):
```xml
<user>
  <id>1</id>
  <name>John Doe</name>
  <email>john@example.com</email>
</user>
```

---

### **5. Status Codes**
RESTful APIs use HTTP status codes to indicate the result of a request.

| Status Code | Description                     | Example Use Case                     |
|-------------|---------------------------------|--------------------------------------|
| **200 OK**  | Request succeeded               | Successfully retrieved a resource    |
| **201 Created** | Resource created successfully | Successfully added a new user        |
| **400 Bad Request** | Invalid request           | Missing required fields in the request |
| **404 Not Found** | Resource not found         | Requested user does not exist        |
| **500 Internal Server Error** | Server error       | Server failed to process the request |

#### Example:
```http
HTTP/1.1 404 Not Found
Content-Type: application/json

{
  "error": "User not found"
}
```

---

### **6. Example: RESTful API Interaction**
Here’s an example of interacting with a RESTful API:

#### **Step 1: Retrieve a User**
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### **Step 2: Create a New User**
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### **Step 3: Update a User**
```http
PUT /users/2 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Smith",
  "email": "jane.smith@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Smith",
  "email": "jane.smith@example.com"
}
```

#### **Step 4: Delete a User**
```http
DELETE /users/2 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

---

### **Summary of REST Features**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Client-Server**     | Separation of concerns                   | Client handles UI, server handles data    |
| **Statelessness**     | Each request contains all necessary info | No session state stored on the server     |
| **Cacheability**      | Responses can be cached                  | `Cache-Control: max-age=3600`             |
| **Uniform Interface** | Consistent interaction with resources    | Use of URIs and HTTP methods              |
| **Layered System**    | Architecture can include multiple layers | Proxies, gateways, etc.                   |
| **Code on Demand**    | Optional executable code transfer        | JavaScript sent to the client             |

---

### **Example: Full RESTful API Workflow**
Here’s a complete example of interacting with a RESTful API:

#### **Step 1: Retrieve All Users**
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com"
  }
]
```

#### **Step 2: Create a New User**
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### **Step 3: Update a User**
```http
PUT /users/2 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Smith",
  "email": "jane.smith@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Smith",
  "email": "jane.smith@example.com"
}
```

#### **Step 4: Delete a User**
```http
DELETE /users/2 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

---

## Rest Constraints

Here’s a summary of the **[REST Constraints](https://restapitutorial.com/introduction/restconstraints)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **REST Constraints**
REST (Representational State Transfer) is defined by a set of **architectural constraints** that must be followed for an API to be considered RESTful. These constraints ensure that the system is scalable, performant, and easy to maintain.

---

### **1. Client-Server Architecture**
- **Description**: The client and server are separate entities that communicate over a network. The client handles the user interface, while the server manages data storage and business logic.
- **Benefits**:
  - Improves portability across multiple platforms.
  - Simplifies server components by separating concerns.
- **Example**:
  - A web browser (client) interacts with a backend server to fetch and display data.

---

### **2. Statelessness**
- **Description**: Each request from the client to the server must contain all the information needed to understand and process the request. The server does not store any client context between requests.
- **Benefits**:
  - Improves scalability, as the server does not need to maintain session state.
  - Simplifies server implementation.
- **Example**:
  - A client includes an authentication token in every request to identify the user.

#### Request:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
Authorization: Bearer <token>
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **3. Cacheability**
- **Description**: Responses from the server can be marked as cacheable or non-cacheable. Caching improves performance by reducing the need for repeated requests.
- **Benefits**:
  - Reduces server load and improves client performance.
  - Minimizes latency for repeated requests.
- **Example**:
  - A server includes a `Cache-Control` header to indicate how long a response can be cached.

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: max-age=3600

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **4. Uniform Interface**
- **Description**: A consistent and standardized way of interacting with the server. This constraint includes four sub-constraints:
  - **Resource Identification in Requests**: Resources are identified using URIs (e.g., `/users/1`).
  - **Resource Manipulation Through Representations**: Clients interact with resources using representations (e.g., JSON or XML).
  - **Self-Descriptive Messages**: Each message includes enough information to describe how to process it (e.g., HTTP methods like GET, POST).
  - **Hypermedia as the Engine of Application State (HATEOAS)**: Responses include links to related resources, allowing clients to navigate the API dynamically.

#### Example (HATEOAS):
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "_links": {
    "self": { "href": "/users/1" },
    "posts": { "href": "/users/1/posts" }
  }
}
```

---

### **5. Layered System**
- **Description**: The architecture can be composed of multiple layers, such as proxies, gateways, or load balancers. Each layer only interacts with the adjacent layers.
- **Benefits**:
  - Improves scalability by enabling load balancing and shared caching.
  - Enhances security by adding intermediary layers.
- **Example**:
  - A client sends a request to a load balancer, which forwards it to the appropriate server.

---

### **6. Code on Demand (Optional)**
- **Description**: Servers can temporarily extend or customize client functionality by transferring executable code (e.g., JavaScript).
- **Benefits**:
  - Reduces the need for pre-implemented features on the client.
  - Allows for dynamic updates to client behavior.
- **Example**:
  - A server sends JavaScript code to the client to render a dynamic UI component.

---

### **Summary of REST Constraints**
| Constraint               | Description                              | Example                                   |
|--------------------------|------------------------------------------|-------------------------------------------|
| **Client-Server**        | Separation of concerns                   | Client handles UI, server handles data    |
| **Statelessness**        | Each request contains all necessary info | Authentication token in every request    |
| **Cacheability**         | Responses can be cached                  | `Cache-Control: max-age=3600`             |
| **Uniform Interface**    | Consistent interaction with resources    | Use of URIs, HTTP methods, and HATEOAS   |
| **Layered System**       | Architecture can include multiple layers | Proxies, gateways, load balancers        |
| **Code on Demand**       | Optional executable code transfer        | JavaScript sent to the client            |

---

### **Example: RESTful API with Constraints**
Here’s an example of a RESTful API that adheres to all constraints:

#### **Step 1: Retrieve a User**
```http
GET /users/1 HTTP/1.1
Host: api.example.com
Authorization: Bearer <token>
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: max-age=3600

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "_links": {
    "self": { "href": "/users/1" },
    "posts": { "href": "/users/1/posts" }
  }
}
```

#### **Step 2: Create a New User**
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com",
  "_links": {
    "self": { "href": "/users/2" }
  }
}
```

#### **Step 3: Update a User**
```http
PUT /users/2 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Smith",
  "email": "jane.smith@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Smith",
  "email": "jane.smith@example.com",
  "_links": {
    "self": { "href": "/users/2" }
  }
}
```

#### **Step 4: Delete a User**
```http
DELETE /users/2 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

---

## REST Tips

Here’s a summary of the **[REST Quick Tips](https://restapitutorial.com/introduction/restquicktips)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **REST Quick Tips**
These tips provide practical guidance for designing and implementing RESTful APIs. They help ensure your API is consistent, scalable, and easy to use.

---

### **1. Use Nouns for Resource Names**
- **Description**: Resource names should be nouns (not verbs) and represent entities or collections.
- **Example**:
  - Use `/users` instead of `/getUsers`.
  - Use `/orders` instead of `/createOrder`.

#### Correct:
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Incorrect:
```http
GET /getUsers HTTP/1.1
Host: api.example.com
```

---

### **2. Use HTTP Methods Correctly**
- **Description**: Use the appropriate HTTP method for each operation:
  - **GET**: Retrieve a resource.
  - **POST**: Create a resource.
  - **PUT**: Update or replace a resource.
  - **DELETE**: Delete a resource.
  - **PATCH**: Partially update a resource.

#### Example:
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **3. Use Plural Nouns for Collections**
- **Description**: Use plural nouns for collections to maintain consistency.
- **Example**:
  - Use `/users` instead of `/user`.
  - Use `/orders` instead of `/order`.

#### Correct:
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Incorrect:
```http
GET /user HTTP/1.1
Host: api.example.com
```

---

### **4. Use HTTP Status Codes**
- **Description**: Use standard HTTP status codes to indicate the result of a request.
- **Common Status Codes**:
  - **200 OK**: Request succeeded.
  - **201 Created**: Resource created successfully.
  - **400 Bad Request**: Invalid request.
  - **404 Not Found**: Resource not found.
  - **500 Internal Server Error**: Server error.

#### Example:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **5. Use Consistent Naming Conventions**
- **Description**: Use consistent naming conventions for resources, fields, and endpoints. For example:
  - Use lowercase letters and hyphens (`-`) for URIs.
  - Use camelCase or snake_case for field names.

#### Example:
```http
GET /user-profiles HTTP/1.1
Host: api.example.com
```

#### Response:
```json
{
  "userId": 1,
  "fullName": "John Doe",
  "emailAddress": "john@example.com"
}
```

---

### **6. Version Your API**
- **Description**: Include a version number in your API to avoid breaking changes for existing clients.
- **Example**:
  - Use `/v1/users` instead of `/users`.

#### Example:
```http
GET /v1/users HTTP/1.1
Host: api.example.com
```

---

### **7. Use Pagination for Large Data Sets**
- **Description**: For endpoints that return large data sets, use pagination to limit the number of results returned in a single request.
- **Example**:
  - Use query parameters like `page` and `limit`.

#### Example:
```http
GET /users?page=2&limit=10 HTTP/1.1
Host: api.example.com
```

#### Response:
```json
{
  "page": 2,
  "limit": 10,
  "total": 100,
  "users": [
    { "id": 11, "name": "User 11" },
    { "id": 12, "name": "User 12" }
  ]
}
```

---

### **8. Use Filtering, Sorting, and Searching**
- **Description**: Allow clients to filter, sort, and search resources using query parameters.
- **Example**:
  - Use `/users?name=John&sort=name&order=asc`.

#### Example:
```http
GET /users?name=John&sort=name&order=asc HTTP/1.1
Host: api.example.com
```

#### Response:
```json
[
  { "id": 1, "name": "John Doe" },
  { "id": 2, "name": "John Smith" }
]
```

---

### **9. Use HATEOAS (Hypermedia as the Engine of Application State)**
- **Description**: Include links to related resources in responses to guide clients through the API.
- **Example**:
  - Add `_links` to responses.

#### Example:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "_links": {
    "self": { "href": "/users/1" },
    "posts": { "href": "/users/1/posts" }
  }
}
```

---

### **10. Provide Clear Documentation**
- **Description**: Document your API thoroughly, including:
  - Endpoints and their purposes.
  - Request and response formats.
  - Authentication methods.
  - Error handling.
- **Tools**:
  - Use tools like Swagger/OpenAPI or Postman to generate documentation.

---

### **Summary of REST Quick Tips**
| Tip                       | Description                              | Example                                   |
|---------------------------|------------------------------------------|-------------------------------------------|
| **Use Nouns for Resources** | Resource names should be nouns          | `/users` instead of `/getUsers`          |
| **Use HTTP Methods Correctly** | Use appropriate HTTP methods          | `POST /users` to create a user           |
| **Use Plural Nouns**       | Use plural nouns for collections        | `/users` instead of `/user`              |
| **Use HTTP Status Codes**  | Use standard status codes               | `200 OK`, `404 Not Found`                |
| **Consistent Naming**      | Use consistent naming conventions       | `user-profiles`, `camelCase` fields      |
| **Version Your API**       | Include a version number                | `/v1/users`                              |
| **Use Pagination**         | Paginate large data sets                | `/users?page=2&limit=10`                 |
| **Filtering and Sorting**  | Allow filtering, sorting, and searching | `/users?name=John&sort=name`             |
| **Use HATEOAS**            | Include links to related resources      | `_links: { "self": "/users/1" }`         |
| **Provide Documentation**  | Document your API thoroughly            | Use Swagger/OpenAPI                      |

---

### **Example: RESTful API with Quick Tips**
Here’s an example of a RESTful API that follows these tips:

#### **Step 1: Retrieve a Paginated List of Users**
```http
GET /v1/users?page=1&limit=5 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "page": 1,
  "limit": 5,
  "total": 100,
  "users": [
    { "id": 1, "name": "John Doe" },
    { "id": 2, "name": "Jane Smith" }
  ],
  "_links": {
    "self": { "href": "/v1/users?page=1&limit=5" },
    "next": { "href": "/v1/users?page=2&limit=5" }
  }
}
```

#### **Step 2: Create a New User**
```http
POST /v1/users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Alice Brown",
  "email": "alice@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 3,
  "name": "Alice Brown",
  "email": "alice@example.com",
  "_links": {
    "self": { "href": "/v1/users/3" }
  }
}
```

#### **Step 3: Update a User**
```http
PUT /v1/users/3 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Alice Green",
  "email": "alice.green@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 3,
  "name": "Alice Green",
  "email": "alice.green@example.com",
  "_links": {
    "self": { "href": "/v1/users/3" }
  }
}
```

#### **Step 4: Delete a User**
```http
DELETE /v1/users/3 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

---

## HTTP Methods 

Here’s a summary of the **[HTTP Methods](https://restapitutorial.com/introduction/httpmethods)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **HTTP Methods in REST**
HTTP methods define the action to be performed on a resource. RESTful APIs use these methods to implement CRUD (Create, Read, Update, Delete) operations.

---

### **1. GET**
- **Description**: Retrieve a resource or a collection of resources.
- **Idempotent**: Yes (repeated requests have the same effect).
- **Safe**: Yes (does not modify the resource).
- **Example**:
  - Fetch details of a user.

#### Request:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **2. POST**
- **Description**: Create a new resource.
- **Idempotent**: No (repeated requests may create multiple resources).
- **Safe**: No (modifies the resource).
- **Example**:
  - Add a new user.

#### Request:
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

---

### **3. PUT**
- **Description**: Update or replace an existing resource. If the resource does not exist, it may create it.
- **Idempotent**: Yes (repeated requests have the same effect).
- **Safe**: No (modifies the resource).
- **Example**:
  - Update a user's details.

#### Request:
```http
PUT /users/2 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Smith",
  "email": "jane.smith@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Smith",
  "email": "jane.smith@example.com"
}
```

---

### **4. DELETE**
- **Description**: Delete a resource.
- **Idempotent**: Yes (repeated requests have the same effect).
- **Safe**: No (modifies the resource).
- **Example**:
  - Remove a user.

#### Request:
```http
DELETE /users/2 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

---

### **5. PATCH**
- **Description**: Partially update an existing resource.
- **Idempotent**: No (repeated requests may have different effects).
- **Safe**: No (modifies the resource).
- **Example**:
  - Update a user's email.

#### Request:
```http
PATCH /users/1 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "email": "john.new@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

---

### **6. HEAD**
- **Description**: Retrieve the headers of a resource without the body. Useful for checking resource metadata.
- **Idempotent**: Yes.
- **Safe**: Yes.
- **Example**:
  - Check if a user exists.

#### Request:
```http
HEAD /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 123
```

---

### **7. OPTIONS**
- **Description**: Retrieve the supported HTTP methods for a resource.
- **Idempotent**: Yes.
- **Safe**: Yes.
- **Example**:
  - Check allowed methods for a resource.

#### Request:
```http
OPTIONS /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Allow: GET, PUT, DELETE, PATCH
```

---

### **Summary of HTTP Methods**
| Method   | Description                     | Idempotent | Safe | Example Use Case               |
|----------|---------------------------------|------------|------|--------------------------------|
| **GET**  | Retrieve a resource             | Yes        | Yes  | Fetch user details             |
| **POST** | Create a new resource           | No         | No   | Add a new user                 |
| **PUT**  | Update or replace a resource    | Yes        | No   | Update user details            |
| **DELETE** | Delete a resource             | Yes        | No   | Remove a user                  |
| **PATCH** | Partially update a resource   | No         | No   | Update user email              |
| **HEAD** | Retrieve resource headers       | Yes        | Yes  | Check if a user exists         |
| **OPTIONS** | Retrieve supported methods | Yes        | Yes  | Check allowed methods for a resource |

---

### **Example: Full RESTful API Workflow**
Here’s a complete example of using HTTP methods in a RESTful API:

#### **Step 1: Retrieve a User**
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### **Step 2: Create a New User**
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### **Step 3: Update a User**
```http
PUT /users/2 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Smith",
  "email": "jane.smith@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Smith",
  "email": "jane.smith@example.com"
}
```

#### **Step 4: Delete a User**
```http
DELETE /users/2 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

---

## Resouce Naming 

Here’s a summary of the **[Resource Naming](https://restapitutorial.com/introduction/resourcenaming)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **Resource Naming in REST**
Resource naming is a critical aspect of designing RESTful APIs. Proper naming conventions ensure that your API is intuitive, consistent, and easy to use.

---

### **1. Use Nouns for Resource Names**
- **Description**: Resource names should be nouns (not verbs) and represent entities or collections.
- **Example**:
  - Use `/users` instead of `/getUsers`.
  - Use `/orders` instead of `/createOrder`.

#### Correct:
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Incorrect:
```http
GET /getUsers HTTP/1.1
Host: api.example.com
```

---

### **2. Use Plural Nouns for Collections**
- **Description**: Use plural nouns for collections to maintain consistency.
- **Example**:
  - Use `/users` instead of `/user`.
  - Use `/orders` instead of `/order`.

#### Correct:
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Incorrect:
```http
GET /user HTTP/1.1
Host: api.example.com
```

---

### **3. Use Consistent Naming Conventions**
- **Description**: Use consistent naming conventions for resources, fields, and endpoints. For example:
  - Use lowercase letters and hyphens (`-`) for URIs.
  - Use camelCase or snake_case for field names.

#### Example:
```http
GET /user-profiles HTTP/1.1
Host: api.example.com
```

#### Response:
```json
{
  "userId": 1,
  "fullName": "John Doe",
  "emailAddress": "john@example.com"
}
```

---

### **4. Use Hierarchical Relationships**
- **Description**: Use hierarchical relationships to represent nested resources.
- **Example**:
  - Use `/users/1/orders` to represent orders for a specific user.

#### Example:
```http
GET /users/1/orders HTTP/1.1
Host: api.example.com
```

#### Response:
```json
[
  {
    "id": 101,
    "product": "Laptop",
    "quantity": 1
  },
  {
    "id": 102,
    "product": "Mouse",
    "quantity": 2
  }
]
```

---

### **5. Avoid File Extensions**
- **Description**: Avoid using file extensions (e.g., `.json`, `.xml`) in URIs. Instead, use the `Accept` header to specify the response format.
- **Example**:
  - Use `/users` instead of `/users.json`.

#### Correct:
```http
GET /users HTTP/1.1
Host: api.example.com
Accept: application/json
```

#### Incorrect:
```http
GET /users.json HTTP/1.1
Host: api.example.com
```

---

### **6. Use Query Parameters for Filtering, Sorting, and Searching**
- **Description**: Use query parameters to filter, sort, and search resources.
- **Example**:
  - Use `/users?name=John&sort=name&order=asc`.

#### Example:
```http
GET /users?name=John&sort=name&order=asc HTTP/1.1
Host: api.example.com
```

#### Response:
```json
[
  { "id": 1, "name": "John Doe" },
  { "id": 2, "name": "John Smith" }
]
```

---

### **7. Use Hyphens for Readability**
- **Description**: Use hyphens (`-`) to improve readability in URIs.
- **Example**:
  - Use `/user-profiles` instead of `/userprofiles`.

#### Correct:
```http
GET /user-profiles HTTP/1.1
Host: api.example.com
```

#### Incorrect:
```http
GET /userprofiles HTTP/1.1
Host: api.example.com
```

---

### **8. Use Lowercase Letters**
- **Description**: Use lowercase letters in URIs to avoid confusion and ensure consistency.
- **Example**:
  - Use `/users` instead of `/Users`.

#### Correct:
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Incorrect:
```http
GET /Users HTTP/1.1
Host: api.example.com
```

---

### **Summary of Resource Naming Best Practices**
| Best Practice               | Description                              | Example                                   |
|-----------------------------|------------------------------------------|-------------------------------------------|
| **Use Nouns for Resources** | Resource names should be nouns           | `/users` instead of `/getUsers`          |
| **Use Plural Nouns**        | Use plural nouns for collections         | `/users` instead of `/user`              |
| **Consistent Naming**       | Use consistent naming conventions        | `user-profiles`, `camelCase` fields      |
| **Hierarchical Relationships** | Represent nested resources           | `/users/1/orders`                        |
| **Avoid File Extensions**   | Use `Accept` header for response format | `/users` instead of `/users.json`        |
| **Use Query Parameters**    | Filter, sort, and search resources      | `/users?name=John&sort=name`             |
| **Use Hyphens for Readability** | Improve readability in URIs         | `/user-profiles` instead of `/userprofiles` |
| **Use Lowercase Letters**   | Ensure consistency in URIs              | `/users` instead of `/Users`             |

---

### **Example: RESTful API with Resource Naming Best Practices**
Here’s an example of a RESTful API that follows these best practices:

#### **Step 1: Retrieve a List of Users**
```http
GET /users HTTP/1.1
Host: api.example.com
Accept: application/json
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

[
  { "id": 1, "name": "John Doe" },
  { "id": 2, "name": "Jane Smith" }
]
```

#### **Step 2: Retrieve Orders for a Specific User**
```http
GET /users/1/orders HTTP/1.1
Host: api.example.com
Accept: application/json
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

[
  {
    "id": 101,
    "product": "Laptop",
    "quantity": 1
  },
  {
    "id": 102,
    "product": "Mouse",
    "quantity": 2
  }
]
```

#### **Step 3: Filter Users by Name**
```http
GET /users?name=John HTTP/1.1
Host: api.example.com
Accept: application/json
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

[
  { "id": 1, "name": "John Doe" }
]
```

---

## Idempotence 

Here’s a summary of the **[Idempotence](https://restapitutorial.com/introduction/idempotence)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **Idempotence in REST**
Idempotence is a property of certain operations in RESTful APIs where multiple identical requests have the same effect as a single request. This concept is crucial for ensuring reliability and predictability in API interactions.

---

### **1. What is Idempotence?**
- **Definition**: An operation is idempotent if performing it multiple times produces the same result as performing it once.
- **Importance**: Idempotence ensures that retrying a request (e.g., due to network issues) does not cause unintended side effects.

---

### **2. Idempotent HTTP Methods**
Some HTTP methods are inherently idempotent, while others are not.

#### **Idempotent Methods**:
| Method   | Description                     | Example                                   |
|----------|---------------------------------|-------------------------------------------|
| **GET**  | Retrieve a resource             | Fetching user details                    |
| **PUT**  | Update or replace a resource    | Updating user details                    |
| **DELETE** | Delete a resource             | Removing a user                          |

#### **Non-Idempotent Methods**:
| Method   | Description                     | Example                                   |
|----------|---------------------------------|-------------------------------------------|
| **POST** | Create a new resource           | Adding a new user                        |
| **PATCH** | Partially update a resource   | Updating a user's email                  |

---

### **3. Examples of Idempotent Operations**

#### **GET Request**
- **Description**: Retrieving a resource is idempotent because multiple requests return the same data.
- **Example**:
  - Fetching a user's details.

#### Request:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### **PUT Request**
- **Description**: Updating a resource is idempotent because multiple updates with the same data produce the same result.
- **Example**:
  - Updating a user's details.

#### Request:
```http
PUT /users/1 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

#### **DELETE Request**
- **Description**: Deleting a resource is idempotent because deleting an already deleted resource has no effect.
- **Example**:
  - Removing a user.

#### Request:
```http
DELETE /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

---

### **4. Examples of Non-Idempotent Operations**

#### **POST Request**
- **Description**: Creating a resource is not idempotent because multiple requests create multiple resources.
- **Example**:
  - Adding a new user.

#### Request:
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### **PATCH Request**
- **Description**: Partially updating a resource is not idempotent because multiple updates may have different effects.
- **Example**:
  - Updating a user's email.

#### Request:
```http
PATCH /users/1 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "email": "john.new@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

---

### **5. Ensuring Idempotence in Non-Idempotent Operations**
- **Description**: You can make non-idempotent operations idempotent by using unique identifiers or tokens.
- **Example**:
  - Use an `idempotency-key` header to ensure that a POST request is only processed once.

#### Request:
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json
Idempotency-Key: abc123

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

---

### **Summary of Idempotence**
| Method   | Idempotent | Description                     | Example                                   |
|----------|------------|---------------------------------|-------------------------------------------|
| **GET**  | Yes        | Retrieve a resource             | Fetching user details                    |
| **PUT**  | Yes        | Update or replace a resource    | Updating user details                    |
| **DELETE** | Yes      | Delete a resource               | Removing a user                          |
| **POST** | No         | Create a new resource           | Adding a new user                        |
| **PATCH** | No       | Partially update a resource     | Updating a user's email                  |

---

### **Example: Full RESTful API Workflow**
Here’s an example of a RESTful API that demonstrates idempotent and non-idempotent operations:

#### **Step 1: Retrieve a User**
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### **Step 2: Update a User**
```http
PUT /users/1 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

#### **Step 3: Delete a User**
```http
DELETE /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

#### **Step 4: Create a New User**
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

---

## Safety

Here’s a summary of the **[Safety](https://restapitutorial.com/introduction/safety)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **Safety in REST**
Safety is a property of certain HTTP methods in RESTful APIs. A **safe** method is one that does not modify the resource on the server. Safe methods are read-only and can be used without risking unintended side effects.

---

### **1. What is a Safe Method?**
- **Definition**: A safe HTTP method does not modify the resource on the server. It is used only for retrieving data.
- **Importance**: Safe methods are idempotent (repeated requests have the same effect) and can be used without worrying about changing the state of the resource.

---

### **2. Safe HTTP Methods**
The following HTTP methods are considered safe:

| Method   | Description                     | Example                                   |
|----------|---------------------------------|-------------------------------------------|
| **GET**  | Retrieve a resource             | Fetching user details                    |
| **HEAD** | Retrieve resource headers       | Checking if a user exists                |
| **OPTIONS** | Retrieve supported methods | Checking allowed methods for a resource  |

---

### **3. Examples of Safe Operations**

#### **GET Request**
- **Description**: Retrieving a resource is safe because it does not modify the resource.
- **Example**:
  - Fetching a user's details.

#### Request:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### **HEAD Request**
- **Description**: Retrieving resource headers is safe because it does not modify the resource.
- **Example**:
  - Checking if a user exists.

#### Request:
```http
HEAD /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 123
```

#### **OPTIONS Request**
- **Description**: Retrieving supported methods is safe because it does not modify the resource.
- **Example**:
  - Checking allowed methods for a resource.

#### Request:
```http
OPTIONS /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Allow: GET, PUT, DELETE, PATCH
```

---

### **4. Non-Safe HTTP Methods**
The following HTTP methods are **not** safe because they modify the resource on the server:

| Method   | Description                     | Example                                   |
|----------|---------------------------------|-------------------------------------------|
| **POST** | Create a new resource           | Adding a new user                        |
| **PUT**  | Update or replace a resource    | Updating user details                    |
| **DELETE** | Delete a resource             | Removing a user                          |
| **PATCH** | Partially update a resource   | Updating a user's email                  |

---

### **5. Examples of Non-Safe Operations**

#### **POST Request**
- **Description**: Creating a resource is not safe because it modifies the resource.
- **Example**:
  - Adding a new user.

#### Request:
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### **PUT Request**
- **Description**: Updating a resource is not safe because it modifies the resource.
- **Example**:
  - Updating a user's details.

#### Request:
```http
PUT /users/1 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

#### **DELETE Request**
- **Description**: Deleting a resource is not safe because it modifies the resource.
- **Example**:
  - Removing a user.

#### Request:
```http
DELETE /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

#### **PATCH Request**
- **Description**: Partially updating a resource is not safe because it modifies the resource.
- **Example**:
  - Updating a user's email.

#### Request:
```http
PATCH /users/1 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "email": "john.new@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

---

### **Summary of Safe and Non-Safe Methods**
| Method   | Safe  | Description                     | Example                                   |
|----------|-------|---------------------------------|-------------------------------------------|
| **GET**  | Yes   | Retrieve a resource             | Fetching user details                    |
| **HEAD** | Yes   | Retrieve resource headers       | Checking if a user exists                |
| **OPTIONS** | Yes | Retrieve supported methods | Checking allowed methods for a resource  |
| **POST** | No    | Create a new resource           | Adding a new user                        |
| **PUT**  | No    | Update or replace a resource    | Updating user details                    |
| **DELETE** | No  | Delete a resource               | Removing a user                          |
| **PATCH** | No  | Partially update a resource     | Updating a user's email                  |

---

### **Example: Full RESTful API Workflow**
Here’s an example of a RESTful API that demonstrates safe and non-safe operations:

#### **Step 1: Retrieve a User**
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

#### **Step 2: Check if a User Exists**
```http
HEAD /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
Content-Length: 123
```

#### **Step 3: Create a New User**
```http
POST /users HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### Response:
```http
HTTP/1.1 201 Created
Content-Type: application/json

{
  "id": 2,
  "name": "Jane Doe",
  "email": "jane@example.com"
}
```

#### **Step 4: Update a User**
```http
PUT /users/1 HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john.new@example.com"
}
```

#### **Step 5: Delete a User**
```http
DELETE /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 204 No Content
```

---

## Advanced REST API Concepts

Here’s a summary of the **[Advanced REST API Concepts](https://restapitutorial.com/advanced)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **Advanced REST API Concepts**
This section covers advanced topics in REST API design and implementation, including caching, versioning, security, and more.

---

### **1. Caching**
- **Description**: Caching improves performance by storing responses and serving them for subsequent requests without reprocessing.
- **HTTP Headers**:
  - `Cache-Control`: Specifies caching directives (e.g., `max-age`, `no-cache`).
  - `ETag`: Provides a unique identifier for a resource version.
  - `Last-Modified`: Indicates when the resource was last modified.

#### Example:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: max-age=3600
ETag: "abc123"
Last-Modified: Wed, 01 Jan 2023 12:00:00 GMT

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **2. Versioning**
- **Description**: Versioning ensures backward compatibility when making changes to the API.
- **Common Approaches**:
  - **URI Versioning**: Include the version in the URI (e.g., `/v1/users`).
  - **Header Versioning**: Use a custom header (e.g., `Accept-Version: v1`).
  - **Query Parameter Versioning**: Include the version as a query parameter (e.g., `/users?version=1`).

#### Example (URI Versioning):
```http
GET /v1/users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **3. Security**
- **Description**: Secure your API to protect sensitive data and prevent unauthorized access.
- **Common Practices**:
  - **HTTPS**: Encrypt communication using TLS/SSL.
  - **Authentication**: Use mechanisms like API keys, OAuth, or JWT.
  - **Authorization**: Restrict access to resources based on user roles.
  - **Rate Limiting**: Prevent abuse by limiting the number of requests.

#### Example (JWT Authentication):
```http
POST /login HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "username": "john",
  "password": "password123"
}
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

#### Example (Authenticated Request):
```http
GET /users/1 HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **4. HATEOAS (Hypermedia as the Engine of Application State)**
- **Description**: HATEOAS allows clients to navigate the API dynamically by including links to related resources in responses.
- **Example**:
  - Include `_links` in responses.

#### Example:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "_links": {
    "self": { "href": "/users/1" },
    "posts": { "href": "/users/1/posts" }
  }
}
```

---

### **5. Rate Limiting**
- **Description**: Rate limiting prevents abuse by restricting the number of requests a client can make in a given time period.
- **HTTP Headers**:
  - `X-RateLimit-Limit`: Total number of requests allowed.
  - `X-RateLimit-Remaining`: Number of requests remaining.
  - `X-RateLimit-Reset`: Time when the rate limit resets.

#### Example:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1672531200

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com"
}
```

---

### **6. Pagination**
- **Description**: Pagination limits the number of results returned in a single response, improving performance for large data sets.
- **Common Approaches**:
  - **Offset-Based**: Use `offset` and `limit` parameters.
  - **Cursor-Based**: Use a `cursor` parameter to fetch the next set of results.

#### Example (Offset-Based Pagination):
```http
GET /users?offset=10&limit=5 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "offset": 10,
  "limit": 5,
  "total": 100,
  "users": [
    { "id": 11, "name": "User 11" },
    { "id": 12, "name": "User 12" }
  ]
}
```

---

### **7. Error Handling**
- **Description**: Provide meaningful error messages and status codes to help clients understand and resolve issues.
- **Example**:
  - Use standard HTTP status codes and include error details in the response body.

#### Example:
```http
GET /users/999 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 404 Not Found
Content-Type: application/json

{
  "error": "User not found",
  "message": "The requested user does not exist."
}
```

---

### **Summary of Advanced REST API Concepts**
| Concept               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Caching**           | Improve performance with caching         | `Cache-Control: max-age=3600`             |
| **Versioning**        | Ensure backward compatibility            | `/v1/users`                               |
| **Security**          | Protect sensitive data                   | JWT authentication                        |
| **HATEOAS**           | Enable dynamic navigation                | `_links: { "self": "/users/1" }`          |
| **Rate Limiting**     | Prevent abuse with rate limits           | `X-RateLimit-Limit: 1000`                 |
| **Pagination**        | Handle large data sets                   | `/users?offset=10&limit=5`                |
| **Error Handling**    | Provide meaningful error messages        | `404 Not Found` with error details        |

---

### **Example: Full RESTful API Workflow**
Here’s an example of a RESTful API that incorporates advanced concepts:

#### **Step 1: Retrieve a User**
```http
GET /v1/users/1 HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
Cache-Control: max-age=3600
ETag: "abc123"
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1672531200

{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "_links": {
    "self": { "href": "/v1/users/1" },
    "posts": { "href": "/v1/users/1/posts" }
  }
}
```

#### **Step 2: Retrieve a Paginated List of Users**
```http
GET /v1/users?offset=10&limit=5 HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "offset": 10,
  "limit": 5,
  "total": 100,
  "users": [
    { "id": 11, "name": "User 11" },
    { "id": 12, "name": "User 12" }
  ],
  "_links": {
    "self": { "href": "/v1/users?offset=10&limit=5" },
    "next": { "href": "/v1/users?offset=15&limit=5" }
  }
}
```

#### **Step 3: Handle an Error**
```http
GET /v1/users/999 HTTP/1.1
Host: api.example.com
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

#### Response:
```http
HTTP/1.1 404 Not Found
Content-Type: application/json

{
  "error": "User not found",
  "message": "The requested user does not exist."
}
```

---

## Advanced REST API Responses 

Here’s a summary of the **[Advanced REST API Responses](https://restapitutorial.com/advanced/responses)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **Advanced REST API Responses**
This section covers advanced techniques for designing and structuring REST API responses, including handling errors, pagination, and metadata.

---

### **1. Structured Responses**
- **Description**: Use a consistent structure for responses to make them predictable and easy to parse.
- **Common Fields**:
  - `data`: Contains the main response payload.
  - `metadata`: Includes additional information (e.g., pagination details).
  - `errors`: Provides details about any errors that occurred.

#### Example:
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": [
    { "id": 1, "name": "John Doe" },
    { "id": 2, "name": "Jane Smith" }
  ],
  "metadata": {
    "page": 1,
    "limit": 10,
    "total": 100
  }
}
```

---

### **2. Error Handling**
- **Description**: Provide meaningful error messages and status codes to help clients understand and resolve issues.
- **Common Fields**:
  - `error`: A brief description of the error.
  - `message`: A detailed explanation of the error.
  - `code`: A unique error code for reference.

#### Example:
```http
GET /users/999 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 404 Not Found
Content-Type: application/json

{
  "error": "User not found",
  "message": "The requested user does not exist.",
  "code": "USER_NOT_FOUND"
}
```

---

### **3. Pagination**
- **Description**: Pagination limits the number of results returned in a single response, improving performance for large data sets.
- **Common Fields**:
  - `offset`: The starting point of the results.
  - `limit`: The number of results returned.
  - `total`: The total number of results available.

#### Example:
```http
GET /users?offset=10&limit=5 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": [
    { "id": 11, "name": "User 11" },
    { "id": 12, "name": "User 12" }
  ],
  "metadata": {
    "offset": 10,
    "limit": 5,
    "total": 100
  }
}
```

---

### **4. Metadata**
- **Description**: Include metadata in responses to provide additional context or information.
- **Common Fields**:
  - `timestamp`: The time the response was generated.
  - `version`: The API version.
  - `links`: Hypermedia links for navigation (HATEOAS).

#### Example:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com"
  },
  "metadata": {
    "timestamp": "2023-01-01T12:00:00Z",
    "version": "v1",
    "links": {
      "self": { "href": "/users/1" },
      "posts": { "href": "/users/1/posts" }
    }
  }
}
```

---

### **5. HATEOAS (Hypermedia as the Engine of Application State)**
- **Description**: HATEOAS allows clients to navigate the API dynamically by including links to related resources in responses.
- **Example**:
  - Include `_links` in responses.

#### Example:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com"
  },
  "links": {
    "self": { "href": "/users/1" },
    "posts": { "href": "/users/1/posts" }
  }
}
```

---

### **6. Rate Limiting Information**
- **Description**: Include rate limiting information in responses to help clients manage their request usage.
- **Common Fields**:
  - `X-RateLimit-Limit`: Total number of requests allowed.
  - `X-RateLimit-Remaining`: Number of requests remaining.
  - `X-RateLimit-Reset`: Time when the rate limit resets.

#### Example:
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1672531200

{
  "data": [
    { "id": 1, "name": "John Doe" },
    { "id": 2, "name": "Jane Smith" }
  ]
}
```

---

### **7. Custom Headers**
- **Description**: Use custom headers to provide additional information or instructions to the client.
- **Example**:
  - `X-Request-ID`: A unique identifier for the request.
  - `X-Custom-Header`: A custom header for specific use cases.

#### Example:
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
X-Request-ID: abc123
X-Custom-Header: custom-value

{
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com"
  }
}
```

---

### **Summary of Advanced REST API Responses**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Structured Responses** | Use a consistent response structure  | `{ "data": [...], "metadata": {...} }`   |
| **Error Handling**    | Provide meaningful error messages        | `404 Not Found` with error details        |
| **Pagination**        | Handle large data sets                   | `/users?offset=10&limit=5`                |
| **Metadata**          | Include additional context               | `timestamp`, `version`, `links`           |
| **HATEOAS**           | Enable dynamic navigation                | `_links: { "self": "/users/1" }`          |
| **Rate Limiting**     | Include rate limiting information        | `X-RateLimit-Limit: 1000`                 |
| **Custom Headers**    | Provide additional information           | `X-Request-ID: abc123`                    |

---

### **Example: Full RESTful API Workflow**
Here’s an example of a RESTful API that incorporates advanced response techniques:

#### **Step 1: Retrieve a User**
```http
GET /users/1 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1672531200

{
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com"
  },
  "metadata": {
    "timestamp": "2023-01-01T12:00:00Z",
    "version": "v1",
    "links": {
      "self": { "href": "/users/1" },
      "posts": { "href": "/users/1/posts" }
    }
  }
}
```

#### **Step 2: Retrieve a Paginated List of Users**
```http
GET /users?offset=10&limit=5 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": [
    { "id": 11, "name": "User 11" },
    { "id": 12, "name": "User 12" }
  ],
  "metadata": {
    "offset": 10,
    "limit": 5,
    "total": 100,
    "links": {
      "self": { "href": "/users?offset=10&limit=5" },
      "next": { "href": "/users?offset=15&limit=5" }
    }
  }
}
```

#### **Step 3: Handle an Error**
```http
GET /users/999 HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 404 Not Found
Content-Type: application/json

{
  "error": "User not found",
  "message": "The requested user does not exist.",
  "code": "USER_NOT_FOUND"
}
```

---

## Retries in REST API Response 

Here’s a summary of the **[Retries in REST API Responses](https://restapitutorial.com/advanced/responses/retries)** page from the REST API Tutorial website, using the same method you provided, with explanations and **code examples** where applicable:

---

### **Retries in REST API Responses**
Retries are a mechanism to handle transient failures in API requests. By implementing retries, clients can automatically reattempt failed requests, improving reliability and resilience.

---

### **1. When to Retry**
- **Description**: Retries are useful for handling transient errors, such as:
  - Network timeouts.
  - Server overload (e.g., `503 Service Unavailable`).
  - Rate limiting (e.g., `429 Too Many Requests`).
- **Non-Retriable Errors**: Do not retry for permanent errors (e.g., `400 Bad Request`, `404 Not Found`).

---

### **2. Retry Strategies**
- **Exponential Backoff**: Increase the delay between retries exponentially to avoid overwhelming the server.
- **Fixed Delay**: Retry after a fixed delay.
- **Jitter**: Add randomness to the delay to avoid synchronized retries from multiple clients.

---

### **3. HTTP Headers for Retries**
- **Retry-After**: Specifies how long the client should wait before retrying the request.
  - Can be a number of seconds (e.g., `Retry-After: 10`).
  - Can be a date (e.g., `Retry-After: Wed, 01 Jan 2023 12:00:00 GMT`).

#### Example (Rate Limiting):
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 429 Too Many Requests
Retry-After: 10
Content-Type: application/json

{
  "error": "Rate limit exceeded",
  "message": "Please retry after 10 seconds."
}
```

---

### **4. Implementing Retries in Clients**
- **Description**: Clients can implement retry logic using libraries or custom code.
- **Example**: Use a library like `axios-retry` for JavaScript.

#### Example (JavaScript with `axios-retry`):
```javascript
const axios = require('axios');
const axiosRetry = require('axios-retry');

// Configure axios-retry
axiosRetry(axios, {
  retries: 3, // Number of retries
  retryDelay: (retryCount) => {
    return retryCount * 1000; // Exponential backoff
  },
  retryCondition: (error) => {
    // Retry on network errors or 5xx status codes
    return axiosRetry.isNetworkError(error) || (error.response && error.response.status >= 500);
  }
});

// Make a request
axios.get('https://api.example.com/users')
  .then(response => console.log(response.data))
  .catch(error => console.error(error));
```

---

### **5. Example: Retry Logic in Python**
- **Description**: Use the `requests` library with custom retry logic.

#### Example (Python):
```python
import requests
from requests.adapters import HTTPAdapter
from requests.packages.urllib3.util.retry import Retry

# Configure retry strategy
retry_strategy = Retry(
    total=3,  # Number of retries
    backoff_factor=1,  # Exponential backoff
    status_forcelist=[500, 502, 503, 504]  # Retry on these status codes
)

# Create a session with retry logic
session = requests.Session()
adapter = HTTPAdapter(max_retries=retry_strategy)
session.mount("https://", adapter)

# Make a request
response = session.get("https://api.example.com/users")
print(response.json())
```

---

### **6. Example: Retry Logic in Java**
- **Description**: Use the `Retry` library in Java.

#### Example (Java):
```java
import com.github.rholder.retry.*;
import java.util.concurrent.Callable;
import java.util.concurrent.TimeUnit;

public class RetryExample {
    public static void main(String[] args) throws Exception {
        // Define the retry logic
        Retryer<Boolean> retryer = RetryerBuilder.<Boolean>newBuilder()
            .retryIfException() // Retry on any exception
            .retryIfResult(result -> result == false) // Retry if the result is false
            .withStopStrategy(StopStrategies.stopAfterAttempt(3)) // Stop after 3 attempts
            .withWaitStrategy(WaitStrategies.exponentialWait(1000, TimeUnit.MILLISECONDS)) // Exponential backoff
            .build();

        // Define the task to retry
        Callable<Boolean> task = () -> {
            // Simulate a request
            return makeRequest();
        };

        // Execute the task with retries
        retryer.call(task);
    }

    private static Boolean makeRequest() {
        // Simulate a request that may fail
        return false;
    }
}
```

---

### **7. Best Practices for Retries**
- **Limit Retries**: Set a maximum number of retries to avoid infinite loops.
- **Use Exponential Backoff**: Gradually increase the delay between retries.
- **Respect `Retry-After`**: Follow the server's instructions for retry timing.
- **Log Retries**: Log retry attempts for debugging and monitoring.

---

### **Summary of Retry Strategies**
| Strategy               | Description                              | Example                                   |
|------------------------|------------------------------------------|-------------------------------------------|
| **Exponential Backoff** | Increase delay between retries          | `retryCount * 1000`                       |
| **Fixed Delay**         | Retry after a fixed delay                | `1000` (1 second)                         |
| **Jitter**              | Add randomness to the delay              | `retryCount * 1000 + random(0, 500)`      |
| **Retry-After Header**  | Follow server's retry timing             | `Retry-After: 10`                         |

---

### **Example: Full RESTful API Workflow with Retries**
Here’s an example of a RESTful API that incorporates retry logic:

#### **Step 1: Initial Request**
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 503 Service Unavailable
Retry-After: 5
Content-Type: application/json

{
  "error": "Service unavailable",
  "message": "Please retry after 5 seconds."
}
```

#### **Step 2: Retry After Delay**
```http
GET /users HTTP/1.1
Host: api.example.com
```

#### Response:
```http
HTTP/1.1 200 OK
Content-Type: application/json

{
  "data": [
    { "id": 1, "name": "John Doe" },
    { "id": 2, "name": "Jane Smith" }
  ]
}
```

---

## JSON Serialize and Deserialize 

Here’s a summary of the **[JSON Serialization in Flutter](https://docs.flutter.dev/data-and-backend/serialization/json)** documentation, using the same method you provided, with explanations and **code examples** where applicable:

---

### **JSON Serialization in Flutter**
JSON (JavaScript Object Notation) is a common data format used for communication between clients and servers. Flutter provides tools to serialize (encode) and deserialize (decode) JSON data to and from Dart objects.

---

### **1. Manual JSON Serialization**
- **Description**: Manually parse JSON data using Dart's built-in `dart:convert` library.
- **Use Case**: Suitable for small projects or simple JSON structures.

#### Example:
```dart
import 'dart:convert';

class User {
  final String name;
  final int age;

  User(this.name, this.age);

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['name'],
      json['age'],
    );
  }

  // Convert User object to JSON
  Map<String, dynamic> toJson() => {
    'name': name,
    'age': age,
  };
}

void main() {
  // JSON string
  String jsonString = '{"name": "John Doe", "age": 30}';

  // Decode JSON string to Map
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);

  // Convert Map to User object
  User user = User.fromJson(jsonMap);

  print('User: ${user.name}, ${user.age}');

  // Convert User object back to JSON
  Map<String, dynamic> userJson = user.toJson();
  print('User JSON: ${jsonEncode(userJson)}');
}
```

---

### **2. Automated JSON Serialization**
- **Description**: Use code generation libraries like `json_serializable` to automate JSON serialization.
- **Use Case**: Suitable for larger projects or complex JSON structures.

#### Steps:
1. Add dependencies to `pubspec.yaml`:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     json_annotation: ^4.8.0

   dev_dependencies:
     build_runner: ^2.3.3
     json_serializable: ^6.6.0
   ```

2. Define the model class with annotations:
   ```dart
   import 'package:json_annotation/json_annotation.dart';

   part 'user.g.dart'; // Generated file

   @JsonSerializable()
   class User {
     final String name;
     final int age;

     User(this.name, this.age);

     // Convert JSON to User object
     factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

     // Convert User object to JSON
     Map<String, dynamic> toJson() => _$UserToJson(this);
   }
   ```

3. Generate the serialization code:
   ```bash
   flutter pub run build_runner build
   ```

4. Use the generated code:
   ```dart
   void main() {
     // JSON string
     String jsonString = '{"name": "John Doe", "age": 30}';

     // Decode JSON string to Map
     Map<String, dynamic> jsonMap = jsonDecode(jsonString);

     // Convert Map to User object
     User user = User.fromJson(jsonMap);

     print('User: ${user.name}, ${user.age}');

     // Convert User object back to JSON
     Map<String, dynamic> userJson = user.toJson();
     print('User JSON: ${jsonEncode(userJson)}');
   }
   ```

---

### **3. Handling Nested JSON**
- **Description**: JSON data often contains nested objects or arrays. Use nested model classes to handle this.

#### Example:
```dart
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart'; // Generated file

@JsonSerializable()
class Address {
  final String street;
  final String city;

  Address(this.street, this.city);

  factory Address.fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class User {
  final String name;
  final int age;
  final Address address;

  User(this.name, this.age, this.address);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

void main() {
  // JSON string with nested object
  String jsonString = '{"name": "John Doe", "age": 30, "address": {"street": "123 Main St", "city": "New York"}}';

  // Decode JSON string to Map
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);

  // Convert Map to User object
  User user = User.fromJson(jsonMap);

  print('User: ${user.name}, ${user.age}, ${user.address.street}, ${user.address.city}');

  // Convert User object back to JSON
  Map<String, dynamic> userJson = user.toJson();
  print('User JSON: ${jsonEncode(userJson)}');
}
```

---

### **4. Handling Lists of Objects**
- **Description**: JSON data may contain lists of objects. Use `List<T>` to handle this.

#### Example:
```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart'; // Generated file

@JsonSerializable()
class User {
  final String name;
  final int age;

  User(this.name, this.age);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

void main() {
  // JSON string with list of users
  String jsonString = '[{"name": "John Doe", "age": 30}, {"name": "Jane Smith", "age": 25}]';

  // Decode JSON string to List of Maps
  List<dynamic> jsonList = jsonDecode(jsonString);

  // Convert List of Maps to List of User objects
  List<User> users = jsonList.map((json) => User.fromJson(json)).toList();

  users.forEach((user) {
    print('User: ${user.name}, ${user.age}');
  });

  // Convert List of User objects back to JSON
  List<Map<String, dynamic>> usersJson = users.map((user) => user.toJson()).toList();
  print('Users JSON: ${jsonEncode(usersJson)}');
}
```

---

### **5. Best Practices**
- **Use `json_serializable` for Complex JSON**: Automates serialization and reduces boilerplate code.
- **Validate JSON Data**: Ensure the JSON structure matches the expected format.
- **Handle Null Values**: Use nullable types (`?`) or default values to handle missing fields.

---

### **Summary of JSON Serialization in Flutter**
| Feature               | Description                              | Example                                   |
|-----------------------|------------------------------------------|-------------------------------------------|
| **Manual Serialization** | Parse JSON manually using `dart:convert` | `User.fromJson(jsonDecode(jsonString))`   |
| **Automated Serialization** | Use `json_serializable` for code generation | `@JsonSerializable()`                     |
| **Nested JSON**       | Handle nested objects with model classes | `Address` class for nested address data   |
| **Lists of Objects**  | Use `List<T>` for JSON arrays            | `List<User>` for a list of users          |
| **Best Practices**    | Validate data, handle null values        | Use nullable types (`?`)                  |

---

### **Example: Full JSON Serialization Workflow**
Here’s an example of a RESTful API that incorporates JSON serialization:

#### **Step 1: Define Model Classes**
```dart
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart'; // Generated file

@JsonSerializable()
class User {
  final String name;
  final int age;

  User(this.name, this.age);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
```

#### **Step 2: Generate Serialization Code**
```bash
flutter pub run build_runner build
```

#### **Step 3: Use the Model Class**
```dart
void main() {
  // JSON string
  String jsonString = '{"name": "John Doe", "age": 30}';

  // Decode JSON string to Map
  Map<String, dynamic> jsonMap = jsonDecode(jsonString);

  // Convert Map to User object
  User user = User.fromJson(jsonMap);

  print('User: ${user.name}, ${user.age}');

  // Convert User object back to JSON
  Map<String, dynamic> userJson = user.toJson();
  print('User JSON: ${jsonEncode(userJson)}');
}
```

---
