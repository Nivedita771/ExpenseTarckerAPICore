CREATE TABLE [dbo].[Users] (
    [UserId]   INT            IDENTITY (1, 1) NOT NULL,
    [UserName] NVARCHAR (20)  NOT NULL,
    [Password] NVARCHAR (256) NOT NULL,
    [RoleId]   INT            NULL,
    [Email]    NVARCHAR (30)  DEFAULT ('') NOT NULL,
    [IsActive] BIT            NULL,
    PRIMARY KEY CLUSTERED ([UserId] ASC),
    FOREIGN KEY ([RoleId]) REFERENCES [dbo].[Roles] ([RoleId])
);

