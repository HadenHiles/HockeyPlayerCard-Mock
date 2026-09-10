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

-- Give every player a usable image URL, then use NHL headshots where known.
UPDATE players
SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed='
  || replace(first_name || '-' || last_name, ' ', '-')
  || '&backgroundColor=fec307&fontFamily=Arial'
WHERE image_url IS NULL;

UPDATE players
SET image_url = 'https://assets.nhle.com/mugs/nhl/20252026/BOS/8483489.png'
WHERE first_name = 'Fraser' AND last_name = 'Minten';

UPDATE players
SET image_url = 'https://assets.nhle.com/mugs/nhl/20252026/TOR/8480069.png'
WHERE first_name = 'Bobby' AND last_name = 'McMann';

UPDATE players
SET image_url = 'https://assets.nhle.com/mugs/nhl/20252026/LAK/8478439.png'
WHERE first_name = 'Trevor' AND last_name = 'Moore';
