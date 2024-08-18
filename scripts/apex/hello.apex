// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents
List<Contact> contacts = [
  SELECT
    CreatedDate,
    (
      SELECT CreatedDate
      FROM Opportunities
      WHERE Name = 'Advanced Training' AND StageName = 'Prospecting'
    ),
    (SELECT CreatedDate, Subject, Priority, WhatId FROM Tasks),
    (
      SELECT CreatedDate
      FROM Cases
      WHERE Subject = 'Class Survey' AND Status = 'New' AND Priority = 'Low'
    )
  FROM Contact
  WHERE
    (FirstName = 'Emily'
    OR LastName = 'Emily')
    AND (FirstName = 'Cloudshine'
    OR LastName = 'Cloudshine')
    AND CreatedById = '005aj0000075ZzsAAE'
  ORDER BY CreatedDate DESC
];

System.debug(contacts);

List<Contact> contacts = [
  SELECT CreatedDate
  FROM Contact
  WHERE
    (FirstName = 'Emily'
    OR LastName = 'Emily')
    AND (FirstName = 'Cloudshine'
    OR LastName = 'Cloudshine')
    AND CreatedById = '005aj0000075ZzsAAE'
  ORDER BY CreatedDate DESC
];
