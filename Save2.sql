use retrosheet;

# get the initial  state of the saving pitcher for each game
SELECT e.game_ID as 'gID', ABS(g.AWAY_SCORE_CT - g.HOME_SCORE_CT) AS 'scoreDiff', e.INN_CT AS 'inning', e.OUTS_CT as 'Current Outs', IF(e.BASE1_RUN_ID = '', 0,1)  as 'onFirst', IF(e.BASE2_RUN_ID = '', 0,1)  as 'onSecond', IF(e.BASE2_RUN_ID = '', 0,1)  as 'onThird', e.pit_id as 'pID', concat(r.first_name_tx, ' ' , r.last_name_tx) as 'name'
FROM games g
left JOIN events e ON e.pit_id = g.save_pit_id AND e.game_ID = g.game_ID
left join rosters r on r.player_ID = g.save_pit_id;

# get last pitching sub from each team for each game    
select s.* from subs s
inner join (
	select GAME_ID, BAT_HOME_ID, max(EVENT_ID) EVENT_ID from subs
	where sub_fld_cd = 1 and removed_fld_cd = 1
    group by GAME_ID, BAT_HOME_ID
) sp on sp.GAME_ID = s.GAME_ID and sp.EVENT_ID = s.EVENT_ID
order by s.GAME_ID, s.BAT_HOME_ID;

# get initial state for each last pitcher for each game
select e.* from events e
inner join (
	select GAME_ID, BAT_HOME_ID, max(EVENT_ID) EVENT_ID from subs
	where sub_fld_cd = 1 and removed_fld_cd = 1
    group by GAME_ID, BAT_HOME_ID
) s on s.game_id = e.game_id and s.event_id+1 = e.event_id


