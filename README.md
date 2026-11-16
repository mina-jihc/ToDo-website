# Todo API — Express + TypeScript

A RESTful Todo API built with Express and TypeScript, featuring JWT authentication with refresh-token rotation, role-based access (user / admin), validation with zod, filtering/sorting/pagination, and security middleware.

## Tech Stack

- **Backend:** Node.js, Express, TypeScript
- **Database:** PostgreSQL + Prisma ORM
- **Auth:** JWT (access + refresh), bcrypt
- **Validation:** zod
- **Security:** helmet, CORS, cookie-parser, express-rate-limit
- **Logging:** morgan
- **Runtime:** tsx

## Project Structure

```
src/
├── controllers/
│   ├── auth.controller.ts   # register / login / refresh / logout handlers
│   └── tasks.ts             # Task request handling logic
├── middleware/
│   ├── auth.middleware.ts   # Verifies access token, sets req.user
│   ├── rateLimit.ts         # authLimiter (5 req/min on /auth)
│   └── errorHandler.ts      # Centralized error responses
├── routes/
│   ├── auth.routes.ts       # /auth endpoints
│   └── tasks.ts             # /tasks endpoints
├── services/
│   ├── auth.service.ts      # register, login, refreshTokens, logout, saveRefreshToken
│   └── tasks.ts             # Task data operations (Prisma)
├── utils/
│   ├── AppError.ts          # Custom error class with statusCode
│   ├── errors.ts            # AuthError, ConflictError, NotFoundError, ForbiddenError
│   ├── jwt.ts               # createAccessToken / createRefreshToken / verify*
│   ├── taskSchema.ts        # zod schema for creating tasks
│   ├── updateTaskSchema.ts  # zod schema for updating tasks
│   └── querySchema.ts       # zod schema for query params
├── index.ts                 # Server entry point
├── prisma.ts                # Prisma client instance
└── types.ts                 # TypeScript types
```

## API Endpoints

### Auth

| Method | Endpoint | Auth | Description |
|--------|----------|------|-------------|
| POST | `/auth/register` | — | Create account, returns user + access token, sets refresh cookie |
| POST | `/auth/login` | — | Log in, returns user + access token, sets refresh cookie |
| POST | `/auth/refresh` | cookie | Rotates refresh token, returns new access token |
| POST | `/auth/logout` | cookie | Deletes refresh token from DB, clears cookie |

**POST /auth/register** — Body:

```json
{
  "name": "Kate",
  "email": "kate@gmail.com",
  "password": "secret123"
}
```

Response `201 Created`:

```json
{
  "user": { "id": 1, "name": "Kate", "email": "kate@gmail.com", "role": "user" },
  "accessToken": "eyJhbGciOi..."
}
```

The refresh token is **not** in the JSON body — it is set as an `httpOnly` cookie.

**POST /auth/login** — Body:

```json
{
  "email": "kate@gmail.com",
  "password": "secret123"
}
```

Response `200 OK` — same shape as register. Wrong credentials → `401 Invalid credentials`.

**POST /auth/refresh** — no body, reads the `refreshToken` cookie.

Response `200 OK` — new `accessToken` + rotated `refreshToken` cookie. Old refresh token is deleted from the database, so it works only **once**. Reusing it → `401`.

**POST /auth/logout** — no body. Deletes the refresh token row and clears the cookie.

Response `204 No Content`.

### Tasks

