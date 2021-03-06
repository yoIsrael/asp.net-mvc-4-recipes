﻿/*
Deployment script for Ch7SharedDatabase

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Ch7SharedDatabase"
:setvar DefaultFilePrefix "Ch7SharedDatabase"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
The column [dbo].[Artist].[ArtistDisplayName] is being dropped, data loss could occur.

The column [dbo].[Artist].[Bio] is being dropped, data loss could occur.

The column [dbo].[Artist].[MusicalInfluences] is being dropped, data loss could occur.

The column [dbo].[Artist].[ProfileCreateDate] is being dropped, data loss could occur.

The column [dbo].[Artist].[UserId] is being dropped, data loss could occur.

The column [dbo].[Artist].[UserName] on table [dbo].[Artist] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [dbo].[Artist])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping DF__tmp_ms_xx__Profi__10216507...';


GO
ALTER TABLE [dbo].[Artist] DROP CONSTRAINT [DF__tmp_ms_xx__Profi__10216507];


GO
PRINT N'Dropping DF__tmp_ms_xx__Profi__11158940...';


GO
ALTER TABLE [dbo].[Artist] DROP CONSTRAINT [DF__tmp_ms_xx__Profi__11158940];


GO
PRINT N'Dropping DF__tmp_ms_xx__Conta__1209AD79...';


GO
ALTER TABLE [dbo].[Artist] DROP CONSTRAINT [DF__tmp_ms_xx__Conta__1209AD79];


GO
PRINT N'Dropping DF__tmp_ms_xx__Profi__12FDD1B2...';


GO
ALTER TABLE [dbo].[Artist] DROP CONSTRAINT [DF__tmp_ms_xx__Profi__12FDD1B2];


GO
PRINT N'Dropping DF__tmp_ms_xx__Ratin__13F1F5EB...';


GO
ALTER TABLE [dbo].[Artist] DROP CONSTRAINT [DF__tmp_ms_xx__Ratin__13F1F5EB];


GO
PRINT N'Dropping DF__Artist__FileUplo__69C6B1F5...';


GO
ALTER TABLE [dbo].[Artist] DROP CONSTRAINT [DF__Artist__FileUplo__69C6B1F5];


GO
PRINT N'Dropping DF__Artist__FileUplo__6ABAD62E...';


GO
ALTER TABLE [dbo].[Artist] DROP CONSTRAINT [DF__Artist__FileUplo__6ABAD62E];


GO
PRINT N'Dropping FK_Media_ToTable...';


GO
ALTER TABLE [dbo].[Media] DROP CONSTRAINT [FK_Media_ToTable];


GO
PRINT N'Dropping FK_ArtistBand_ToArtist...';


GO
ALTER TABLE [dbo].[ArtistBand] DROP CONSTRAINT [FK_ArtistBand_ToArtist];


GO
PRINT N'Dropping FK_ArtistCollaborationSpaces_ToTable...';


GO
ALTER TABLE [dbo].[ArtistCollaborationSpaces] DROP CONSTRAINT [FK_ArtistCollaborationSpaces_ToTable];


GO
PRINT N'Dropping FK_PlayList_Artist...';


GO
ALTER TABLE [dbo].[PlayList] DROP CONSTRAINT [FK_PlayList_Artist];


GO
PRINT N'Dropping FK_CollaborationSpaceComment_Artist...';


GO
ALTER TABLE [dbo].[CollaborationSpaceComment] DROP CONSTRAINT [FK_CollaborationSpaceComment_Artist];


GO
PRINT N'Dropping fk_UserId...';


GO
ALTER TABLE [dbo].[webpages_UsersInRoles] DROP CONSTRAINT [fk_UserId];


GO
PRINT N'Dropping FK_Task_Artist...';


GO
ALTER TABLE [dbo].[Task] DROP CONSTRAINT [FK_Task_Artist];


GO
PRINT N'Starting rebuilding table [dbo].[Artist]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_Artist] (
    [ArtistId]               INT              IDENTITY (1, 1) NOT NULL,
    [OldUserId]              UNIQUEIDENTIFIER NULL,
    [UserName]               VARCHAR (256)    NOT NULL,
    [Country]                VARCHAR (50)     NULL,
    [Provence]               VARCHAR (65)     NULL,
    [City]                   VARCHAR (50)     NULL,
    [CreateDate]             DATETIME         DEFAULT getdate() NOT NULL,
    [ModifiedDate]           DATETIME         DEFAULT getdate() NOT NULL,
    [WebSite]                VARCHAR (255)    NULL,
    [ProfilePrivacyLevel]    TINYINT          DEFAULT 0 NOT NULL,
    [ContactPrivacyLevel]    TINYINT          DEFAULT 0 NOT NULL,
    [ProfileViews]           BIGINT           DEFAULT 0 NOT NULL,
    [ProfileLastViewDate]    SMALLDATETIME    NULL,
    [Rating]                 TINYINT          DEFAULT 3 NULL,
    [AvatarURL]              VARCHAR (255)    NULL,
    [EmailAddress]           VARCHAR (256)    NULL,
    [FileUploadsInBytes]     INT              DEFAULT 0 NOT NULL,
    [FileUploadQuotaInBytes] INT              DEFAULT 0 NOT NULL,
    [LastActivityDate]       DATETIME         DEFAULT getdate() NOT NULL,
    [ShowChatStatus]         BIT              DEFAULT 1 NOT NULL,
    [AllowChatSounds]        BIT              DEFAULT 1 NOT NULL,
    PRIMARY KEY CLUSTERED ([ArtistId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[Artist])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Artist] ON;
        INSERT INTO [dbo].[tmp_ms_xx_Artist] ([ArtistId], [Country], [Provence], [City], [WebSite], [ProfilePrivacyLevel], [ContactPrivacyLevel], [ProfileViews], [ProfileLastViewDate], [Rating], [AvatarURL], [EmailAddress], [FileUploadsInBytes], [FileUploadQuotaInBytes])
        SELECT   [ArtistId],
                 [Country],
                 [Provence],
                 [City],
                 [WebSite],
                 [ProfilePrivacyLevel],
                 [ContactPrivacyLevel],
                 [ProfileViews],
                 [ProfileLastViewDate],
                 [Rating],
                 [AvatarURL],
                 [EmailAddress],
                 [FileUploadsInBytes],
                 [FileUploadQuotaInBytes]
        FROM     [dbo].[Artist]
        ORDER BY [ArtistId] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_Artist] OFF;
    END

DROP TABLE [dbo].[Artist];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_Artist]', N'Artist';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[ArtistProfile]...';


GO
CREATE TABLE [dbo].[ArtistProfile] (
    [ArtistId]            INT            NOT NULL,
    [Bio]                 VARCHAR (MAX)  NULL,
    [MusicalInfluences]   VARCHAR (1024) NULL,
    [ProfileTemplateName] VARCHAR (50)   NULL,
    PRIMARY KEY CLUSTERED ([ArtistId] ASC)
);


GO
PRINT N'Creating Default Constraint on [dbo].[ArtistProfile]....';


GO
ALTER TABLE [dbo].[ArtistProfile]
    ADD DEFAULT 'basic' FOR [ProfileTemplateName];


GO
PRINT N'Creating FK_Media_ToTable...';


GO
ALTER TABLE [dbo].[Media] WITH NOCHECK
    ADD CONSTRAINT [FK_Media_ToTable] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId]);


GO
PRINT N'Creating FK_ArtistBand_ToArtist...';


GO
ALTER TABLE [dbo].[ArtistBand] WITH NOCHECK
    ADD CONSTRAINT [FK_ArtistBand_ToArtist] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId]);


GO
PRINT N'Creating FK_ArtistCollaborationSpaces_ToTable...';


GO
ALTER TABLE [dbo].[ArtistCollaborationSpaces] WITH NOCHECK
    ADD CONSTRAINT [FK_ArtistCollaborationSpaces_ToTable] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId]);


GO
PRINT N'Creating FK_Playlist_Artist...';


GO
ALTER TABLE [dbo].[Playlist] WITH NOCHECK
    ADD CONSTRAINT [FK_Playlist_Artist] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId]);


GO
PRINT N'Creating FK_CollaborationSpaceComment_Artist...';


GO
ALTER TABLE [dbo].[CollaborationSpaceComment] WITH NOCHECK
    ADD CONSTRAINT [FK_CollaborationSpaceComment_Artist] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId]);


GO
PRINT N'Creating fk_UserId...';


GO
ALTER TABLE [dbo].[webpages_UsersInRoles] WITH NOCHECK
    ADD CONSTRAINT [fk_UserId] FOREIGN KEY ([UserId]) REFERENCES [dbo].[Artist] ([ArtistId]);


GO
PRINT N'Creating FK_Task_Artist...';


GO
ALTER TABLE [dbo].[Task] WITH NOCHECK
    ADD CONSTRAINT [FK_Task_Artist] FOREIGN KEY ([ArtistId]) REFERENCES [dbo].[Artist] ([ArtistId]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[Media] WITH CHECK CHECK CONSTRAINT [FK_Media_ToTable];

ALTER TABLE [dbo].[ArtistBand] WITH CHECK CHECK CONSTRAINT [FK_ArtistBand_ToArtist];

ALTER TABLE [dbo].[ArtistCollaborationSpaces] WITH CHECK CHECK CONSTRAINT [FK_ArtistCollaborationSpaces_ToTable];

ALTER TABLE [dbo].[Playlist] WITH CHECK CHECK CONSTRAINT [FK_Playlist_Artist];

ALTER TABLE [dbo].[CollaborationSpaceComment] WITH CHECK CHECK CONSTRAINT [FK_CollaborationSpaceComment_Artist];

ALTER TABLE [dbo].[webpages_UsersInRoles] WITH CHECK CHECK CONSTRAINT [fk_UserId];

ALTER TABLE [dbo].[Task] WITH CHECK CHECK CONSTRAINT [FK_Task_Artist];


GO
PRINT N'Update complete.'
GO
