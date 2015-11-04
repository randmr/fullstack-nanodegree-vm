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
  (id serial,
    name char(40));

CREATE TABLE matches
  (id serial,
  round smallint,
  player1 smallint,
  player2 smallint,
  winner smallint);

CREATE VIEW wins AS
  SELECT
    players.id, count(p1.winner), count(p2.winner)
  FROM
    players
  LEFT JOIN
    matches p1 ON (players.id = p1.player1)
  LEFT JOIN
    matches p2 ON (players.id = p2.player2)
  GROUP BY
    players.id

CREATE VIEW wins2 AS
    SELECT
      players.id, players.name, count(matches.winner) AS wins, count(*) AS matches
    FROM
      players
    LEFT JOIN
      matches ON (players.id = matches.winner)
    GROUP BY
      players.id, players.name
    ORDER BY wins DESC;
