using ExpenseTracker.DTO;
using ExpenseTracker.Services.Service_Interfaces;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;

namespace ExpenseTrackerAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;
        public UserController(IUserService userService)
        {
            _userService = userService;
        }

        [HttpPost("register")]
        public async Task<IActionResult> RegisterUser([FromBody] CreateUserDTO user)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            try
            {
                var created = await _userService.RegisterAsync(user);
                return Ok(created);
            }
            catch (InvalidOperationException ex) when (ex.Message.Contains("already exists"))
            {
                return Conflict(new { message = ex.Message });
            }
        }

        [HttpPost("login")]
        public async Task<IActionResult> LoginUser(string userName, string password)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var user = await _userService.LoginAsync(userName, password);
            if (user == null)
                return Unauthorized(new { message = "Invalid username or password." });

            return Ok(user);
        }
    }
}
