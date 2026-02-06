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
        public async Task<IActionResult> LoginUser([FromBody] CreateUserDTO credentials)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            var user = await _userService.LoginAsync(credentials.UserName, credentials.Password);
            if (user == null)
                return Unauthorized(new { message = "Invalid username or password." });

            return Ok(user);
        }

        // New: update user
        // PUT api/user/{id}
        [HttpPut("{id:int}")]
        public async Task<IActionResult> UpdateUser(int id, [FromBody] UpdateUserDTO user)
        {
            if (!ModelState.IsValid)
                return BadRequest(ModelState);

            if (user == null)
                return BadRequest();

            // Optional: ensure route id matches payload id when payload contains UserId
            if (user.UserId != 0 && user.UserId != id)
                return BadRequest(new { message = "Route id and user.UserId do not match." });

            user.UserId = id; 

            try
            {
                await _userService.UpdateUserAsync(user);
                return NoContent();
            }
            catch (InvalidOperationException ex) when (ex.Message.Contains("Username is already in use"))
            {
                return Conflict(new { message = ex.Message });
            }
            catch (Exception)
            {
                return StatusCode(500, new { message = "An error occurred while updating the user." });
            }
        }
    }
}
