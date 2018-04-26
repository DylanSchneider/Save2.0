use retrosheet;
    
SELECT e.game_ID as 'gID', ABS(g.AWAY_SCORE_CT - g.HOME_SCORE_CT) AS 'scoreDiff', e.INN_CT AS 'inning', e.OUTS_CT as 'Current Outs', e.BASE1_RUN_ID as 'onFirst', e.BASE2_RUN_ID as 'onSecond', e.BASE3_RUN_ID as 'onThird', e.pit_id as 'pID', concat(r.first_name_tx, ' ' , r.last_name_tx) as 'name'
FROM games g
left JOIN events e ON e.pit_id = g.save_pit_id AND e.game_ID = g.game_ID
left join rosters r on r.player_ID = g.save_pit_id;

select * from events;
select * from subs limit 10;
select * from lkup_cd_fld;
select * from lkup_lineup_id;


select game_id, save_pit_id from games g where save_pit_id <> ''  order by game_id;

select s.* from subs s where s.sub_fld_cd = 1 and s.removed_fld_cd = 1 and s.SUB_LINEUP_ID = 0 ;

select s.GAME_ID, s.INN_CT, s.BAT_HOME_ID, s.SUB_ID, s.SUB_FLD_CD, s.REMOVED_FLD_CD, s.EVENT_ID from subs s
inner join (
	select GAME_ID, max(INN_CT) INN_CT, BAT_HOME_ID from subs 
    group by GAME_ID, BAT_HOME_ID
) sp on sp.game_id = s.GAME_ID and sp.INN_CT = s.INN_CT;

select GAME_ID, max(INN_CT) INN_CT, BAT_HOME_ID from subs 
    group by GAME_ID, BAT_HOME_ID;
    

select e.* from events e
inner join subs s on s.game_id = e.game_id and s.event_id+1 = e.event_id
where s.sub_fld_cd = 1 and s.removed_fld_cd = 1 order by s.game_id, s.bat_home_id;

select concat(r.first_name_tx, ' ', r.last_name_tx) from rosters r
where r.player_id = 'jepsk001'


DROP TABLE IF EXISTS PitchingSubs;
CREATE TABLE PitchingSubs AS
	SELECT COUNT(*) as wonGame, e.bat_team_id as battingTeam 
		FROM events e
        JOIN games g on g.game_id = e.game_id
			WHERE ((e.away_score_ct > e.home_score_ct AND e.inn_ct = 7 and e.leadoff_fl = 'T' AND e.bat_team_id = e.AWAY_TEAM_ID 
				AND g.AWAY_SCORE_CT > g.HOME_SCORE_CT) OR 
				(e.away_score_ct < (e.home_score_ct + e.EVENT_RUNS_CT) AND e.inn_ct = 6 and e.inn_end_fl = 'T' AND e.bat_team_id = e.home_team_id
				AND g.HOME_SCORE_CT > g.AWAY_SCORE_CT)
                )
            
			GROUP BY e.bat_team_id;