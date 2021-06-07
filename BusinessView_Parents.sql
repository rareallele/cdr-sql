SELECT 
	a.CaseNumber AS "Case Number",

	MAX(CASE WHEN r.ItemText = 'Mother' THEN c.Surname END) AS 'Mother''s Surname',
	MAX(CASE WHEN r.ItemText = 'Mother' THEN c.GivenNames END) AS 'Mother''s Given Names',
	MAX(CASE WHEN r.ItemText = 'Mother' THEN FORMAT(c.DateOfBirth, 'dd-MM-yyyy') END) AS 'Mother''s DOB',

	MAX(CASE WHEN r.ItemText = 'Father' THEN c.Surname END) AS 'Father''s Surname',
	MAX(CASE WHEN r.ItemText = 'Father' THEN c.GivenNames END) AS 'Father''s Given Names',
	MAX(CASE WHEN r.ItemText = 'Father' THEN FORMAT(c.DateOfBirth, 'dd-MM-yyyy') END) AS 'Father''s DOB'

FROM CDRCase a
LEFT JOIN Carers c
ON a.ID = c.CaseID
LEFT JOIN Relationship r
ON c.RelationshipID = r.ID
LEFT JOIN StatusAtEvent ON a.StatusAtEventID = StatusAtEvent.ID
WHERE StatusAtEvent.ItemText = 'deceased'
GROUP BY a.CaseNumber
