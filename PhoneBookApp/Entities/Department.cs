using System.ComponentModel.DataAnnotations;

namespace PhoneBookApp.Entities
{
    public class Department
    {
        [Key]
        public int Id { get; set; }     
        public string DeptName { get; set; }    
    }
}