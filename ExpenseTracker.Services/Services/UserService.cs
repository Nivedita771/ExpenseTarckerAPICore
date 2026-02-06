using ExpenseTracker.Services.Service_Interfaces;
using ExpenseTracker.DTO;

namespace ExpenseTracker.Services.Services
{
    public class UserService : IUserService
    {
        public async Task<User> RegisterAsync(User user, string password)
        {
            // TODO: Add logic to hash password, validate user, and save to database
            user.Password = password; // Replace with real hashing
            // Save user to database (not implemented)
            return await Task.FromResult(user);
        }

        public async Task<User?> LoginAsync(string username, string password)
        {
            // TODO: Add logic to retrieve user, verify password, and return user if valid
            if (username == "test" && password == "password")
            {
                return await Task.FromResult(new User { UserName = username });
            }
            return null;
        }
    }
}
