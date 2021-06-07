SELECT a.CaseNumber AS "Case Number", Surname, a.GivenNames AS "Given Names", Gender.ItemText AS Sex, 
		CASE
			WHEN circ.SUDI = 0 THEN 'No'
			WHEN circ.SUDI = 1 THEN 'Yes'
		END AS SUDI,
		DATEPART(yyyy, d.DateOfDeath) as "Year of Death", FORMAT(a.DateOfBirth, 'dd-MM-yyyy') as "Date of Birth", 
		CASE
			WHEN d.DateOfDeath IS NULL THEN FORMAT(d.DateOfEvent, 'dd-MM-yyyy') 
			WHEN d.DateOfDeath IS NOT NULL THEN FORMAT(d.DateOfDeath, 'dd-MM-yyyy') 
		END AS "Date of Death",	
		"Age (years)", "Age (months)", "Age (days)", 

		CASE
			WHEN "Age (years)" < 18 AND "Age (years)" > 14 THEN '15 to 17 years'
			WHEN "Age (years)" < 15 AND "Age (years)" > 9 THEN '10 to 14 years'
			WHEN "Age (years)" < 10 AND "Age (years)" > 4 THEN '5 to 9 years'
			WHEN "Age (years)" < 5 AND "Age (years)" >= 1 THEN '1 to 4 years'
			WHEN "Age (months)" < 12 AND "Age (days)" >= 28 THEN '1 to 11 months'
			WHEN "Age (days)" < 28 THEN '< 28 days'
		END AS "Age Group",

		CASE
			WHEN Causes.Gestation = 0 THEN NULL
			ELSE Causes.Gestation
		END AS Gestation, 
		CASE
			WHEN Causes.BirthWeight = 0 THEN NULL
			ELSE Causes.BirthWeight
		END AS BirthWeight, 
		CASE
			WHEN Causes.LifeDuration = 0 THEN NULL
			ELSE Causes.LifeDuration
		END AS "Life Duration (minutes)", 
		
		CASE 
			WHEN cp.FSAContact = 0 THEN 'No'
			WHEN cp.FSAContact = 1 THEN 'Yes'
		END AS "CP Contact",
		cp.ContactHistorySummary AS "Summary of CP History",

		cb.ItemText AS "Cultural Background",
		
		CASE 
			WHEN c.ItemText = 'accidental' THEN 'accident'
			WHEN c.ItemText = 'unascertained' THEN 'undetermined'
			ELSE c.ItemText
		END AS "COD Category",

		REPLACE(REPLACE(Causes.CauseOfDeath, CHAR(13), ' '), CHAR(10), ' ') AS "Cause of Death",
		REPLACE(REPLACE(circ.HarmDescription, CHAR(13), ' '), CHAR(10), ' ') AS "Circumstances of harm",
		css."Description" AS "Case Status", 
		CASE
			WHEN Investigations.CoronialItemsExist IS NULL THEN 'No'
			WHEN Investigations.CoronialItemsExist = 0 THEN 'No'
			WHEN Investigations.CoronialItemsExist = 1 THEN 'Yes'
		END AS "Coronial case?"

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
WHERE StatusAtEvent.ItemText = 'deceased' AND DATEPART(yyyy, d.DateOfDeath) >= 2005 AND "Age (years)" < 18
ORDER BY "Case Number"
;