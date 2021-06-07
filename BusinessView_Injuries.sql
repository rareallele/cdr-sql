SELECT a.CaseNumber AS "Case Number", a.Surname, a.GivenNames AS "Given Names", 
	FORMAT(a.DateOfBirth, 'dd-MM-yyyy') AS "Date of Birth",
	FORMAT(d.DateOfEvent, 'dd-MM-yyyy') AS "Date of Event"

FROM CDRCase a
LEFT JOIN StatusAtEvent ON a.StatusAtEventID = StatusAtEvent.ID
LEFT JOIN AgeSiblings d
ON a.ID = d.CaseID

WHERE StatusAtEvent.Itemtext = 'seriously injured'
