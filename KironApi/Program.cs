using DataLayer.DAL;
using DataLayer.Repositories;
using KironApi.Services;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Security.Cryptography;
using Newtonsoft.Json;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers()
            .AddNewtonsoftJson(options =>
            {
                options.SerializerSettings.ReferenceLoopHandling = ReferenceLoopHandling.Ignore;
                options.SerializerSettings.NullValueHandling = NullValueHandling.Ignore;
            });

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddSingleton<DBConnectionManager>();

byte[] keyBytes = new byte[128 / 8];
using (var rng = new RNGCryptoServiceProvider())
{
    rng.GetBytes(keyBytes);
}


string secretKey = Convert.ToBase64String(keyBytes);


builder.Services.AddScoped<BankHolidayRepository>(provider =>
{
    var logger = provider.GetRequiredService<ILogger<BankHolidayRepository>>();
    var dbConnectionManager = provider.GetRequiredService<DBConnectionManager>();
    var memoryCache = provider.GetRequiredService<IMemoryCache>();
    var configuration = provider.GetRequiredService<IConfiguration>();
    return new BankHolidayRepository(dbConnectionManager, memoryCache, logger, configuration);
});

builder.Services.AddScoped<CoinStatsRepository>();
builder.Services.AddScoped<NavigationRepository>();
builder.Services.AddScoped<RegionRepository>();
builder.Services.AddScoped<UserRepository>();

int tokenExpiryHours = builder.Configuration.GetValue<int>("TokenExpiryHours");

builder.Services.AddScoped<AuthService>(provider => new AuthService(
    provider.GetRequiredService<UserRepository>(),
    secretKey,
    tokenExpiryHours,
    provider.GetRequiredService<ILogger<AuthService>>()
));

builder.Services.AddScoped<BankHolidayService>();
builder.Services.AddScoped<CoinStatsService>();
builder.Services.AddScoped<NavigationService>();
builder.Services.AddScoped<RegionService>();

builder.Services.AddLogging();

var configuration = builder.Configuration;

builder.Services.AddMemoryCache();
builder.Services.AddSingleton(configuration);

string connectionString = configuration.GetConnectionString("DefaultConnection");
builder.Services.AddTransient<IDbConnection>((sp) => new SqlConnection(connectionString));



var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
