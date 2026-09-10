import { z } from "zod";

export const playerSearchQuerySchema = z.object({
  search: z.string().trim().min(1).max(80),
});

export const playerResponseSchema = z.object({
  id: z.number(),
  cardNumber: z.number(),
  firstName: z.string(),
  lastName: z.string(),
  imageUrl: z.string().nullable(),
  jerseyNumber: z.number(),
  position: z.string(),
  team: z.object({
    name: z.string(),
    abbreviation: z.string(),
  }),
  season: z.object({
    label: z.string(),
    gamesPlayed: z.number(),
    goals: z.number(),
    assists: z.number(),
    points: z.number(),
    penaltyMinutes: z.number(),
  }),
});

export const playerSearchResponseSchema = z.array(playerResponseSchema);
export type PlayerResponse = z.infer<typeof playerResponseSchema>;
