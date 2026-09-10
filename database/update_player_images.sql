-- Add image support to an existing Hockey Card database.
-- Safe to run more than once.

ALTER TABLE players
  ADD COLUMN IF NOT EXISTS image_url TEXT;

-- Add players that were missing from the original departure seed.
INSERT INTO players (id, first_name, last_name, image_url, jersey_number, position, team_id)
SELECT 56, 'Bobby', 'McMann', NULL, 74, 'F', 25
WHERE NOT EXISTS (SELECT 1 FROM players WHERE first_name = 'Bobby' AND last_name = 'McMann');

INSERT INTO players (id, first_name, last_name, image_url, jersey_number, position, team_id)
SELECT 57, 'Fraser', 'Minten', NULL, 39, 'C', 11
WHERE NOT EXISTS (SELECT 1 FROM players WHERE first_name = 'Fraser' AND last_name = 'Minten');

INSERT INTO players (id, first_name, last_name, image_url, jersey_number, position, team_id)
SELECT 58, 'Trevor', 'Moore', NULL, 12, 'LW', 15
WHERE NOT EXISTS (SELECT 1 FROM players WHERE first_name = 'Trevor' AND last_name = 'Moore');

INSERT INTO player_season_stats
  (player_id, season_id, games_played, goals, assists, penalty_minutes)
SELECT 56, 5, 74, 20, 14, 27
WHERE EXISTS (SELECT 1 FROM players WHERE id = 56)
  AND NOT EXISTS (
    SELECT 1 FROM player_season_stats WHERE player_id = 56 AND season_id = 5
  );

INSERT INTO player_season_stats
  (player_id, season_id, games_played, goals, assists, penalty_minutes)
SELECT 57, 5, 15, 2, 2, 0
WHERE EXISTS (SELECT 1 FROM players WHERE id = 57)
  AND NOT EXISTS (
    SELECT 1 FROM player_season_stats WHERE player_id = 57 AND season_id = 5
  );

INSERT INTO player_season_stats
  (player_id, season_id, games_played, goals, assists, penalty_minutes)
SELECT 58, 1, 15, 4, 3, 6
WHERE EXISTS (SELECT 1 FROM players WHERE id = 58)
  AND NOT EXISTS (
    SELECT 1 FROM player_season_stats WHERE player_id = 58 AND season_id = 1
  );

-- One explicit image update per player keeps the migration auditable.
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8475883.jpg' WHERE id = 1;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8475786.jpg' WHERE id = 2;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8466138.jpg' WHERE id = 3;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8473422.jpg' WHERE id = 4;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8476851.jpg' WHERE id = 5;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8474567.jpg' WHERE id = 6;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8481624.jpg' WHERE id = 7;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8475789.jpg' WHERE id = 8;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478131.jpg' WHERE id = 9;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8477941.jpg' WHERE id = 10;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478408.jpg' WHERE id = 11;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8480950.jpg' WHERE id = 12;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478115.jpg' WHERE id = 13;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8480873.jpg' WHERE id = 14;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8469455.jpg' WHERE id = 15;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8474190.jpg' WHERE id = 16;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478047.jpg' WHERE id = 17;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8477021.jpg' WHERE id = 18;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8475718.jpg' WHERE id = 19;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8475158.jpg' WHERE id = 20;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478043.jpg' WHERE id = 21;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478569.jpg' WHERE id = 22;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8474568.jpg' WHERE id = 23;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8470966.jpg' WHERE id = 24;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8474673.jpg' WHERE id = 25;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8477479.jpg' WHERE id = 26;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8479393.jpg' WHERE id = 27;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8474889.jpg' WHERE id = 28;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8475906.jpg' WHERE id = 29;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478492.jpg' WHERE id = 30;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8480043.jpg' WHERE id = 31;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8480980.jpg' WHERE id = 32;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8474157.jpg' WHERE id = 33;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8480144.jpg' WHERE id = 34;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478483.jpg' WHERE id = 35;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8479982.jpg' WHERE id = 36;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8483733.jpg' WHERE id = 37;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8475852.jpg' WHERE id = 38;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478902.jpg' WHERE id = 39;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8475160.jpg' WHERE id = 40;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8476278.jpg' WHERE id = 41;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478878.jpg' WHERE id = 42;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8476979.jpg' WHERE id = 43;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8479376.jpg' WHERE id = 44;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478211.jpg' WHERE id = 45;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8479992.jpg' WHERE id = 46;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8476441.jpg' WHERE id = 47;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8478021.jpg' WHERE id = 48;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8479320.jpg' WHERE id = 49;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8476899.jpg' WHERE id = 50;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8479315.jpg' WHERE id = 51;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8480995.jpg' WHERE id = 52;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8482634.jpg' WHERE id = 53;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8482392.jpg' WHERE id = 54;
UPDATE players SET image_url = 'https://cms.nhl.bamgrid.com/images/headshots/current/168x168/8480439.jpg' WHERE id = 55;
UPDATE players SET image_url = 'https://assets.nhle.com/mugs/nhl/20252026/TOR/8480069.png' WHERE id = 56;
UPDATE players SET image_url = 'https://assets.nhle.com/mugs/nhl/20252026/BOS/8483489.png' WHERE id = 57;
UPDATE players SET image_url = 'https://assets.nhle.com/mugs/nhl/20252026/LAK/8478439.png' WHERE id = 58;
