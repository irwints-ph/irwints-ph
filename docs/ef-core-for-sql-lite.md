To create Entity Framework (EF) classes and a context for the provided schema, I'll translate the tables into C# class definitions and then build an `EF` `DbContext` to manage the database operations with SQLite.

Here’s how you can structure your `EF` classes and `DbContext` for SQLite:

### Step 1: Define the Models (EF Classes)

```csharp
using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

public class AppsUserRef
{
    public int UUID { get; set; }
    public string FullName { get; set; }
    public int DefMod { get; set; }
    public string IsActive { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LastUpdBy { get; set; }
    public DateTime LastUpdDate { get; set; }
    public string SsoKey { get; set; }

    public ICollection<AppsUserMapper> UserMappers { get; set; }
    public ICollection<AppsUserRoleRef> UserRoleRefs { get; set; }
    public ICollection<AppsPersonnelMstr> PersonnelMstrs { get; set; }
    public ICollection<AppsUserSession> UserSessions { get; set; }
    public ICollection<AppsUserModuleLogs> UserModuleLogs { get; set; }
    public ICollection<AppsAuditHdrRef> AuditHdrRefs { get; set; }
}

public class AppsSsoRef
{
    public int UUID { get; set; }
    public string SsoKey { get; set; }
    public string IsActive { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LastUpdBy { get; set; }
    public DateTime LastUpdDate { get; set; }

    public AppsUserRef User { get; set; }
}

public class AppsUserMapper
{
    public int UUID { get; set; }
    public string Username { get; set; }
    public string Password { get; set; }
    public string SaltKey { get; set; }
    public string IsActive { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LastUpdBy { get; set; }
    public DateTime LastUpdDate { get; set; }

    public AppsUserRef User { get; set; }
}

public class AppsPersonnelMstr
{
    public int UUID { get; set; }
    public string Email { get; set; }
    public string LastName { get; set; }
    public string FirstName { get; set; }
    public string ContactNo { get; set; }
    public string IsActive { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LastUpdBy { get; set; }
    public DateTime LastUpdDate { get; set; }

    public AppsUserRef User { get; set; }
}

public class AppsRoleRef
{
    public int RoleId { get; set; }
    public string RoleName { get; set; }
    public string RoleDescription { get; set; }
    public int ParentId { get; set; }
    public string IsActive { get; set; }
    public string IsAdmin { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LastUpdBy { get; set; }
    public DateTime LastUpdDate { get; set; }

    public ICollection<AppsUserRoleRef> UserRoleRefs { get; set; }
    public ICollection<AppsRoleModuleRef> RoleModuleRefs { get; set; }
}

public class AppsUserRoleRef
{
    public int UUID { get; set; }
    public int RoleId { get; set; }
    public string IsActive { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LastUpdBy { get; set; }
    public DateTime LastUpdDate { get; set; }

    public AppsUserRef User { get; set; }
    public AppsRoleRef Role { get; set; }
}

public class AppsRoleModuleRef
{
    public int RoleId { get; set; }
    public int ModuleId { get; set; }
    public string Autohrztn { get; set; }
    public string IsActive { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LastUpdBy { get; set; }
    public DateTime LastUpdDate { get; set; }

    public AppsRoleRef Role { get; set; }
    public AppsModuleRef Module { get; set; }
}

public class AppsModuleRef
{
    public int ModuleId { get; set; }
    public string ModuleName { get; set; }
    public int ParentId { get; set; }
    public int MenuLevel { get; set; }
    public int SortOrder { get; set; }
    public string FormName { get; set; }
    public string PageName { get; set; }
    public string FolderPath { get; set; }
    public string IsParent { get; set; }
    public string Code { get; set; }
    public string IsActive { get; set; }
    public string IsAdmin { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LastUpdBy { get; set; }
    public DateTime LastUpdDate { get; set; }

    public ICollection<AppsRoleModuleRef> RoleModuleRefs { get; set; }
    public ICollection<AppsRoleModuleFldsRef> RoleModuleFldsRefs { get; set; }
}

public class AppsRoleModuleFldsRef
{
    public int RoleId { get; set; }
    public int ModuleId { get; set; }
    public string FieldName { get; set; }
    public string Value { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int LastUpdBy { get; set; }
    public DateTime LastUpdDate { get; set; }
    public string IsActive { get; set; }

    public AppsRoleRef Role { get; set; }
    public AppsModuleRef Module { get; set; }
}

public class AppsUserSession
{
    public string SessionId { get; set; }
    public string Username { get; set; }
    public DateTime LoginDate { get; set; }
    public string LoginTime { get; set; }
    public string CmprName { get; set; }
    public int UUID { get; set; }
    public string SrvrName { get; set; }
    public string IsActive { get; set; }
    public DateTime DeactDate { get; set; }
    public string DeactTime { get; set; }

    public AppsUserRef User { get; set; }
}

public class AppsUserModuleLogs
{
    public int ModuleId { get; set; }
    public int UUID { get; set; }
    public DateTime LogDate { get; set; }
    public string Time { get; set; }
    public string Username { get; set; }
    public string CmprName { get; set; }
    public string SrvrName { get; set; }

    public AppsUserRef User { get; set; }
    public AppsModuleRef Module { get; set; }
}

public class AppsAuditHdrRef
{
    public int AuditId { get; set; }
    public string ActionType { get; set; }
    public string UserName { get; set; }
    public string CompName { get; set; }
    public int ModuleId { get; set; }
    public string TableName { get; set; }
    public string TableKey { get; set; }
    public string ActionRmrk { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }

    public AppsUserRef User { get; set; }
}

public class AppsAuditDtlRef
{
    public int AuditId { get; set; }
    public int Linenubr { get; set; }
    public string FieldNam { get; set; }
    public string OldValue { get; set; }
    public string NewValue { get; set; }

    public AppsAuditHdrRef AuditHdr { get; set; }
}
```

