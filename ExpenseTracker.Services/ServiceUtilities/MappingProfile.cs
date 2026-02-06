using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using ExpenseTracker.DTO;
using ExpenseTracker.Entities;

namespace ExpenseTracker.Services.ServiceUtilities
{
    public class MappingProfile :Profile
    {
        public MappingProfile() 
        {
            CreateMap<CreateUserDTO, User>();
            CreateMap<User, UserDTO>();
        }
       

    }
}
