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

### 4. Deploy the application

The frontend lives in `web`, so configure the Vercel project's root directory as `web`. Do not run the database seed as the frontend build command. The seed is a database operation, not a frontend build step.

The API entrypoint is now in `src/server.ts`, with the Hono app exported from `src/app.ts`. The current Vercel project should remain rooted at `web` for the frontend; deploy the API separately or add a Vercel serverless adapter when you are ready to expose it through the same project.

## Player search

Search former Leafs player data with:

```text
GET /api/players?search=hyman
```

The route returns up to eight matching players. Search uses PostgreSQL `ILIKE`, which is sufficient for the current seeded dataset; a search engine would add unnecessary infrastructure at this size.
