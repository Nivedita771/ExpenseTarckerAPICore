using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Extensions.DependencyInjection;
using ExpenseTracker.Repositories.RepoUtilities;
using ExpenseTracker.Services.Service_Interfaces;
using ExpenseTracker.Services.Services;

namespace ExpenseTracker.Services.ServiceUtilities
{
    public static class DependancyInjection
    {
        public static IServiceCollection AddExpenseTrackerServices(this IServiceCollection service)
        {
            service.AddExpenseTrackerRepositories();
            service.AddAutoMapper(typeof(MappingProfile));
            service.AddScoped<IUserService, UserService>();
            return service;
        }
    }
}
