﻿CREATE TABLE webpages_Roles (
  RoleId  int NOT NULL PRIMARY KEY IDENTITY,
  RoleName nvarchar(256)NOT NULL UNIQUE, 
    [OldRoleID] UNIQUEIDENTIFIER NULL)