SELECT a.CaseNumber AS "Case Number",
	CASE
		WHEN f.Reviewable = 0 THEN 'No'
		WHEN f.Reviewable = 1 THEN 'Yes'
	END AS "Reviewable under the act?", 
	CASE
		WHEN rr.AbuseOrNeglect = 0 THEN 'No'
		WHEN rr.AbuseOrNeglect = 1 THEN 'Yes'
	END AS "Review reason - Abuse or Neglect",
	CASE
		WHEN rr.Preventable = 0 THEN 'No'
		WHEN rr.Preventable = 1 THEN 'Yes'
	END AS "Review reason - Preventable",
	CASE
		WHEN rr.PriorNotification = 0 THEN 'No'
		WHEN rr.PriorNotification = 1 THEN 'Yes'
	END AS "Review reason - Prior Notification",
	CASE
		WHEN rr.InStateCare = 0 THEN 'No'
		WHEN rr.InStateCare = 1 THEN 'Yes'
	END AS "Review reason - In State Care",
	 CASE
		WHEN rr.CoronialReferral = 0 THEN 'No'
		WHEN rr.CoronialReferral = 1 THEN 'Yes'
	END AS "Review reason - Coronial Referral"
FROM CDRCase a
LEFT JOIN Findings f
ON a.ID = f.CaseID
LEFT JOIN ReviewReasons rr
ON f.CaseID = rr.CaseID
LEFT JOIN StatusAtEvent 
ON a.StatusAtEventID = StatusAtEvent.ID
WHERE StatusAtEvent.ItemText = 'deceased'; 