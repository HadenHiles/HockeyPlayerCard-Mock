import { Hono } from "hono";
import { databasePool } from "../db.js";
import {
  playerSearchQuerySchema,
  playerSearchResponseSchema,
} from "../schemas/player.js";

export const playerRoutes = new Hono();

playerRoutes.get("/players", async (context) => {
  const query = playerSearchQuerySchema.safeParse({
    search: context.req.query("search"),
  });

  if (!query.success) {
    return context.json(
      { error: "Search must be between 1 and 80 characters." },
      400,
    );
  }

  const searchTerm = query.data.search ? `%${query.data.search}%` : "%";
  const result = await databasePool.query(
    `
      SELECT
        players.id,
        players.id AS card_number,
        players.first_name,
        players.last_name,
        players.image_url,
        players.jersey_number,
        players.position,
        teams.name AS team_name,
        teams.abbreviation AS team_abbreviation,
        seasons.label AS season_label,
        player_season_stats.games_played,
        player_season_stats.goals,
        player_season_stats.assists,
        player_season_stats.goals + player_season_stats.assists AS points,
        player_season_stats.penalty_minutes
      FROM players
      JOIN teams ON teams.id = players.team_id
      JOIN player_season_stats ON player_season_stats.player_id = players.id
      JOIN seasons ON seasons.id = player_season_stats.season_id
      WHERE CONCAT_WS(' ', players.first_name, players.last_name) ILIKE $1
         OR players.first_name ILIKE $1
         OR players.last_name ILIKE $1
      ORDER BY players.last_name, players.first_name
      LIMIT 100
    `,
    [searchTerm],
  );

  const response = playerSearchResponseSchema.parse(
    result.rows.map((player) => ({
      id: player.id,
      cardNumber: player.card_number,
      firstName: player.first_name,
      lastName: player.last_name,
      imageUrl: player.image_url,
      jerseyNumber: player.jersey_number,
      position: player.position,
      team: {
        name: player.team_name,
        abbreviation: player.team_abbreviation,
      },
      season: {
        label: player.season_label,
        gamesPlayed: player.games_played,
        goals: player.goals,
        assists: player.assists,
        points: player.points,
        penaltyMinutes: player.penalty_minutes,
      },
    })),
  );

  return context.json(response);
});
