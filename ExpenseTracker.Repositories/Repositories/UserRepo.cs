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
            _connectionString =  _configuration[DBConstants.ConnectionString];
        }

        public async Task<User> RegisterAsync(User user)
        {
            await using var sqlConnection = new SqlConnection(_connectionString);
            var parameters = new DynamicParameters();
            parameters.Add(DBParameters.UserName, user.UserName, DbType.String);
            parameters.Add(DBParameters.Email, user.Email, DbType.String);
            parameters.Add(DBParameters.Password, user.Password, DbType.String);
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

            var user = await sqlConnection.QuerySingleOrDefaultAsync<User>(
                StoredProcedures.ValidateUser, parameters, commandType: CommandType.StoredProcedure);

            return user;
        }

        public async Task<bool> UserExistsAsync(string username)
        {
            await using var sqlConnection = new SqlConnection(_connectionString);
            var parameters = new DynamicParameters();
            parameters.Add(DBParameters.UserName, username, DbType.String);

            var count = await sqlConnection.QuerySingleAsync<int>(
                StoredProcedures.CheckUserNameExists, parameters, commandType: CommandType.StoredProcedure);

            return count > 0;
        }

        public async Task UpdateUserAsync(User user)
        {
            await using var sqlConnection = new SqlConnection(_connectionString);
            var parameters = new DynamicParameters();

            parameters.Add(DBParameters.UserId, user.UserId, DbType.Int32);
            parameters.Add(DBParameters.UserName, user.UserName, DbType.String);
            parameters.Add(DBParameters.RoleId, user.RoleId, DbType.Int32);
            parameters.Add(DBParameters.Email, user.Email, DbType.String);

            await sqlConnection.ExecuteAsync(
                StoredProcedures.UpdateUser, 
                parameters, 
                commandType: CommandType.StoredProcedure);
        }

        public async Task<User?> GetByUserNameAsync(string username)
        {
            await using var sqlConnection = new SqlConnection(_connectionString);
            var parameters = new DynamicParameters();
            parameters.Add(DBParameters.UserName, username, DbType.String);

            const string sql = @"
                SELECT UserId, UserName, Email, RoleId, Password, isActive
                FROM Users
                WHERE UserName = @UserName";

            var user = await sqlConnection.QuerySingleOrDefaultAsync<User>(sql, parameters, commandType: CommandType.Text);
            return user;
        }
    }
}
