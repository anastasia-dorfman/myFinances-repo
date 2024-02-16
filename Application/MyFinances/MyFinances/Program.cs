namespace MyFinances
{
    public class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            // Add services to the container.
            builder.Services.AddControllersWithViews();

            //////////////////////STEP 1/////////////////////////////
            // Turn off client side validaiton so we can test our model validation
            builder.Services.AddMvc().AddViewOptions(o => o.HtmlHelperOptions.ClientValidationEnabled = false);

            // Add RazorRuntimeCompilation in NuGet
            builder.Services.AddRazorPages().AddRazorRuntimeCompilation();
            //////////////////////STEP 1/////////////////////////////

            var app = builder.Build();

            // Configure the HTTP request pipeline.
            if (!app.Environment.IsDevelopment())
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }

            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthorization();

            app.MapControllerRoute(
                name: "default",
                pattern: "{controller=Home}/{action=Index}/{id?}");

            app.Run();
        }
    }
}
