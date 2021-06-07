SELECT 
	a.CaseNumber AS "Case Number",
	MAX(e.Synopsis) AS "Summary of external factors",
	MAX(CASE 
		WHEN e.ExtFactorsExist = 0 THEN 'No'
		WHEN e.ExtFactorsExist = 1 THEN 'Yes'
	END) AS "1 - External factors exist?",
	MAX(CASE WHEN ei.ItemText = 'Drug, alcohol life-style' THEN 'Yes' ELSE 'No' END) AS "Drug, alcohol life-style",
	MAX(CASE WHEN ei.ItemText = 'Mother/parents <25 years' THEN 'Yes' ELSE 'No' END) AS "Mother/parents <25 years",
	MAX(CASE WHEN ei.ItemText = 'Cultural/religious/languge issues' THEN 'Yes' ELSE 'No' END) AS "Cultural/religious/languge issues",
	MAX(CASE WHEN ei.ItemText = 'Domestic violence issues' THEN 'Yes' ELSE 'No' END) AS "Domestic violence issues",
	MAX(CASE WHEN ei.ItemText = 'Family breakdown, conflict, isolation' THEN 'Yes' ELSE 'No' END) AS "Family breakdown, conflict, isolation",
	MAX(CASE WHEN ei.ItemText = 'GOM/VCA for child or siblings' THEN 'Yes' ELSE 'No' END) AS "GOM/VCA for child or siblings",
	MAX(CASE WHEN ei.ItemText = 'Bullying in school/neigbourhood' THEN 'Yes' ELSE 'No' END) AS "Bullying in school/neigbourhood",
	MAX(CASE WHEN ei.ItemText = 'Carers involved in criminal activity' THEN 'Yes' ELSE 'No' END) AS "Carers involved in criminal activity",
	MAX(CASE WHEN ei.ItemText = 'Carers unable to meet child''s special needs' THEN 'Yes' ELSE 'No' END) AS "Carers unable to meet child's special needs",
	MAX(CASE WHEN ei.ItemText = 'Freqent changes of school' THEN 'Yes' ELSE 'No' END) AS "Freqent changes of school",
	MAX(CASE WHEN ei.ItemText = 'Homelessness, accomodation difficulties' THEN 'Yes' ELSE 'No' END) AS "Homelessness, accomodation difficulties",
	MAX(CASE WHEN ei.ItemText = 'Unemployment, financial stress' THEN 'Yes' ELSE 'No' END) AS "Unemployment, financial stress",
	MAX(CASE WHEN ei.ItemText = 'Carers'' history of abuse' THEN 'Yes' ELSE 'No' END) AS "Carers' history of abuse",
	MAX(CASE WHEN ei.ItemText = 'Carers'' history of mental, physical, intellectual,' THEN 'Yes' ELSE 'No' END) AS "Carers' history of mental, physical, intellectual,",
	MAX(CASE WHEN ei.ItemText = 'Family history of displacement or upheaval' THEN 'Yes' ELSE 'No' END) AS "Family history of displacement or upheaval",
	MAX(CASE WHEN ei.ItemText = 'Interstate migration within past 3 years' THEN 'Yes' ELSE 'No' END) AS "Interstate migration within past 3 years",
	MAX(CASE WHEN ei.ItemText = 'Prior death of sibling' THEN 'Yes' ELSE 'No' END) AS "Prior death of sibling",
	MAX(CASE WHEN ei.ItemText = 'Other' THEN 'Yes' ELSE 'No' END) AS "Other"
	
FROM CDRCase a
LEFT JOIN ExtFactors e
ON a.ID = e.CaseID
LEFT JOIN ExtFactorsIssues efi
ON e.CaseID = efi.CaseID
LEFT JOIN ExtIssues ei
ON efi.ExtIssuesID = ei.ID

GROUP BY a.CaseNumber
;