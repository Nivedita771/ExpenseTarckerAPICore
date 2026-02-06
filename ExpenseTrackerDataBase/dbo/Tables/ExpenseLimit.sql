CREATE TABLE [dbo].[ExpenseLimit] (
    [Id]          INT             IDENTITY (1, 1) NOT NULL,
    [UserId]      INT             NOT NULL,
    [LimitAmount] DECIMAL (18, 2) NOT NULL,
    [LimitMonth]  INT             NOT NULL,
    [LimitYear]   INT             NOT NULL,
    [CreatedDate] DATETIME        DEFAULT (getdate()) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

