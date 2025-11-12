SELECT
a.accomNo AS "Accommodation No",
a.address1 AS "Address",
a.city AS "City",
a.postCode AS "Post Code",
CASE
WHEN f.accomNo IS NOT NULL THEN 'Flat'
WHEN h.accomNo IS NOT NULL THEN 'Hall'
ELSE NULL
END AS "Type",
f.ownersName AS "Owner's Name",
f.ownersTelNo AS "Owner's Tel No",
h.hName AS "Hall Name",
h.mgrStaffNo AS "Manager Staff No"
FROM
accommodation a
INNER JOIN hall h ON
a.accomNo = h.accomNo
INNER JOIN flat f ON
a.accomNo = f.accomNo;
