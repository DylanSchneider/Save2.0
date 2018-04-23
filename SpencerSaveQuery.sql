use retrosheet;
    
SELECT e.game_ID, ABS(g.AWAY_SCORE_CT - g.HOME_SCORE_CT) AS ScoreDiff, e.INN_CT AS Inning, e.OUTS_CT as 'Current Outs', e.BASE1_RUN_ID, e.BASE2_RUN_ID, e.BASE3_RUN_ID, e.pit_id
FROM games g
JOIN events e ON e.pit_id = g.save_pit_id AND e.game_ID = g.game_ID;

