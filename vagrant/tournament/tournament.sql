-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.

DROP DATABASE IF EXISTS tournament;

CREATE DATABASE tournament;
\c tournament

CREATE TABLE players
  (id serial PRIMARY KEY,
    name varchar(40));

CREATE TABLE matches
  (id serial PRIMARY KEY,
  round smallint,
  winner smallint,
  loser smallint,
  FOREIGN KEY (winner) REFERENCES players(id),
  FOREIGN KEY (loser) REFERENCES players(id));

-- CREATE VIEW wins AS
--   SELECT
--     players.id, (SELECT count(winner) from matches) + (SELECT count(winner) from matches) as matches
--   FROM
--     players
--   LEFT JOIN
--     matches p1 ON (players.id = p1.player1)
--   LEFT JOIN
--     matches p2 ON (players.id = p2.player2)
--   GROUP BY
--     players.id;
--
-- CREATE VIEW wins2 AS
--     SELECT
--       players.id, players.name, count(matches.winner) AS wins, count(*) AS matches
--     FROM
--       players, (SELECT players.id, matches)
--     LEFT JOIN
--       matches ON (players.id = matches.winner)
--     GROUP BY
--       players.id, players.name
--     ORDER BY wins DESC;

-- SELECT
--   players.id, players.name, count(matches.winner) as wins, count(DISTINCT (matches.winner, matches.loser)) AS matchesPlayed
-- FROM
--   players JOIN (SELECT players.id, count(matches.winner) AS wins, count(matches.loser) AS losses FROM players JOIN matches ON (players.id = matches.winner AND players.id = matches.loser) GROUP BY players.id) AS matchCounts
-- ON (players.id = matches.winner AND players.id = matches.loser)
-- GROUP BY
--   players.id, players.name
-- ORDER BY
--   wins DESC;
