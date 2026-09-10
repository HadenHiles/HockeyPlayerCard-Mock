import pg from "pg";

const { Pool } = pg;

export const databasePool = new Pool({
  connectionString:
    process.env.DATABASE_URL ?? "postgresql://localhost:5432/hockey_card",
});
