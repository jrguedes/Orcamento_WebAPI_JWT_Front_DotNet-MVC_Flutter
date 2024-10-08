using OrcamentoMVC.Front.Services;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

builder.Services.AddHttpClient("OrcamentoAPI", c =>
{
    c.BaseAddress = new Uri(builder.Configuration["ServiceUri:OrcamentoAPI"]);
});

builder.Services.AddHttpContextAccessor();
builder.Services.AddScoped<IAccessTokenService, AccessTokenService>();
builder.Services.AddScoped<IAuthentication, Authentication>();
builder.Services.AddScoped<IOrcamentoService, OrcamentoService>();
builder.Services.AddScoped<IItemOrcamentoService, ItemOrcamentoService>();


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

app.MapControllerRoute(
    name: "details",
    pattern: "Orcamento/{controller=Home}/{action=Index}/{id?}/{descricao?}");





app.Run();
