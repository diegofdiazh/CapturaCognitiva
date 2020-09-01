using CapturaCognitiva.Data;
using System.Linq;
using System.Security.Claims;
using Microsoft.AspNetCore.Identity;

namespace CapturaCognitiva.App_Tools
{
    public class SessionData
    {
        private readonly ApplicationDbContext _db;
        public SessionData(ApplicationDbContext bd)
        {
            _db = bd;
        }




        public static string GetUserId(ClaimsPrincipal user, SignInManager<ApplicationUser> signInManager)
        {
            if (user == null)
            {
                return null;
            }
            else
            {
                return signInManager.UserManager.GetUserId(user);
            }
        }

        public static string GetRolId(ApplicationDbContext db, string userId)
        {

            try
            {
                var roles = db.UserRoles.FirstOrDefault(c => c.UserId == userId);
                if (roles != null)
                {
                    var role = db.Roles.FirstOrDefault(c => c.Id == roles.RoleId);
                    return role.Id;
                }
                else
                {
                    return null;
                }
            }
            catch
            {
                return null;
            }

        }



        public static string GetNameRole(ApplicationDbContext db, string userId)
        {

            try
            {
                var roles = db.UserRoles.FirstOrDefault(c => c.UserId == userId);
                if (roles != null)
                {
                    var role = db.Roles.FirstOrDefault(c => c.Id == roles.RoleId);
                    return role.Name;
                }
                else
                {
                    return null;
                }
            }
            catch
            {
                return null;
            }
        }

    }


}