All `/tasks` endpoints require `Authorization: Bearer <accessToken>`.

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/tasks` | List tasks (paginated, filterable) |
| GET | `/tasks/:id` | Get one task (404 if not yours) |
| POST | `/tasks` | Create a task |
| PUT | `/tasks/:id` | Update a task (owner only) |
| DELETE | `/tasks/:id` | Delete a task (owner only) |

**GET /tasks** — query parameters:

| Param | Values | Description |
|-------|--------|-------------|
| status | completed \| active | Filter by completion status |
| sort | title \| id \| completed | Sort results |
| page | number | Page number (starts at 1) |
| limit | number | Items per page (default 10) |

Example: `GET /tasks?status=active&sort=title&page=1&limit=5`

Response `200 OK`:

```json
[
  { "id": 1, "title": "Drink water", "completed": false }
]
```

Admins receive **all** users' tasks; regular users only their own.

**POST /tasks** — Body:

```json
{ "title": "Your new task" }
```

Response `201 Created`:

```json
{ "id": 1, "title": "Your new task", "completed": false }
```

**PUT /tasks/:id** — both fields optional:

```json
{ "title": "Updated title", "completed": true }
```

Response `200 OK`. Not the owner → `403`.

**DELETE /tasks/:id** — Response `200 OK`.

### Health

**GET /health** — Response `200 OK`:

```json
{
  "uptime": 123.45,
  "message": "Ok",
  "date": "2026-10-29T11:00:00.000Z"
}
```

## Auth Design

- **Access token** — 15 minutes, sent in the `Authorization: Bearer` header, signed with `JWT_ACCESS_SECRET`.
- **Refresh token** — 7 days, sent only as an `httpOnly` cookie, signed with `JWT_REFRESH_SECRET`, and stored in the `RefreshToken` table.
- **Rotation** — every `/auth/refresh` deletes the old token and issues a new pair. A stolen token can be used only once, and the victim's next refresh fails, revealing the theft.
- **Role from DB** — on refresh the role is read from the database, not from the token, so role changes take effect on the next refresh.
- **Logout** — the refresh token row is deleted, so the token can no longer be used even if the cookie is kept.

## Roles

| Role | Capabilities |
|------|--------------|
| `user` | CRUD on own tasks only |
| `admin` | Read all tasks, CRUD on own tasks |

Role is stored in `App_users.role` and can be changed in Prisma Studio. Log in again (or refresh) after changing it.

## Security

- **helmet** — sets secure HTTP headers
- **CORS** — controls cross-origin requests
- **cookie-parser** — parses the refresh-token cookie
- **express-rate-limit**
  - global: 100 requests / 15 min per IP
  - `authLimiter`: 5 requests / min on `/auth/register`, `/auth/login`, `/auth/refresh`
- **bcrypt** — passwords hashed with 10 rounds, never returned in responses
- **httpOnly + sameSite=strict** — refresh token is unreadable from JavaScript
- **Graceful shutdown** — closes the server safely on SIGTERM

## Error Format

All errors return a consistent JSON body:

```json
{ "error": "Invalid credentials" }
```

| Status | Meaning |
|--------|---------|
| 400 | Validation failed / invalid id |
| 401 | Missing, invalid or expired token; wrong credentials |
| 403 | Not the owner of the resource |
| 404 | Task not found |
| 409 | Email already taken |
| 429 | Too many attempts (rate limit) |
| 500 | Internal server error |

## Getting Started

Prerequisites: Node.js and PostgreSQL installed.

```bash
# 1. Install dependencies
npm install

# 2. Create .env (see below)

# 3. Generate Prisma client
npx prisma generate

# 4. Run the server
npm run dev
```

The server starts on `http://localhost:3000` by default.

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| PORT | 3000 | Server port |
| DATABASE_URL | — | PostgreSQL connection string |
| JWT_ACCESS_SECRET | — | Secret for access tokens |
| JWT_REFRESH_SECRET | — | Secret for refresh tokens |
| NODE_ENV | development | `production` enables `secure` cookies |

Example `.env.example`:

```
PORT=3000
DATABASE_URL="postgresql://user:password@localhost:5432/todo"
JWT_ACCESS_SECRET=change_me
JWT_REFRESH_SECRET=change_me_too
NODE_ENV=development
```

Never commit the real `.env`.

## Testing with Postman

1. `POST /auth/register` → 201, access token in body, refresh cookie set
2. `POST /auth/login` → 200, new access token
3. `GET /tasks` with `Authorization: Bearer <token>` → 200
4. `POST /auth/refresh` → 200, new access token
5. `POST /auth/refresh` again with the old cookie → 401 (rotation works)
6. 6 wrong logins within a minute → 429 (rate limit works)
7. `POST /auth/logout` → 204, then `POST /auth/refresh` → 401
