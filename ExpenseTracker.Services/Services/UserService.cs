using AutoMapper;
using ExpenseTracker.DTO;
using ExpenseTracker.Entities;
using ExpenseTracker.Repositories.Repository_Interfaces;
using ExpenseTracker.Services.Service_Interfaces;
using System;
using System.Threading.Tasks;

namespace ExpenseTracker.Services.Services
{
    public class UserService : IUserService
    {
        private readonly IUserRepo _userRepo;
        private readonly IMapper _mapper;
        public UserService(IUserRepo userRepo, IMapper mapper)
        {
            _userRepo = userRepo;
            _mapper = mapper;
        }

        public async Task<UserDTO> RegisterAsync(CreateUserDTO user)
        {
            if (await _userRepo.UserExistsAsync(user.UserName))
                throw new InvalidOperationException("User already exists.");

            User userEntity = _mapper.Map<User>(user);
            User savedData = await _userRepo.RegisterAsync(userEntity);
            return _mapper.Map<UserDTO>(savedData);
        }

        public async Task<UserDTO?> LoginAsync(string username, string password)
        {
            User? user = await _userRepo.LoginAsync(username, password);
            return user is null ? null : _mapper.Map<UserDTO>(user);
        }

        public Task<bool> UserExistsAsync(string username)
        { 
            return _userRepo.UserExistsAsync(username);
        }
        public async Task UpdateUserAsync(UpdateUserDTO userDto)
        {
            if (userDto == null) throw new ArgumentNullException(nameof(userDto));

            var existing = await _userRepo.GetByUserNameAsync(userDto.UserName);

            // If a user exists with the same username and different id -> conflict
            if (existing != null && existing.UserId != userDto.UserId)
                throw new InvalidOperationException("Username is already in use by another user.");

            var entity = _mapper.Map<User>(userDto);
            await _userRepo.UpdateUserAsync(entity);
        }
    }
}
