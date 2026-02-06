using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ExpenseTracker.Repositories.RepoUtilities
{
    internal static class DBConfiguration
    {
        public static string ConnectionString
        {
            get
            {
                return "Data Source=.; Initial Catalog=ExpenseTrack; Integrated Security=True";
            }
        }
    }
}
