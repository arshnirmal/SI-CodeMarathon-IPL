set search_path to ipl;

-- Table Initialization
create table if not exists teams (
	team_id serial primary key,
	team_name varchar(50) unique not null,
	coach varchar(50) not null,
	home_ground varchar(100) not null,
	founded_year integer not null,
	owner varchar(50) not null
);

create table if not exists players(
	player_id serial primary key,
	player_name varchar(50) not null,
	team_id integer not null references teams(team_id),
	role varchar(30) not null,
	age integer not null,
	matches_played integer not null
);

create table if not exists matches(
	match_id serial primary key,
	match_date date not null,
	venue varchar(100) not null,
	team1_id integer not null references teams(team_id),
	team2_id integer not null references teams(team_id),
	winner_team_id integer references teams(team_id)
);

create table if not exists fan_engagement(
	engagement_id serial primary key,
	match_id integer not null references matches(match_id),
	fan_id integer not null,
	engagement_type varchar(50) not null, --Tweet,Comment,Like,Share
	engagement_time timestamp not null
);

-- Data Input
insert into teams (team_name, coach, home_ground, founded_year, owner)
	values 
	('Mumbai Indians', 'Mahela Jayawardene', 'Wankhede Stadium', 2008, 'Reliance Industries'),
	('Chennai Super Kings', 'Stephen Fleming', 'M. A. Chidambaram Stadium', 2008, 'India Cements'),
	('Royal Challengers Bangalore', 'Sanjay Bangar', 'M. Chinnaswamy Stadium', 2008, 'United Spirits'),
	('Kolkata Knight Riders', 'Brendon McCullum', 'Eden Gardens', 2008, 'Red Chillies Entertainment'),
	('Delhi Capitals', 'Ricky Ponting', 'Arun Jaitley Stadium', 2008, 'GMR Group & JSW Group');

insert into players (player_name, team_id, role, age, matches_played)
	values
	('Rohit Sharma', 1, 'Batsman', 36, 227),
	('Jasprit Bumrah', 1, 'Bowler', 30, 120),
	('MS Dhoni', 2, 'Wicketkeeper-Batsman', 42, 234),
	('Ravindra Jadeja', 2, 'All-Rounder', 35, 210),
	('Virat Kohli', 3, 'Batsman', 35, 237),
	('AB de Villiers', 3, 'Batsman', 40, 184),
	('Andre Russell', 4, 'All-Rounder', 36, 140),
	('Sunil Narine', 4, 'Bowler', 35, 144),
	('Rishabh Pant', 5, 'Wicketkeeper-Batsman', 26, 98),
	('Shikhar Dhawan', 5, 'Batsman', 38, 206);

insert into matches (match_date, venue, team1_id, team2_id, winner_team_id)
	values
	('2024-04-01', 'Wankhede Stadium', 1, 2, 1),
	('2024-04-05', 'M. A. Chidambaram Stadium', 2, 3, 3),
	('2024-04-10', 'M. Chinnaswamy Stadium', 3, 4, 4),
	('2024-04-15', 'Eden Gardens', 4, 5, 4),
	('2024-04-20', 'Arun Jaitley Stadium', 5, 1, 1),
	('2024-04-25', 'Wankhede Stadium', 1, 3, 3),
	('2024-05-01', 'M. A. Chidambaram Stadium', 2, 5, 2),
	('2024-05-05', 'M. Chinnaswamy Stadium', 3, 1, 1),
	('2024-05-10', 'Eden Gardens', 4, 2, 2),
	('2024-05-15', 'Arun Jaitley Stadium', 5, 4, 4);

insert into fan_engagement (match_id, fan_id, engagement_type, engagement_time)
	values
	(1, 101, 'Tweet', '2024-04-01 18:30:00'),
	(1, 102, 'Like', '2024-04-01 18:35:00'),
	(2, 103, 'Comment', '2024-04-05 20:00:00'),
	(2, 104, 'Share', '2024-04-05 20:05:00'),
	(3, 105, 'Tweet', '2024-04-10 16:00:00'),
	(3, 106, 'Like', '2024-04-10 16:05:00'),
	(4, 107, 'Comment', '2024-04-15 21:00:00'),
	(4, 108, 'Share', '2024-04-15 21:10:00'),
	(5, 109, 'Tweet', '2024-04-20 19:00:00'),
	(5, 110, 'Like', '2024-04-20 19:05:00'),
	(6, 111, 'Comment', '2024-04-25 20:00:00'),
	(6, 112, 'Share', '2024-04-25 20:10:00'),
	(7, 113, 'Tweet', '2024-05-01 18:00:00'),
	(7, 114, 'Like', '2024-05-01 18:05:00'),
	(8, 115, 'Comment', '2024-05-05 19:30:00'),
	(8, 116, 'Share', '2024-05-05 19:35:00'),
	(9, 117, 'Tweet', '2024-05-10 20:30:00'),
	(9, 118, 'Like', '2024-05-10 20:35:00'),
	(10, 119, 'Comment', '2024-05-15 21:45:00'),
	(10, 120, 'Share', '2024-05-15 21:50:00');




