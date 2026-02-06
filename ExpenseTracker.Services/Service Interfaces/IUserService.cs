using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ExpenseTracker.DTO;

namespace ExpenseTracker.Services.Service_Interfaces
{
    public interface IUserService
    {
        Task<UserDTO> RegisterAsync(CreateUserDTO user);
        Task<UserDTO?> LoginAsync(string username, string password);
    }
}
