SELECT a.CaseNumber AS "Case Number",
	   AddressStatus.ItemText AS "Residential Status", 
	   res.Address1 AS "Address", res.City AS Suburb, CAST(res.Postcode AS CHAR(4)) as Postcode, res."State" AS "State", 
	   a.PlaceOfBirth AS "Place of Birth",
	   c.PlaceOfEvent AS "Place of Event", c.PlaceOfDeath AS "Place of Death",
	   res.LivingArrangements

FROM CDRCase a
LEFT JOIN Residence res
ON a.ID = res.CaseID
LEFT JOIN AddressStatus 
ON res.AddressStatusID = AddressStatus.ID
LEFT JOIN StatusAtEvent 
ON a.StatusAtEventID = StatusAtEvent.ID
LEFT JOIN Causes c
ON a.ID = c.CaseID
WHERE StatusAtEvent.ItemText = 'deceased';