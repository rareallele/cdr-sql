SELECT a.CaseNumber AS "Case Number",
		"Age (years)", "Age (months)", "Age (days)", 
		
		CASE 
			WHEN cp.FSAContact = 0 THEN 'No'
			WHEN cp.FSAContact = 1 THEN 'Yes'
		END AS "CP Contact",

		REPLACE(REPLACE(cp.ContactHistorySummary, CHAR(13), ' '), CHAR(10), ' ') AS "Summary of CP History",

		cb.ItemText AS "Cultural Background",

		REPLACE(REPLACE(Causes.CauseOfDeath, CHAR(13), ' '), CHAR(10), ' ') AS "Cause of Death",
		REPLACE(REPLACE(circ.HarmDescription, CHAR(13), ' '), CHAR(10), ' ') AS "Circumstances of harm",
		REPLACE(REPLACE(SUBSTRING(circ.HarmDescription,1,2800), CHAR(13), ' '), CHAR(10), ' ') AS "Circumstances of harm 1",
		REPLACE(REPLACE(SUBSTRING(circ.HarmDescription,2801,8000), CHAR(13), ' '), CHAR(10), ' ') AS "Circumstances of harm 2",
		REPLACE(REPLACE(SUBSTRING(cp.ContactHistorySummary,1,2800), CHAR(13), ' '), CHAR(10), ' ') AS "Summary of CP History 1",
		REPLACE(REPLACE(SUBSTRING(cp.ContactHistorySummary,2801,8000), CHAR(13), ' '), CHAR(10), ' ') AS "Summary of CP History 2"

FROM CDRCase a
LEFT JOIN StatusAtEvent ON a.StatusAtEventID = StatusAtEvent.ID
LEFT JOIN Gender
ON a.GenderID = Gender.ID
LEFT JOIN Circumstances circ
ON a.ID = circ.CaseID
LEFT JOIN CauseOfDeathCategories c
ON circ.CauseOfDeathCategoryID = c.ID
LEFT JOIN AgeSiblings d
ON a.ID = d.CaseID
OUTER APPLY 
	(
	SELECT 
	DATEDIFF(year, DateOfBirth, DateOfDeath) -
		CASE
			WHEN DATEADD(year, DATEDIFF(year, DateOfBirth, DateOfDeath), DateOfBirth)
				> DateOfDeath THEN 1
			ELSE 0
		END AS "Age (years)",
	DATEDIFF(month, DateOfBirth, DateOfDeath) -
		CASE
			WHEN DATEADD(month, DATEDIFF(month, DateOfBirth, DateOfDeath), DateOfBirth)
				> DateOfDeath THEN 1
			ELSE 0
		END AS "Age (months)",
	DATEDIFF(day, DateOfBirth, DateOfDeath) -
		CASE
			WHEN DATEADD(day, DATEDIFF(day, DateOfBirth, DateOfDeath), DateOfBirth)
				> DateOfDeath THEN 1
			ELSE 0
		END AS "Age (days)") 
		AS age
LEFT JOIN Causes 
ON a.ID = Causes.CaseID
LEFT JOIN ContactHistory cp
ON a.ID = cp.CaseID
LEFT JOIN Residence res
ON a.ID = res.CaseID 
LEFT JOIN CulturalBackground cb 
ON res.CulturalBackgroundID = cb.ID
LEFT JOIN AddressStatus 
ON res.AddressStatusID = AddressStatus.ID
LEFT JOIN CommSystemStatus css
ON a.CommSystemStatusID = css.ID
LEFT JOIN Investigations
ON a.ID = Investigations.CaseID
WHERE StatusAtEvent.ItemText = 'deceased'
AND css."Description" = 'Information entered, waiting CIS/coroner records'
ORDER BY "Case Number"
;