WITH phase_stats AS (
    SELECT
        t.phase,
        COUNT(*) AS total_patients,
        SUM(CASE WHEN LOWER(e.status) = 'completed' THEN 1 ELSE 0 END) AS completed_patients,
        SUM(CASE WHEN LOWER(e.status) = 'dropped' THEN 1 ELSE 0 END) AS dropped_patients
    FROM trials t
    JOIN enrollments e
      ON t.trial_id = e.trial_id
    GROUP BY t.phase
)
SELECT
    phase,
    total_patients,
    completed_patients,
    dropped_patients,
    ROUND(completed_patients * 100.0 / total_patients, 2) AS completion_rate_pct,
    ROUND(dropped_patients * 100.0 / total_patients, 2) AS dropout_rate_pct
FROM phase_stats
ORDER BY phase;
