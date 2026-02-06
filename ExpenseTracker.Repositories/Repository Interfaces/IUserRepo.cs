using System.Threading.Tasks;
using ExpenseTracker.Entities;

namespace ExpenseTracker.Repositories.Repository_Interfaces
{
    public interface IUserRepo
    {
        Task<User> RegisterAsync(User user);
        Task<User?> LoginAsync(string username, string password);
        Task<bool> UserExistsAsync(string username);
        Task UpdateUserAsync(User user);
        Task<User?> GetByUserNameAsync(string username);
    }
}
