using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExpenseTracker.Repositories.RepoUtilities
{
    internal static class DBParameters
    {
        public static readonly string UserName = "UserName";
        public static readonly string Email = "Email";
        public static readonly string Password = "Password";
        public static readonly string UserId = "UserId";
        public static readonly string RoleId = "RoleId";

    }
    internal static class DBConstants
    {
        public static readonly string ConnectionString = "ConnectionString";
    }
}