### Step 2: Define the DbContext Class

```csharp
public class AppDbContext : DbContext
{
    public DbSet<AppsUserRef> AppsUserRefs { get; set; }
    public DbSet<AppsSsoRef> AppsSsoRefs { get; set; }
    public DbSet<AppsUserMapper> AppsUserMappers { get; set; }
    public DbSet<AppsPersonnelMstr> AppsPersonnelMstrs { get; set; }
    public DbSet<AppsRoleRef> AppsRoleRefs { get; set; }
    public DbSet<AppsUserRoleRef> AppsUserRoleRefs { get; set; }
    public DbSet<AppsRoleModuleRef> AppsRoleModuleRefs { get; set; }
    public DbSet<AppsModuleRef> AppsModuleRefs { get; set; }
    public DbSet<AppsRoleModuleFldsRef> AppsRoleModuleFldsRefs { get; set; }
    public DbSet<AppsUserSession> AppsUserSessions { get; set; }
    public DbSet<AppsUserModuleLogs> AppsUserModuleLogs { get; set; }
    public DbSet<AppsAuditHdrRef> AppsAuditHdrRefs { get; set; }
    public DbSet<AppsAuditDtlRef> AppsAuditDtlRefs { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        optionsBuilder.UseSqlite("Data Source=app.db"); // SQLite connection string
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        // Define relationships (e.g. One-to-Many, Many-to-Many)
        modelBuilder.Entity<AppsUserRef>()
            .HasMany(u => u.UserMappers)
            .WithOne(m => m.User);

        modelBuilder.Entity<AppsUserRef>()
            .HasMany(u => u.UserRoleRefs)
            .WithOne(r => r.User);

        modelBuilder.Entity<AppsRoleRef>()
            .HasMany(r => r.UserRoleRefs)
            .WithOne(ur => ur.Role);
        
        modelBuilder.Entity<AppsRoleRef>()
            .HasMany(r => r.RoleModuleRefs)
            .WithOne(rm => rm.Role);
        
        modelBuilder.Entity<AppsModuleRef>()
            .HasMany(m => m.RoleModuleRefs)
            .WithOne(rm => rm.Module);
    }
}
```

### Step 3: Using the `DbContext` and `EF Core`

1. Install the necessary EF Core packages via NuGet:

    ```
    dotnet add package Microsoft.EntityFrameworkCore.Sqlite
    dotnet add package Microsoft.EntityFrameworkCore.Design
    ```

2. You can now use the `AppDbContext` to interact with your SQLite database:

```csharp
using (var context = new AppDbContext())
{
    context.Database.EnsureCreated(); // Creates the database if it doesn't exist

    var newUser = new AppsUserRef
    {
        FullName = "John Doe",
        DefMod = 1,
        IsActive = "Y",
        CreatedBy = 1,
        CreatedDate = DateTime.Now
    };

    context.AppsUserRefs.Add(newUser);
    context.SaveChanges();
}
```

### Conclusion:
This setup provides the basic EF Core models and `DbContext` to interact with your SQLite database based on the schema you provided. You can use `EF Core` features like migrations, querying, and saving entities to the database as usual.

Let me know if you'd like further details or any specific part of the code explained!