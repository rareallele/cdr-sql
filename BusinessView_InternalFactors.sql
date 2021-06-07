SELECT 
	a.CaseNumber AS "Case Number",
	MAX(intf.Synopsis) AS "Summary of internal factors",
	MAX(CASE 
		WHEN intf.IntFactorsExist = 0 THEN 'No'
		WHEN intf.IntFactorsExist = 1 THEN 'Yes'
	END) AS "1 - Internal factors exist?",
	MAX(CASE WHEN ii.ItemText = 'Baby <1 year at time of event' THEN 'Yes' ELSE 'No' END) AS "Baby <1 year at time of event",
	MAX(CASE WHEN ii.ItemText = 'Indications of psychological problems' THEN 'Yes' ELSE 'No' END) AS "Indications of psychological problems",
	MAX(CASE WHEN ii.ItemText = 'Drug/alcohol issues' THEN 'Yes' ELSE 'No' END) AS "Drug/alcohol issues",
	MAX(CASE WHEN ii.ItemText = 'Challenging behaviours' THEN 'Yes' ELSE 'No' END) AS "Challenging behaviours",
	MAX(CASE WHEN ii.ItemText = 'Incidents of abuse/neglect' THEN 'Yes' ELSE 'No' END) AS "Incidents of abuse/neglect",
	MAX(CASE WHEN ii.ItemText = 'Criminal activities' THEN 'Yes' ELSE 'No' END) AS "Criminal activities",
	MAX(CASE WHEN ii.ItemText = 'Other' THEN 'Yes' ELSE 'No' END) AS "Other",
	MAX(CASE WHEN ii.ItemText = 'Premature birth/unusual weight for gestational age' THEN 'Yes' ELSE 'No' END) AS "Premature birth/unusual weight for gestational age",
	MAX(CASE WHEN ii.ItemText = 'Illness/medical condition' THEN 'Yes' ELSE 'No' END) AS "Illness/medical condition",
	MAX(CASE WHEN ii.ItemText = 'School-related problems' THEN 'Yes' ELSE 'No' END) AS "School-related problems",
	MAX(CASE WHEN ii.ItemText = 'Learning disorder' THEN 'Yes' ELSE 'No' END) AS "Learning disorder",
	MAX(CASE WHEN ii.ItemText = 'Child born substance dependent' THEN 'Yes' ELSE 'No' END) AS "Child born substance dependent",
	MAX(CASE WHEN ii.ItemText = 'Multiple births' THEN 'Yes' ELSE 'No' END) AS "Multiple births",
	MAX(CASE WHEN ii.ItemText = 'Intellectual/physical disability' THEN 'Yes' ELSE 'No' END) AS "Intellectual/physical disability",
	MAX(CASE WHEN ii.ItemText = 'GOM/VCA' THEN 'Yes' ELSE 'No' END) AS "GOM/VCA",
	MAX(CASE WHEN ii.ItemText = 'Issues of sexual orientation' THEN 'Yes' ELSE 'No' END) AS "Issues of sexual orientation",
	MAX(CASE WHEN ii.ItemText = 'Early difficulties feeding/sleeping/excessive crying' THEN 'Yes' ELSE 'No' END) AS "Early difficulties feeding/sleeping/excessive crying"

FROM CDRCase a
LEFT JOIN IntFactors intf 
ON a.ID = intf.CaseID
LEFT JOIN IntFactorsIssues ifi
ON intf.CaseID = ifi.CaseID
LEFT JOIN IntIssues ii
ON ifi.IntIssuesID = ii.ID

GROUP BY a.CaseNumber
;