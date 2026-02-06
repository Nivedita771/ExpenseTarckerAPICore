CREATE TABLE [dbo].[Expenses] (
    [ExpenseId]   INT             IDENTITY (1, 1) NOT NULL,
    [Title]       NVARCHAR (100)  NULL,
    [Amount]      DECIMAL (18, 2) NULL,
    [ExpenseDate] DATE            NULL,
    [CategoryId]  INT             NULL,
    [UserId]      INT             NULL,
    PRIMARY KEY CLUSTERED ([ExpenseId] ASC),
    FOREIGN KEY ([CategoryId]) REFERENCES [dbo].[Categories] ([CategoryId]),
    FOREIGN KEY ([UserId]) REFERENCES [dbo].[Users] ([UserId])
);

