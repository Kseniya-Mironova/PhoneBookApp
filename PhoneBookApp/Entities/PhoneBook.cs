using System.ComponentModel.DataAnnotations;

namespace PhoneBookApp.Entities
{
    public class PhoneBook
    {
        [Key]
        public int Id { get; set; }
        public string LastName { get; set; }
        public string FirstName { get; set; }
        public string SecondName { get; set; }
        public string RoleName { get; set; }
        public string DeptName { get; set; }
        public string Phone { get; set; }
    }
}
