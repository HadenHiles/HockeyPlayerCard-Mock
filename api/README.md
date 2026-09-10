# Hockey Card API Database

The API uses Hono on Node.js, Zod for runtime validation and inferred types, and PostgreSQL through the `pg` client.

## API setup

Start the development server from this directory:

```sh
npm install
npm run dev
```

The health check is available at:

```text
GET http://localhost:3000/health
```

It returns:

```json
{"status":"ok"}
```

Run the typed API build with `npm run build`.

## Local setup

1. Start PostgreSQL:

   ```sh
   brew services start postgresql@16
   ```

2. Create the database once:

   ```sh
   createdb hockey_card
   ```

3. Add `DATABASE_URL` to `.env` or export it in the shell:

   ```sh
   DATABASE_URL=postgresql://localhost:5432/hockey_card
   ```

4. Seed the database:

   ```sh
   npm install
   npm run seed
   ```

The seed runner applies `database/schema.sql` and `database/seed.sql` in one transaction. It uses a PostgreSQL advisory lock and skips an already-populated database, so repeated or concurrent deployment runs do not duplicate the seed.

## Vercel

### 1. Create a hosted PostgreSQL database

Create a database with Vercel Postgres, Neon, Supabase, or another PostgreSQL provider. Copy its pooled connection string:

```text
DATABASE_URL=postgresql://USER:PASSWORD@HOST:5432/DATABASE?sslmode=require
```

### 2. Add the Vercel environment variable

In Vercel, open the project and choose **Settings -> Environment Variables**. Add `DATABASE_URL` with the pooled connection string for `Production`, `Preview`, and `Development` as needed.

Keep it server-side. Do not prefix it with `NEXT_PUBLIC_` or expose it to browser code. Do not commit the real URL or put it in `.env.example`.

### 3. Seed the hosted database once

From this `api` directory, run:

```sh
DATABASE_URL="postgresql://USER:PASSWORD@HOST:5432/DATABASE?sslmode=require" npm run seed
```

Alternatively, pull the Vercel Development environment locally, seed it, then remove the local secret file:

```sh
vercel env pull .env.vercel
npm run seed
rm .env.vercel
```

`.env.vercel` is covered by the repository's `.env.*` ignore rule.

### 4. Deploy the API to Vercel

Create a separate Vercel project for the API:

- Import the same Git repository
- Set **Root Directory** to `api`
- Leave the framework as **Other**
- Set the build command to `npm run build`
- Add `DATABASE_URL` in the Vercel environment variables
- Deploy

The catch-all function is located at `api/[[...path]].ts` relative to that project root, so the deployed API URL will be:

```text
https://your-hockey-card-api.vercel.app/api/players?search=hyman
```

Verify it before updating the frontend:

```sh
curl "https://your-hockey-card-api.vercel.app/health"
curl "https://your-hockey-card-api.vercel.app/api/players?search=hyman"
```

### 5. Deploy the frontend to Vercel

Create or update a second Vercel project:

- Import the same Git repository
- Set **Root Directory** to `web`
- Set `VITE_API_URL` to `https://your-hockey-card-api.vercel.app`
- Deploy

The frontend uses the local Vite proxy only when `VITE_API_URL` is empty. Do not run the database seed as the frontend build command.

The API entrypoint is `src/server.ts` for local Node development, while `api/index.ts` is the Vercel function entrypoint relative to the API project root.

## Player search

Search former Leafs player data with:

```text
GET /api/players?search=hyman
```

The route returns up to eight matching players. Search uses PostgreSQL `ILIKE`, which is sufficient for the current seeded dataset; a search engine would add unnecessary infrastructure at this size.