-- 1. Retrieve the Details of All Matches Played at a Specific Venue 'Wankhede Stadium'
select m.match_id, m.match_date, m.venue, t1.team_name as team1, t2.team_name as team2, t.team_name as winner_team
	from matches m
	join teams t on m.winner_team_id = t.team_id
	join teams t1 on m.team1_id = t1.team_id
	join teams t2 on m.team2_id = t2.team_id
	where venue = 'Wankhede Stadium';

-- 2. List the Players Who Are Older Than 30 Years and Have Played More Than 200 Matches
select player_name, age, matches_played from players where (age > 30) and (matches_played > 200);

-- 3. Display the Number of Matches Played with title 'Number of Matches' at Each Venue
select venue, count(match_id) as "Number of Matches" from Matches group by venue;

-- 4. Find the match dates and venues for matches where the winner was Mumbai Indians
select match_date, venue, t.team_name as winner_team from matches m
	join teams t on m.winner_team_id = t.team_id
	where t.team_name = 'Mumbai Indians';

-- 5. Retrieve details of all matches played by Mumbai Indians, and the match was won by a team other than Mumbai Indians.
select m.match_id, m.match_date, m.venue, t.team_name as winner_team, t1.team_name as team1, t2.team_name as team2
	from matches m
	join teams t on m.winner_team_id = t.team_id
	join teams t1 on m.team1_id = t1.team_id
	join teams t2 on m.team2_id = t2.team_id
	where (t1.team_name = 'Mumbai Indians' or t2.team_name = 'Mumbai Indians') 
		and (t.team_name != 'Mumbai Indians');

-- 6. Find the player who participated in the highest number of winning matches. Display the Player Name along with the total number of winning matches
with player_wining as (
	select p.player_name, count(m.winner_team_id) as total_winning_matches
		from players p
		join matches m on p.team_id = m.winner_team_id
		group by p.player_name
)
select player_name, total_winning_matches 
	from player_wining
	where total_winning_matches = (select max(total_winning_matches) from player_wining)
	order by total_winning_matches desc, player_name
	

-- limit 1
select p.player_name, count(m.winner_team_id) as total_winning_matches
	from players p
	join matches m on p.team_id = m.winner_team_id
	group by p.player_name
	order by total_winning_matches desc, p.player_name
	limit 1;
	

 -- 7. Determine the venue with the highest number of matches played and the total fan engagements at that venue. Display the Venue , Total Matches , Total Fan Engagements
with venue_matches as (
    select m.venue, count(m.match_id) as total_matches, count(f.engagement_id) as total_fan_engagements
	    from matches m
	    left join fan_engagement f on m.match_id = f.match_id
	    group by m.venue
)
select venue, total_matches, total_fan_engagements
	from venue_matches
	where total_matches = (select max(total_matches) from venue_matches)
	order by total_matches desc, venue;

-- limit 1
select m.venue, count(m.match_id) as total_matches, count(f.engagement_id) as total_fan_engagements
    from matches m
    left join fan_engagement f on m.match_id = f.match_id
    group by m.venue
	order by total_matches desc, venue
	limit 1;

-- 8.  Find the player who has the most fan engagements across all matches.Display the player name and the count of fan engagements
with player_engagement as (
	select p.player_name, count(f.engagement_id) as fan_engagements
		from players p
		join matches m on p.team_id = m.team1_id
		join matches m2 on p.team_id = m2.team2_id
		join fan_engagement f on m.match_id = f.match_id
		group by p.player_name
)
select player_name, fan_engagements 
	from player_engagement
	where fan_engagements = (select max(fan_engagements) from player_engagement)
	order by fan_engagements desc, player_name;

-- limit 1
select p.player_name, count(f.engagement_id) as fan_engagements
	from players p
	join matches m on p.team_id = m.team1_id
	join matches m2 on p.team_id = m2.team2_id
	join fan_engagement f on m.match_id = f.match_id
	group by p.player_name
	order by fan_engagements desc, p.player_name
	limit 1;
	

