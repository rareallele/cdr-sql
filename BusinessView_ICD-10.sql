SELECT a.CaseNumber AS "Case Number",
	MAX(icd.ItemText) AS Cause,
	
	MIN(CASE WHEN icd.CauseCode between 'A000' and 'B999' THEN
		1
	WHEN icd.CauseCode between 'C000' and 'D489' THEN
		2
	WHEN icd.CauseCode between 'D500' and 'D899' THEN
		3
	WHEN icd.CauseCode between 'E000' and 'E909' THEN
		4
	WHEN icd.CauseCode between 'F000' and 'F999' THEN
		5
	WHEN icd.CauseCode between 'G000' and 'G999' THEN
		6
	WHEN icd.CauseCode between 'H000' and 'H599' THEN
		7
	WHEN icd.CauseCode between 'H600' and 'H959' THEN
		8
	WHEN icd.CauseCode between 'I000' and 'I999' THEN
		9
	WHEN icd.CauseCode between 'J00.' and 'J999' THEN
		10
	WHEN icd.CauseCode between 'K000' and 'K939' THEN
		11
	WHEN icd.CauseCode between 'L000' and 'L999' THEN
		12
	WHEN icd.CauseCode between 'M000' and 'M999' THEN
		13
	WHEN icd.CauseCode between 'N000' and 'N999' THEN
		14
	WHEN icd.CauseCode between 'O000' and 'O999' THEN
		15 
	WHEN icd.CauseCode between 'P000' and 'P969' THEN
		16
	WHEN icd.CauseCode between 'Q000' and 'Q999' THEN
		17
	WHEN icd.CauseCode between 'R000' and 'R999' THEN
		18
	WHEN icd.CauseCode between 'S000' and 'T989' THEN
		19
	WHEN icd.CauseCode between 'V010' and 'Y989' THEN
		20
	WHEN icd.CauseCode between 'Z000' and 'Z999' THEN
		21
	WHEN icd.CauseCode between 'U000' and 'U999' THEN
		22
	WHEN icd.CauseCode is NULL OR icd.CauseCode = '' THEN
		NULL
	WHEN icd.CauseCode between '0' and '9' THEN
		999
	ELSE
		991
	END) AS Chapter,

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

GROUP BY a.CaseNumber
ORDER BY a.CaseNumber
;