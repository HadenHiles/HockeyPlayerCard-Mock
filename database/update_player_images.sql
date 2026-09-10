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
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Frederik-Andersen&backgroundColor=fec307&fontFamily=Arial' WHERE id = 1;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Zach-Hyman&backgroundColor=fec307&fontFamily=Arial' WHERE id = 2;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Joe-Thornton&backgroundColor=fec307&fontFamily=Arial' WHERE id = 3;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Nick-Foligno&backgroundColor=fec307&fontFamily=Arial' WHERE id = 4;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Alex-Galchenyuk&backgroundColor=fec307&fontFamily=Arial' WHERE id = 5;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Zach-Bogosian&backgroundColor=fec307&fontFamily=Arial' WHERE id = 6;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Ilya-Mikheyev&backgroundColor=fec307&fontFamily=Arial' WHERE id = 7;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Jack-Campbell&backgroundColor=fec307&fontFamily=Arial' WHERE id = 8;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Ondrej-Kase&backgroundColor=fec307&fontFamily=Arial' WHERE id = 9;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Nick-Ritchie&backgroundColor=fec307&fontFamily=Arial' WHERE id = 10;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Travis-Dermott&backgroundColor=fec307&fontFamily=Arial' WHERE id = 11;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Ilya-Lyubushkin&backgroundColor=fec307&fontFamily=Arial' WHERE id = 12;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Pierre-Engvall&backgroundColor=fec307&fontFamily=Arial' WHERE id = 13;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Rasmus-Sandin&backgroundColor=fec307&fontFamily=Arial' WHERE id = 14;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Jason-Spezza&backgroundColor=fec307&fontFamily=Arial' WHERE id = 15;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Wayne-Simmonds&backgroundColor=fec307&fontFamily=Arial' WHERE id = 16;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Michael-Bunting&backgroundColor=fec307&fontFamily=Arial' WHERE id = 17;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Alexander-Kerfoot&backgroundColor=fec307&fontFamily=Arial' WHERE id = 18;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Justin-Holl&backgroundColor=fec307&fontFamily=Arial' WHERE id = 19;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Ryan-O-Reilly&backgroundColor=fec307&fontFamily=Arial' WHERE id = 20;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Sam-Lafferty&backgroundColor=fec307&fontFamily=Arial' WHERE id = 21;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Noel-Acciari&backgroundColor=fec307&fontFamily=Arial' WHERE id = 22;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Luke-Schenn&backgroundColor=fec307&fontFamily=Arial' WHERE id = 23;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Mark-Giordano&backgroundColor=fec307&fontFamily=Arial' WHERE id = 24;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=TJ-Brodie&backgroundColor=fec307&fontFamily=Arial' WHERE id = 25;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Tyler-Bertuzzi&backgroundColor=fec307&fontFamily=Arial' WHERE id = 26;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Noah-Gregor&backgroundColor=fec307&fontFamily=Arial' WHERE id = 27;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Martin-Jones&backgroundColor=fec307&fontFamily=Arial' WHERE id = 28;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=John-Klingberg&backgroundColor=fec307&fontFamily=Arial' WHERE id = 29;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Ilya-Samsonov&backgroundColor=fec307&fontFamily=Arial' WHERE id = 30;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Timothy-Liljegren&backgroundColor=fec307&fontFamily=Arial' WHERE id = 31;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Connor-Dewar&backgroundColor=fec307&fontFamily=Arial' WHERE id = 32;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Max-Pacioretty&backgroundColor=fec307&fontFamily=Arial' WHERE id = 33;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=David-Kampf&backgroundColor=fec307&fontFamily=Arial' WHERE id = 34;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Mitch-Marner&backgroundColor=fec307&fontFamily=Arial' WHERE id = 35;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Conor-Timmins&backgroundColor=fec307&fontFamily=Arial' WHERE id = 36;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Nikita-Grebenkin&backgroundColor=fec307&fontFamily=Arial' WHERE id = 37;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Petr-Mrazek&backgroundColor=fec307&fontFamily=Arial' WHERE id = 38;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Erik-Kallgren&backgroundColor=fec307&fontFamily=Arial' WHERE id = 39;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Kyle-Clifford&backgroundColor=fec307&fontFamily=Arial' WHERE id = 40;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Colin-Blackwell&backgroundColor=fec307&fontFamily=Arial' WHERE id = 41;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Zach-Aston-Reese&backgroundColor=fec307&fontFamily=Arial' WHERE id = 42;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Erik-Gustafsson&backgroundColor=fec307&fontFamily=Arial' WHERE id = 43;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Victor-Mete&backgroundColor=fec307&fontFamily=Arial' WHERE id = 44;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Dryden-Hunt&backgroundColor=fec307&fontFamily=Arial' WHERE id = 45;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Nicolas-Aube-Kubel&backgroundColor=fec307&fontFamily=Arial' WHERE id = 46;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Joel-Edmundson&backgroundColor=fec307&fontFamily=Arial' WHERE id = 47;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=William-Lagesson&backgroundColor=fec307&fontFamily=Arial' WHERE id = 48;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Maxime-Lajoie&backgroundColor=fec307&fontFamily=Arial' WHERE id = 49;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Matt-Murray&backgroundColor=fec307&fontFamily=Arial' WHERE id = 50;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Joey-Anderson&backgroundColor=fec307&fontFamily=Arial' WHERE id = 51;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Pontus-Holmberg&backgroundColor=fec307&fontFamily=Arial' WHERE id = 52;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Alex-Steeves&backgroundColor=fec307&fontFamily=Arial' WHERE id = 53;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Nicholas-Abruzzese&backgroundColor=fec307&fontFamily=Arial' WHERE id = 54;
UPDATE players SET image_url = 'https://api.dicebear.com/9.x/initials/svg?seed=Mac-Hollowell&backgroundColor=fec307&fontFamily=Arial' WHERE id = 55;
UPDATE players SET image_url = 'https://assets.nhle.com/mugs/nhl/20252026/TOR/8480069.png' WHERE id = 56;
UPDATE players SET image_url = 'https://assets.nhle.com/mugs/nhl/20252026/BOS/8483489.png' WHERE id = 57;
UPDATE players SET image_url = 'https://assets.nhle.com/mugs/nhl/20252026/LAK/8478439.png' WHERE id = 58;
