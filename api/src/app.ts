import { Hono } from "hono";
import type { Context } from "hono";
import { healthResponseSchema, type HealthResponse } from "./schemas/health.js";
import { playerRoutes } from "./routes/players.js";

export const app = new Hono();

const healthCheck = (context: Context) => {
  const response: HealthResponse = healthResponseSchema.parse({
    status: "ok",
  });

  return context.json(response);
};

app.use("*", async (context, next) => {
  context.header("Access-Control-Allow-Origin", "*");
  context.header("Access-Control-Allow-Methods", "GET, OPTIONS");
  context.header("Access-Control-Allow-Headers", "Content-Type");

  if (context.req.method === "OPTIONS") {
    return context.body(null, 204);
  }

  await next();
});

app.get("/health", healthCheck);
app.get("/api/health", healthCheck);

app.route("/api", playerRoutes);

app.onError((error, context) => {
  console.error("API request failed:", error);
  return context.json({ error: "Internal server error" }, 500);
});
