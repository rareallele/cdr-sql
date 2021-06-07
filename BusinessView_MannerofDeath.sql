SELECT a.CaseNumber AS "Case Number",
	 sal.StatusActivityDetails AS "Manner of Death"
	
FROM CDRCase a
LEFT JOIN StatusActivityList sal
ON a.ID = sal.CaseID

WHERE sal.StatusActivityDetails LIKE '%Manner of%'
ORDER BY a.CaseNumber
;