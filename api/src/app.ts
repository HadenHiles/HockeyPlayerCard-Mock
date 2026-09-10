import { Hono } from "hono";
import { healthResponseSchema, type HealthResponse } from "./schemas/health.js";
import { playerRoutes } from "./routes/players.js";

export const app = new Hono();

app.use("*", async (context, next) => {
  context.header("Access-Control-Allow-Origin", "*");
  context.header("Access-Control-Allow-Methods", "GET, OPTIONS");
  context.header("Access-Control-Allow-Headers", "Content-Type");

  if (context.req.method === "OPTIONS") {
    return context.body(null, 204);
  }

  await next();
});

app.get("/health", (context) => {
  const response: HealthResponse = healthResponseSchema.parse({
    status: "ok",
  });

  return context.json(response);
});

app.route("/api", playerRoutes);