-- 9. Write an SQL query to find out which stadium and match had the highest fan engagement. The query should return the stadium name, match date, and the total number of fan engagements for that match, ordered by the latest match date
with stadium_engagement as (
	select m.venue, m.match_date, count(f.engagement_id) as total_fan_engagements
		from matches m
		join fan_engagement f on m.match_id = f.match_id
		group by m.venue, m.match_date
)
select venue, match_date, total_fan_engagements 
	from stadium_engagement
	where total_fan_engagements = (select max(total_fan_engagements) from stadium_engagement)
	order by total_fan_engagements desc, match_date desc;
	
-- limit 1
select m.venue, m.match_date, count(f.engagement_id) as total_fan_engagements
	from matches m
	join fan_engagement f on m.match_id = f.match_id
	group by m.venue, m.match_date
	order by total_fan_engagements desc, m.match_date desc
	limit 1;

-- 10. Generate a report for the "Mumbai Indians" that includes details for each match they played:
-- 		a. Match date.
-- 		b. Opposing team's name.
-- 		c. Venue.
-- 		d. Total number of fan engagements recorded during each match.
--		e. Name of the player from "Mumbai Indians" who has played the most matches up to the date of each match.
select 
    m.match_date,
    case 
        when t1.team_name = 'Mumbai Indians' then t2.team_name
        else t1.team_name
    end as opposing_team,
    m.venue,
    count(f.engagement_id) as total_fan_engagements,
    p.player_name as most_matches_player
from matches m
join teams t1 on m.team1_id = t1.team_id
join teams t2 on m.team2_id = t2.team_id
left join fan_engagement f on m.match_id = f.match_id
join (
    select p.player_name, p.team_id, max(p.matches_played) as max_matches
    from players p
    where p.team_id = 1 -- Assuming 'Mumbai Indians' has team_id = 1
    group by p.player_name, p.team_id
) as p on p.team_id = case 
                        when t1.team_name = 'Mumbai Indians' then t1.team_id
                        else t2.team_id
                     end
where t1.team_name = 'Mumbai Indians' or t2.team_name = 'Mumbai Indians'
group by m.match_date, opposing_team, m.venue, p.player_name
order by m.match_date;

select * from teams;
select * from players;
select * from matches;
select * from fan_engagement;

-- 11. Create a view named TopPerformers that shows the names of players, their teams, and the number of matches they have played, filtering only those who have played more than 100 matches.
create view TopPerformers as
	select p.player_name, t.team_name, p.matches_played
	from players p
	join teams t on p.team_id = t.team_id
	where p.matches_played > 100;

select * from TopPerformers

-- 12.  Create a view named MatchHighlights that displays the match date, teams involved, venue, and the winner of each match.

create view MatchHighlights as
	select m.match_date, t1.team_name as team1, t2.team_name as team2, m.venue, t.team_name as winner
	from matches m
	join teams t1 on m.team1_id = t1.team_id
	join teams t2 on m.team2_id = t2.team_id
	left join teams t on m.winner_team_id = t.team_id;

select * from MatchHighlights;

-- 13. Create a view named FanEngagementStats that summarizes the total engagements for each match, including match date and venue.
create view FanEngagementStats as
	select m.match_date, m.venue, count(f.engagement_id) as total_engagements
	from matches m
	left join fan_engagement f on m.match_id = f.match_id
	group by m.match_date, m.venue;

select * from FanEngagementStats;

-- 14. Create a view named TeamPerformance that shows each team's name, the number of matches played, and the number of matches won.
create view TeamPerformance as
	select t.team_name,
       (select count(*)
			from matches m 
			join teams t on m.team1_id = t.team_id
			join teams t2 on m.team2_id = t2.team_id
		) as matches_played,
       (select *
			from matches m 
			join teams t on m.winner_team_id = t.team_id
			group by t.team_name
	   ) as matches_won
		from teams t;

select * from TeamPerformance;

-- 15. Create a view named TeamEngagementSummary that summarizes fan engagements for each team per match, including:
-- Match date and venue.
-- Team names (both teams).
-- Total number of engagements for each team in each match.
-- The date of the team's most engaged match (highest engagement).
-- The fan ID who engaged the most during the team's most engaged match.
create view TeamEngagementSummary as
	select 
		m.match_date,
	    m.venue,
	    t1.team_name as team1,
	    t2.team_name as team2,
		sum(case when p1.team_id = m.team1_id or p2.team_id = m.team2_id then 1 else 0 end) as total_engagements,
	    max(m.match_date) as most_engaged_date,
	    max(f.fan_id) as most_engaged_fan_id
			from matches m
			join teams t1 on m.team1_id = t1.team_id
			join teams t2 on m.team2_id = t2.team_id
			left join fan_engagement f on m.match_id = f.match_id
			left join players p1 on p1.team_id = t1.team_id
			left join players p2 on p2.team_id = t2.team_id
			group by m.match_date, m.venue, t1.team_name, t2.team_name;

select * from TeamEngagementSummary;