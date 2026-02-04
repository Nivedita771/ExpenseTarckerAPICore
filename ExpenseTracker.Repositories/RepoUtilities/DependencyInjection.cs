using Microsoft.Extensions.DependencyInjection;
using ExpenseTracker.Repositories;
using ExpenseTracker.Repositories.Repository_Interfaces;
using ExpenseTracker.Repositories.Repositories;


namespace ExpenseTracker.Repositories.RepoUtilities
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddExpenseTrackerRepositories(this IServiceCollection serviceCollection)
        {
            serviceCollection.AddScoped<IUserRepo, UserRepo>();
            return serviceCollection;
        }
    }
}
