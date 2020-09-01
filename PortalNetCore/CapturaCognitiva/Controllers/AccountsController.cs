
using CapturaCognitiva.Data;
using CapturaCognitiva.Models.AccountViewModels;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Linq;
using System.Threading.Tasks;

namespace CapturaCognitiva.Controllers
{
    public class AccountsController : Controller
    {

        private readonly UserManager<ApplicationUser> _userManager;
        private readonly SignInManager<ApplicationUser> _signInManager;
        private readonly ILogger<LoginViewModels> _logger;
        private readonly ApplicationDbContext _db;
        public AccountsController(SignInManager<ApplicationUser> signInManager, ILogger<LoginViewModels> logger,
            UserManager<ApplicationUser> userManager, ApplicationDbContext context)
        {
            _logger = logger;
            _userManager = userManager;
            _signInManager = signInManager;
            _db = context;
        }
        public IActionResult Login()
        {
            return View(new LoginViewModels { Email = "", Password = "", RememberMe = false });
        }
        [HttpPost]
        public async Task<IActionResult> LoginAsync(LoginViewModels model)
        {

            if (ModelState.IsValid)
            {
                var user = _db.Users.FirstOrDefault(c => c.Email == model.Email);
                if (user == null)
                {
                    ModelState.AddModelError("", "Informacion invalida.");
                    return View(model);
                }
                /*
                var roles = SessionData.GetNameRole(_db, user.Id);
                if (roles == "Cliente")
                {
                    ModelState.AddModelError("", "Rol invalido.");
                    return View(model);
                }*/
                // This doesn't count login failures towards account lockout
                // To enable password failures to trigger account lockout, set lockoutOnFailure: true
                var result = await _signInManager.PasswordSignInAsync(model.Email, model.Password, model.RememberMe, lockoutOnFailure: false);

                if (result.Succeeded)
                {
                    _logger.LogInformation("User logged in.");
                    return RedirectToAction("Index", "Home");
                }
                if (result.IsLockedOut)
                {
                    _logger.LogWarning("User account locked out.");
                    return RedirectToPage("./Lockout");
                }
                else
                {
                    ModelState.AddModelError(string.Empty, "Intento invalido");
                    return View(model);
                }
            }
            return View();
        }

        public async Task<IActionResult> Logout()
        {
            await _signInManager.SignOutAsync();
            _logger.LogInformation("User logged out.");
            return RedirectToAction("Index", "Home");
        }

    }
}
