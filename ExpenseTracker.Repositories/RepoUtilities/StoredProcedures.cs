using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExpenseTracker.Repositories.RepoUtilities
{
    internal static class StoredProcedures
    {
        public static readonly string RegisterUser = "[dbo].[RegisterUser]";
        public static readonly string ValidateUser = "[dbo].[ValidateUser]";
        public static readonly string CheckUserNameExists = "[dbo].[CheckUserNameExists]";
      //  public static readonly string RegisterUser = "[dbo].[RegisterUser]";

    }
}
