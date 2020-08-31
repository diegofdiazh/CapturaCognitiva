using System;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace CapturaCognitiva.Data
{
    public class ApplicationUser : IdentityUser
    {
        public bool IsEnabled { get; set; }
        public bool IsRemoved { get; set; }
        public DateTime DateCreated { get; set; }
        public DateTime? DateEnabled { get; set; }
        public DateTime? DateRemoved { get; set; }
        public DateTime? DateEmailConfirmed { get; set; }
        public int Attemps { get; set; }
        public string Nombres { get; set; }
        public long Telefono { get; set; }
        public DateTime? DateBlock { get; set; }     
    }
    public class ApplicationDbContext : IdentityDbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }
    }
}
