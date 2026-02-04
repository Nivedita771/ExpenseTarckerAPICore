using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using ExpenseTracker.Repositories.RepoUtilities;

namespace ExpenseTracker.Services.ServiceUtilities
{
    public static class DependancyInjection
    {
        public static IServiceCollection AddExpenseTrackerServices(this IServiceCollection serviceCollection)
        {
            serviceCollection.AddExpenseTrackerRepositories();
            return serviceCollection;
        }
    }
}
