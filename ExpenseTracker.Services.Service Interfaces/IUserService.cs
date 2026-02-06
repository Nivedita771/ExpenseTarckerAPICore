using ExpenseTracker.DTO;
using System.Threading.Tasks;

namespace ExpenseTracker.Services.Service_Interfaces
{
    public interface IUserService
    {
        Task<UserDTO> RegisterAsync(CreateUserDTO user);
        Task<UserDTO?> LoginAsync(string username, string password);
        Task<bool> UserExistsAsync(string username);
        Task UpdateUserAsync(UserDTO user);
    }
}