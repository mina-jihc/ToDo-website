# Full-Stack Todo & JavaScript Task Application

A full-stack application featuring a custom Node.js/TypeScript backend server with JSON file persistence, a vanilla frontend interface, and auxiliary JavaScript/TypeScript task scripts.

---

## 📁 Project Structure

```text
JavaScript tasks/
├── backend/
│   ├── data.json       # JSON-based data storage for tasks
│   └── todo.ts         # Node.js HTTP server handling API requests
├── frontend/
│   ├── index.html      # Main landing page(JavaScript Tasks)
│   ├── script.js       # Frontend interaction script
│   ├── style.css       # Global styles[cite: 5]
│   ├── todo.css        # Todo-specific styles[cite: 5]
│   ├── todo.html       # Todo UI interface[cite: 5]
│   └── todo.js         # Todo frontend logic[cite: 5]
├── co-body.d.ts        # TypeScript declaration file[cite: 5]
├── package.json        # Project dependencies and npm scripts[cite: 5]
├── script.ts           # Additional TypeScript tasks[cite: 5]
└── tsconfig.json       # TypeScript configuration[cite: 5]


🚀 Tech Stack
Backend: TypeScript, Node.js (http module), custom request parsing, JSON file storage[cite: 5]

Frontend: HTML5, CSS3, Vanilla JavaScript[cite: 5]

Tooling & Execution: tsx (TypeScript Execute with watch mode), TypeScript compiler (tsc)[cite: 5]

## API Endpoints
- **GET /list** - Get all the tasks (Статус: `200 OK`)
- **POST /post** - Add a new task (Статус: `201 Created`)
- **PUT /edit** - Edited an existing task (Статус: `200 OK`)
- **DELETE /delete** - Deleted an existing task (Статус: `200 OK`)

### Request Examples

#### 1.Add a new task (`POST /post`)
**Body (JSON):**
```json
{
  "title": "Your new task",
  "completed": false
}

### 1.Example:
{
    "id": 1792306285573,
    "title": "Drink water",
    "completed": false
  }

#### 2.Edit a task (`PUT /edit`)
**Body (JSON):**
```json
{
  "id": Your task's id,
  "title": "Your new task (updated)",
  "completed": false
}

### 2.Example:
{
    "id": 1792306285573,
    "title": "Drink juice",
    "completed": false
  }

#### 3.Delete a task (`DELETE /delete`)
**Body (JSON):**
```json
{
  "id": Your task's id,
  "title": "Your task",
  "completed": false
}
### 3.Example:
{
    "id": 1792306285573,
    "title": "Drink juice",
    "completed": false
  }

⚙️ Getting Started & Installation
Prerequisites
Make sure you have Node.js installed on your system.

Setup Instructions
Clone the repository or open your local workspace folder (JavaScript tasks)[cite: 5].

Install the required project dependencies:

Bash
npm install
📦 Running the Application
1. Run the Backend Server
The backend runs using tsx in watch mode to handle API endpoints (such as fetching, creating, updating via PUT /edit, and deleting tasks)[cite: 5]:

Bash
npx tsx watch backend/todo.ts
The server will start and listen on port 3004 by default.

2. Frontend Development
You can open the files inside the frontend/ directory (such as todo.html or index.html) using a Live Server extension in VS Code to interact with the UI and communicate with your backend server[cite: 5].

3. Type Checking
To run static type checking across your TypeScript files without emitting outputs:

Bash
npx tsc --noEmit

Screenshots
<img width="1471" height="927" alt="image" src="https://github.com/user-attachments/assets/bb092b48-1257-43c6-b989-006e4eb46f2c" />
<img width="830" height="422" alt="image" src="https://github.com/user-attachments/assets/3c2ed9d1-b14e-4492-89ab-0c6cbac641ec" />
<img width="1079" height="930" alt="image" src="https://github.com/user-attachments/assets/0c8cfba5-d399-4f82-85ef-47c60363c423" />
