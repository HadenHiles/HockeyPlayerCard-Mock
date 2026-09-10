import { Hono } from "hono";
import { healthResponseSchema, type HealthResponse } from "./schemas/health.js";

export const app = new Hono();

app.get("/health", (context) => {
  const response: HealthResponse = healthResponseSchema.parse({
    status: "ok",
  });

  return context.json(response);
});
