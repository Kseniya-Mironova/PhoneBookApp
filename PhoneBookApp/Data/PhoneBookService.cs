using PhoneBookApp.Interfaces;
using PhoneBookApp.Entities;
using Dapper;
using System;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace PhoneBookApp.Data
{
    public class PhoneBookService : IPhoneBookService
    {
        private readonly IDapperService _dapperService;
        public PhoneBookService(IDapperService dapperService)
        {
            this._dapperService = dapperService;
        }
        public Task<int> Create(PhoneBook phoneBook)
        {
            var dbPara = new DynamicParameters();

            dbPara.Add("LastName", phoneBook.LastName, DbType.String);
            dbPara.Add("FirstName", phoneBook.FirstName, DbType.String);
            dbPara.Add("SecondName", phoneBook.SecondName, DbType.String);
            dbPara.Add("RoleName", phoneBook.RoleName, DbType.String);
            dbPara.Add("DeptName", phoneBook.DeptName, DbType.String);
            dbPara.Add("Phone", phoneBook.Phone, DbType.String);

            var phoneBookId = Task.FromResult
               (_dapperService.Insert<int>("[dbo].[spAddPhoneBook]",
               dbPara, commandType: CommandType.StoredProcedure));
            return phoneBookId;
        }
        public Task<PhoneBook> GetById(int id)
        {
            var phoneBook = Task.FromResult
               (_dapperService.Get<PhoneBook>
               ($"SELECT PB.Id, P.LastName, P.FirstName, P.SecondName, R.RoleName, D.DeptName, PB.Phone FROM [dbo].[Person] AS P JOIN [dbo].[Role] AS R ON P.RoleId = R.Id JOIN [dbo].[Department] AS D ON P.DeptId = D.Id JOIN [dbo].[PhoneBook] AS PB ON P.Id = PB.PersonId WHERE PB.Id = {id}", null,
               commandType: CommandType.Text));
            return phoneBook;
        }
        public Task<int> Delete(int id)
        {
            var deletePhoneBook = Task.FromResult
               (_dapperService.Execute
               ($"Delete [dbo].[PhoneBook] where Id = {id}", null,
               commandType: CommandType.Text));
            return deletePhoneBook;
        }
        public Task<int> Count(string search)
        {
            var totPhoneBook = Task.FromResult(_dapperService.Get<int>
               ($"select COUNT(*) FROM [dbo].[Person] AS P JOIN[dbo].[Role] AS R ON P.RoleId = R.Id JOIN [dbo].[Department] AS D ON P.DeptId = D.Id JOIN [dbo].[PhoneBook] AS PB ON P.Id = PB.PersonId WHERE P.LastName like '%{search}%'", null,
               commandType: CommandType.Text));
            return totPhoneBook;
        }
        public Task<List<PhoneBook>> ListAll(int skip, int take,
           string orderBy, string direction = "DESC", string search = "")
        {
            var phoneBook = Task.FromResult
               (_dapperService.GetAll<PhoneBook>
               ($"SELECT PB.Id, P.LastName, P.FirstName, P.SecondName, R.RoleName, D.DeptName, PB.Phone FROM [dbo].[Person] AS P JOIN[dbo].[Role] AS R ON P.RoleId = R.Id JOIN [dbo].[Department] AS D ON P.DeptId = D.Id JOIN [dbo].[PhoneBook] AS PB ON P.Id = PB.PersonId WHERE P.LastName like '%{search}%' ORDER BY {orderBy} {direction} OFFSET {skip} ROWS FETCH NEXT {take} ROWS ONLY; ", null, commandType: CommandType.Text));
           return phoneBook;
        }
        public Task<int> Update(PhoneBook phoneBook)
        {
            var dbPara = new DynamicParameters();
            dbPara.Add("Id", phoneBook.Id);
            dbPara.Add("LastName", phoneBook.LastName, DbType.String);
            dbPara.Add("FirstName", phoneBook.FirstName, DbType.String);
            dbPara.Add("SecondName", phoneBook.SecondName, DbType.String);
            dbPara.Add("RoleName", phoneBook.RoleName, DbType.String);
            dbPara.Add("DeptName", phoneBook.DeptName, DbType.String);
            dbPara.Add("Phone", phoneBook.Phone, DbType.String);
            var updatePhoneBook = Task.FromResult
               (_dapperService.Update<int>("[dbo].[spUpdatePhoneBook]",
               dbPara, commandType: CommandType.StoredProcedure));
            return updatePhoneBook;
        }
    }
}
