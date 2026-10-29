Todo API — Express + TypeScript
A RESTful Todo API built with Express and TypeScript, featuring validation with zod, JSON file persistence, filtering/sorting/pagination, and security middleware.

 Tech Stack
Backend: Node.js, Express, TypeScript
Validation: zod
Security: helmet, CORS, express-rate-limit
Logging: morgan
Runtime: tsx
Storage: JSON file (data.json)
📁 Project Structure
backend/
├── data.json               # Task storage
├── todo_express.ts               # ToDo written with Express and TypeScript
├── todo.ts               # ToDo written with Node.js and TypeScript

frontend/
├── frontend

src/
├── controllers/tasks.ts    # Request handling logic
├── middleware/errorHandler.ts     # Centralized error responses
├── routes/tasks.ts         # API route definitions
├── services/tasks.ts       # Data operations (read/write JSON)
├── utils/
│   ├── AppError.ts         # Custom error class with statusCode
│   ├── asyncHandler.ts     # Wraps async handlers, forwards errors
│   ├── taskSchema.ts       # zod schema for creating tasks
│   ├── updateTaskSchema.ts # zod schema for updating tasks
│   └── querySchema.ts      # zod schema for query params
├── index.ts                # Server entry point
├── types.ts                # TypeScript types
Копировать
🔌 API Endpoints
GET /tasks
Get all tasks. Supports query parameters:

Param	Values	Description
status	completed | active	Filter by completion status
sort	title | id | completed	Sort results
page	number	Page number (starts at 1)
limit	number	Items per page (default 10)
Example:

GET /tasks?status=active&sort=title&page=1&limit=5
Response: 200 OK

[
  { "id": 1792306285573, "title": "Drink water", "completed": false }
]

POST /tasks
Create a new task.

Body (JSON):

{
  "title": "Your new task"
}
Response: 201 Created

{
  "id": 1792306285573,
  "title": "Your new task",
  "completed": false
}
PUT /tasks/:id
Update an existing task. Both fields are optional — send only what you want to change.

Body (JSON):

{
  "title": "Updated title",
  "completed": true
}
Response: 200 OK

{
  "id": 1792306285573,
  "title": "Updated title",
  "completed": true
}
DELETE /tasks/:id
Delete a task by its id.

Response: 200 OK

GET /health
Health check — verifies the server is running.

Response: 200 OK

{
  "uptime": 123.45,
  "message": "Ok",
  "date": "2026-10-29T11:00:00.000Z"
}

🛡️ Security
helmet — sets secure HTTP headers
CORS — controls cross-origin requests
express-rate-limit — limits requests per IP (100 requests / 15 min)
Graceful shutdown — closes the server safely on SIGTERM
⚙️ Getting Started
Prerequisites
Node.js installed
Setup
# 1. Install dependencies
npm install

# 2. Create .env file
# PORT=3000

# 3. Run the server
npm run dev

The server starts on http://localhost:3000 by default.

🔑 Environment Variables
Variable	Default	  Description
PORT	    3000	    Server port
