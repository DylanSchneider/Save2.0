use retrosheet;

SELECT 
    g.game_id, CONCAT(r.first_name_tx, ' ', r.last_name_tx) as 'Save Pitcher'
FROM
    games g
        JOIN
    rosters r ON g.save_pit_id = r.player_id;