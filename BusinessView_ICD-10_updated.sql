SELECT a.CaseNumber AS "Case Number",
	MAX(icd.ItemText) AS Cause,
	
	MAX(circ.ICD10_CauseCodeID) AS Chapter,
	MAX(icdcc.ItemText) AS "Chapter description",

	MAX(CASE WHEN cct.ItemText = 'Underlying COD' THEN icd.CauseCode END) AS "Underlying COD",
	MAX(CASE WHEN cct.ItemText = 'Main fetal condition' THEN icd.CauseCode END) AS "Main fetal condition",
	MAX(CASE WHEN cct.ItemText = 'Main COD 1a - 1' THEN icd.CauseCode END) AS "Main COD 1a - 1",
	MAX(CASE WHEN cct.ItemText = 'Main COD 1a - 2' THEN icd.CauseCode END) AS "Main COD 1a - 2",
	MAX(CASE WHEN cct.ItemText = 'Main COD 1b - 1' THEN icd.CauseCode END) AS "Main COD 1b - 1",
	MAX(CASE WHEN cct.ItemText = 'Main COD 1b - 2' THEN icd.CauseCode END) AS "Main COD 1b - 2",
	MAX(CASE WHEN cct.ItemText = 'Main COD 1d' THEN icd.CauseCode END) AS "Main COD 1d",
	MAX(CASE WHEN cct.ItemText = 'Main COD 1c - 1' THEN icd.CauseCode END) AS "Main COD 1c - 1",
	MAX(CASE WHEN cct.ItemText = 'Other fetal conditions - 1' THEN icd.CauseCode END) AS "Other fetal conditions - 1",
	MAX(CASE WHEN cct.ItemText = 'Main COD 2' THEN icd.CauseCode END) AS "Main COD 2",
	MAX(CASE WHEN cct.ItemText = 'Other maternal conditions - 1' THEN icd.CauseCode END) AS "Other maternal conditions - 1",
	MAX(CASE WHEN cct.ItemText = 'Main COD 1b - 3' THEN icd.CauseCode END) AS "Main COD 1b - 3",
	MAX(CASE WHEN cct.ItemText = 'Main COD 1c - 3' THEN icd.CauseCode END) AS "Main COD 1c - 3",
	MAX(CASE WHEN cct.ItemText = 'Maind COD 1c - 2' THEN icd.CauseCode END) AS "Main COD 1c - 2",
	MAX(CASE WHEN cct.ItemText = 'Main maternal condition' THEN icd.CauseCode END) AS "Main maternal condition",
	MAX(CASE WHEN cct.ItemText = 'Other maternal conditions - 2' THEN icd.CauseCode END) AS "Other maternal conditions - 2",
	MAX(CASE WHEN cct.ItemText = 'Main COD 1a - 3' THEN icd.CauseCode END) AS "Main COD 1a - 3",
	MAX(CASE WHEN cct.ItemText = 'Other fetal conditions - 2' THEN icd.CauseCode END) AS "Other fetal conditions - 2",
	MAX(CASE WHEN cct.ItemText = 'Activity code' THEN icd.CauseCode END) AS "Activity code",
	MAX(CASE WHEN cct.ItemText = 'Place of occurrence code' THEN icd.CauseCode END) AS "Place of occurrence code",
	MAX(CASE WHEN cct.ItemText = 'Other fetal conditions - 3' THEN icd.CauseCode END) AS "Other fetal conditions - 3",
	MAX(CASE WHEN cct.ItemText = 'Other relevant circumstances' THEN icd.CauseCode END) AS "Other relevant circumstances"

FROM CDRCase a
LEFT JOIN Circumstances circ
ON a.ID = circ.CaseID
LEFT JOIN ICD10Causes icd
ON circ.CaseID = icd.CaseID
LEFT JOIN CauseCodeType cct
ON icd.CauseCodeTypeID = cct.ID
LEFT JOIN ICD10CauseCode icdcc
ON circ.ICD10_CauseCodeID = icdcc.ID

GROUP BY a.CaseNumber
ORDER BY a.CaseNumber
;