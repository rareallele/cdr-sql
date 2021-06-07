SELECT a.CaseNumber AS "Case Number",
 
 MAX(CASE WHEN cct.ItemText = 'Disability Register 11' THEN 'Yes' 
		  WHEN cct.ItemText IS NULL THEN NULL 
		  ELSE 'No' END) AS "Disability Register",
 MAX(CASE WHEN cct.ItemText = '12 Neurodegen, genetic, birth defect 12' THEN 'Yes' 
		  WHEN cct.ItemText IS NULL THEN NULL 
		  ELSE 'No' END) AS "Neurodegen, genetic, birth defect",
 MAX(CASE WHEN cct.ItemText = '13 Cerebral palsy 13' THEN 'Yes' 
		  WHEN cct.ItemText IS NULL THEN NULL 
		  ELSE 'No' END) AS "Cerebral palsy",
 MAX(CASE WHEN cct.ItemText = '14 Epilepsy 14' THEN 'Yes' 
		  WHEN cct.ItemText IS NULL THEN NULL 
		  ELSE 'No' END) AS "Epilepsy",
 MAX(CASE WHEN cct.ItemText = '15 Heart and circ 15' THEN 'Yes' 
		  WHEN cct.ItemText IS NULL THEN NULL 
		  ELSE 'No' END) AS "Heart and circulatory",
 MAX(CASE WHEN cct.ItemText = '16 Intellectual disability (primary) 16' THEN 'Yes' 
		  WHEN cct.ItemText IS NULL THEN NULL 
		  ELSE 'No' END) AS "Intellectual disability (primary)",
 MAX(CASE WHEN cct.ItemText = '17 Other disability 17' THEN 'Yes' 
		  WHEN cct.ItemText IS NULL THEN NULL 
		  ELSE 'No' END) AS "Other disability",
 MAX(CASE WHEN cct.ItemText = '18 Autism 18' THEN 'Yes' 
		  WHEN cct.ItemText IS NULL THEN NULL 
		  ELSE 'No' END) AS "Autism",
 MAX(CASE WHEN cct.ItemText = '19 Disabiling medical condition 19' THEN 'Yes' 
		  WHEN cct.ItemText IS NULL THEN NULL 
		  ELSE 'No' END) AS "Disabling medical condition"

FROM CDRCase a
LEFT JOIN Circumstances circ
ON a.ID = circ.CaseID
LEFT JOIN ICD10Causes icd
ON circ.CaseID = icd.CaseID
LEFT JOIN CauseCodeType cct
ON icd.CauseCodeTypeID = cct.ID
GROUP BY a.CaseNumber
;
