using CapturaCognitiva.App_Tools;
using CapturaCognitiva.Data;
using Microsoft.AspNetCore.Hosting;
using SendGrid;
using SendGrid.Helpers.Mail;
using System;
using System.IO;
using System.Threading.Tasks;


namespace CapturaCognitiva.Models.Response
{
    public class EmailHelper
    {
        private string ApiKey { get; set; }
        private readonly IWebHostEnvironment _env;
        private readonly ApplicationDbContext _db;
        public EmailHelper(IWebHostEnvironment env, ApplicationDbContext context)
        {
            _env = env;
            _db = context;
        }
        private string BodyRegisterAccount(string nombres, string passgeneric)
        {
            string path = Path.Combine(_env.WebRootPath, "BodyEmails/BodyEmailConfirmacion.html");
            string body = string.Empty;
            using (StreamReader reader = new StreamReader(path))
            {
                body = reader.ReadToEnd();
            }
            body = body.Replace("{NombresCompleto}", nombres);
            body = body.Replace("{Contraseña}", passgeneric);
            return body;
        }


        public async Task<bool> SendRegisterAccountAsync(string nombres, string emailregister, string passgeneric)
        {
            try
            {
                ApiKey = ConfigurationManager.AppSetting["App472Keys:App472_sendgrid"];
                var client = new SendGridClient(ApiKey);
                var from = new EmailAddress("Notificaciones-noresponse@4-72.com.co", "Notificaciones 4-72");
                var subject = $"Bienvenido : {nombres}";
                var to = new EmailAddress(emailregister, nombres);
                var plainTextContent = "Registro App 4-72";
                var htmlContent = BodyRegisterAccount(nombres, passgeneric);
                var msg = MailHelper.CreateSingleEmail(from, to, subject, plainTextContent, htmlContent);
                var response = await client.SendEmailAsync(msg);
                if (response.StatusCode.ToString() == "200" || response.StatusCode.ToString() == "Accepted" || response.StatusCode.ToString() == "202")
                {
                    return true;
                }
                else
                {
                    return false;
                }

            }
            catch
            {

                return false;
                throw;
            }

        }
    }
}