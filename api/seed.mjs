import "dotenv/config";
import { readFile } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import pg from "pg";

const { Client } = pg;
const databaseDirectory = fileURLToPath(
  new URL("../database/", import.meta.url),
);
const databaseUrl =
  process.env.DATABASE_URL ?? "postgresql://localhost:5432/hockey_card";

async function runSeed() {
  const client = new Client({ connectionString: databaseUrl });
  const seedLockId = 8483489;
  let transactionStarted = false;

  await client.connect();

  try {
    await client.query("SELECT pg_advisory_lock($1)", [seedLockId]);

    const existingDatabase = await client.query(`
      SELECT to_regclass('public.teams') IS NOT NULL AS has_schema,
             COALESCE((SELECT COUNT(*) FROM teams), 0) AS team_count
    `);

    if (
      existingDatabase.rows[0].has_schema &&
      Number(existingDatabase.rows[0].team_count) > 0
    ) {
      console.log("Database already contains seed data; skipping.");
      return;
    }

    await client.query("BEGIN");
    transactionStarted = true;
    await client.query(
      await readFile(`${databaseDirectory}schema.sql`, "utf8"),
    );
    await client.query(await readFile(`${databaseDirectory}seed.sql`, "utf8"));
    await client.query("COMMIT");

    const result = await client.query(`
      SELECT
        (SELECT COUNT(*) FROM teams) AS teams,
        (SELECT COUNT(*) FROM players) AS players,
        (SELECT COUNT(*) FROM seasons) AS seasons,
        (SELECT COUNT(*) FROM player_season_stats) AS stats
    `);

    console.log("Database seeded:", result.rows[0]);
  } catch (error) {
    if (transactionStarted) {
      await client.query("ROLLBACK");
    }
    throw error;
  } finally {
    await client.query("SELECT pg_advisory_unlock($1)", [seedLockId]);
    await client.end();
  }
}

runSeed().catch((error) => {
  console.error("Database seed failed:", error.message);
  process.exitCode = 1;
});
