CREATE TABLE [dbo].[Categories] (
    [CategoryId] INT           IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (50) NULL,
    [UserId]     INT           NULL,
    PRIMARY KEY CLUSTERED ([CategoryId] ASC),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);

