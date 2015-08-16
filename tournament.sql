-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
-- first create database > vagrant ssh > psql > create database tournament; > \c tournament

-- this table will contain the players in the tournament

CREATE TABLE players (player_ID serial primary key, player_name text);

-- this table will contain the matches between the players in players table

CREATE TABLE matches (match_ID serial primary key, 
					winner integer references players (player_ID), 
					loser integer references players (player_ID)),
					;

-- this view will contain the of players after they have played matches

CREATE VIEW standings AS SELECT a.player_ID, a.player_name,
(SELECT COUNT(winner) as wins from matches where winner=player_ID),
((SELECT COUNT(winner) as wins from matches where winner=player_ID)+
(SELECT COUNT(loser) as losses from matches where loser=player_ID)) as matches
FROM players as a LEFT JOIN matches as b 
ON a.player_ID = b.winner
Group by a.player_ID
ORDER BY wins DESC;