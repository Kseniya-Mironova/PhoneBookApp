﻿using System.ComponentModel.DataAnnotations;

namespace PhoneBookApp.Entities
{
    public class Role
    {
        [Key]
        public int Id { get; set; }
        public string RoleName { get; set; }     
    }
}
