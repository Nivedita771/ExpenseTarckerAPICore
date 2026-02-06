using Dapper;
using ExpenseTracker.Entities;
using ExpenseTracker.Repositories.Repository_Interfaces;
using ExpenseTracker.Repositories.RepoUtilities;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using System;
using System.Data;
using System.Threading.Tasks;

namespace ExpenseTracker.Repositories.Repositories
{
    public class UserRepo : IUserRepo
    {   
        private readonly IConfiguration _configuration;
        private readonly string _connectionString;

        public UserRepo(IConfiguration configuration)
        {
            _configuration = configuration;
            // prefer GetConnectionString, but keep your constant if present
            _connectionString =  _configuration[DBConstants.ConnectionString];
        }

        public async Task<User> RegisterAsync(User user)
        {
            await using var sqlConnection = new SqlConnection(_connectionString);
            var parameters = new DynamicParameters();
            parameters.Add(DBParameters.UserName, user.UserName, DbType.String);
            parameters.Add(DBParameters.Email, user.Email, DbType.String);
            parameters.Add(DBParameters.Password, user.Password, DbType.String);
            // If the stored procedure returns the new UserId as scalar
            var newId = await sqlConnection.QuerySingleAsync<int>(
                StoredProcedures.RegisterUser, parameters, commandType: CommandType.StoredProcedure);

            user.UserId = newId;
            return user;
        }

        public async Task<User?> LoginAsync(string username, string password)
        {
            await using var sqlConnection = new SqlConnection(_connectionString);
            var parameters = new DynamicParameters();
            parameters.Add(DBParameters.UserName, username, DbType.String);
            parameters.Add(DBParameters.Password, password, DbType.String);

            // assuming usp_LoginUser returns user columns; Dapper maps them to User
            var user = await sqlConnection.QuerySingleOrDefaultAsync<User>(
                StoredProcedures.ValidateUser, parameters, commandType: CommandType.StoredProcedure);

            return user;
        }

        public async Task<bool> UserExistsAsync(string username)
        {
            await using var sqlConnection = new SqlConnection(_connectionString);
            var parameters = new DynamicParameters();
            parameters.Add(DBParameters.UserName, username, DbType.String);

            // Call the stored procedure that returns the count
            var count = await sqlConnection.QuerySingleAsync<int>(
                StoredProcedures.CheckUserNameExists, parameters, commandType: CommandType.StoredProcedure);

            return count > 0;
        }
    }
}
