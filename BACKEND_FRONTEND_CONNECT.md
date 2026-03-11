## Connect Backend to Frontend

### 1) Set frontend API URL
Create or update `.env.local` in the project root:

NEXT_PUBLIC_API_URL=http://localhost:5000

Restart the Next.js dev server after changing env vars.

### 2) Run backend
From `backend/`:
- `npm install`
- `npm run start`

### 3) Test connection
Open: `http://localhost:8080/en/users`

### 4) Create a user (example)
Send a request to:

POST http://localhost:5000/api/users
Body: `{ "name": "Test User", "email": "test@example.com", "password": "123456" }`
