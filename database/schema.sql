CREATE TABLE IF NOT EXISTS teams (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  abbreviation VARCHAR(5) NOT NULL
);

CREATE TABLE IF NOT EXISTS players (
  id SERIAL PRIMARY KEY,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  image_url TEXT,
  jersey_number INTEGER NOT NULL,
  position VARCHAR(5) NOT NULL,
  team_id INTEGER REFERENCES teams(id)
);

CREATE TABLE IF NOT EXISTS seasons (
  id SERIAL PRIMARY KEY,
  label TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS player_season_stats (
  player_id INTEGER REFERENCES players(id),
  season_id INTEGER REFERENCES seasons(id),
  games_played INTEGER NOT NULL DEFAULT 0,
  goals INTEGER NOT NULL DEFAULT 0,
  assists INTEGER NOT NULL DEFAULT 0,
  penalty_minutes INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (player_id, season_id)
);