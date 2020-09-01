using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace CapturaCognitiva.Models.ViewModelsApi
{
    public class RegisterApIViewModels
    {
        [Required]
        [EmailAddress]
        [Display(Name = "Correo electrónico")]
        public string Email { get; set; }
        [Required]
        [Display(Name = "Nombres")]
        public string Nombres { get; set; }
        [Display(Name = "Telefono")]
        public string Telefono { get; set; }

    }
}