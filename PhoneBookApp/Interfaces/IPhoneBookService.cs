using PhoneBookApp.Entities;
using System.Collections.Generic;
using System.Threading.Tasks;


namespace PhoneBookApp.Interfaces
{
    public interface IPhoneBookService
    {
        Task<int> Create(PhoneBook phoneBook);
        Task<int> Delete(int Id);
        Task<int> Count(string search);
        Task<int> Update(PhoneBook phoneBook);
        Task<PhoneBook> GetById(int Id);
        Task<List<PhoneBook>> ListAll(int skip, int take, string orderBy, string direction, string search);
        Task<List<Role>> FetchAllRoles();
        Task<List<Department>> FetchAllDepts();
    }
}
