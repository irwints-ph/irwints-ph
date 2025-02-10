using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace DataLayer
{
    public partial class AppDBContext : DbContext
    {
        protected string _CS;
        public AppDBContext(string connectionString)
        {
            _CS = connectionString;
        }

        public AppDBContext(DbContextOptions<AppDBContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AppsAuditDtlRef> AppsAuditDtlRefs { get; set; } = null!;
        public virtual DbSet<AppsAuditHdrRef> AppsAuditHdrRefs { get; set; } = null!;
        public virtual DbSet<AppsModuleAuthRef> AppsModuleAuthRefs { get; set; } = null!;
        public virtual DbSet<AppsModuleFldsRef> AppsModuleFldsRefs { get; set; } = null!;
        public virtual DbSet<AppsModuleRef> AppsModuleRefs { get; set; } = null!;
        public virtual DbSet<AppsPersonnelMstr> AppsPersonnelMstrs { get; set; } = null!;
        public virtual DbSet<AppsRoleModuleAuthRef> AppsRoleModuleAuthRefs { get; set; } = null!;
        public virtual DbSet<AppsRoleModuleFldsRef> AppsRoleModuleFldsRefs { get; set; } = null!;
        public virtual DbSet<AppsRoleModuleRef> AppsRoleModuleRefs { get; set; } = null!;
        public virtual DbSet<AppsRoleRef> AppsRoleRefs { get; set; } = null!;
        public virtual DbSet<AppsUserMapper> AppsUserMappers { get; set; } = null!;
        public virtual DbSet<AppsUserModuleLog> AppsUserModuleLogs { get; set; } = null!;
        public virtual DbSet<AppsUserRef> AppsUserRefs { get; set; } = null!;
        public virtual DbSet<AppsUserRoleRef> AppsUserRoleRefs { get; set; } = null!;
        public virtual DbSet<AppsUserSession> AppsUserSessions { get; set; } = null!;
        public virtual DbSet<User> Users { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseMySql(_CS, Microsoft.EntityFrameworkCore.ServerVersion.Parse("8.0.28-mysql"));
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.UseCollation("utf8mb4_0900_ai_ci")
                .HasCharSet("utf8mb4");

            modelBuilder.Entity<AppsAuditDtlRef>(entity =>
            {
                entity.HasKey(e => new { e.AuditId, e.Linenubr, e.Fieldnam })
                    .HasName("PRIMARY")
                    .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0, 0 });

                entity.ToTable("apps_audit_dtl_ref");

                entity.Property(e => e.AuditId).HasColumnName("audit_id");

                entity.Property(e => e.Linenubr).HasColumnName("linenubr");

                entity.Property(e => e.Fieldnam)
                    .HasMaxLength(50)
                    .HasColumnName("fieldnam");

                entity.Property(e => e.Newvalue)
                    .HasMaxLength(150)
                    .HasColumnName("newvalue");

                entity.Property(e => e.Oldvalue)
                    .HasMaxLength(150)
                    .HasColumnName("oldvalue");
            });

            modelBuilder.Entity<AppsAuditHdrRef>(entity =>
            {
                entity.HasKey(e => e.AuditId)
                    .HasName("PRIMARY");

                entity.ToTable("apps_audit_hdr_ref");

                entity.Property(e => e.AuditId).HasColumnName("audit_id");

                entity.Property(e => e.Actionrmrk)
                    .HasMaxLength(100)
                    .HasColumnName("actionrmrk");

                entity.Property(e => e.Actiontype)
                    .HasMaxLength(1)
                    .HasColumnName("actiontype")
                    .IsFixedLength();

                entity.Property(e => e.CompName)
                    .HasMaxLength(50)
                    .HasColumnName("comp_name");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.ModuleId).HasColumnName("module_id");

                entity.Property(e => e.TableKey)
                    .HasMaxLength(30)
                    .HasColumnName("table_key");

                entity.Property(e => e.Tablename)
                    .HasMaxLength(50)
                    .HasColumnName("tablename");

                entity.Property(e => e.UserName)
                    .HasMaxLength(50)
                    .HasColumnName("user_name");
            });

            modelBuilder.Entity<AppsModuleAuthRef>(entity =>
            {
                entity.HasKey(e => new { e.ModuleId, e.AuthName })
                    .HasName("PRIMARY")
                    .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                entity.ToTable("apps_module_auth_ref");

                entity.Property(e => e.ModuleId).HasColumnName("module_id");

                entity.Property(e => e.AuthName)
                    .HasMaxLength(50)
                    .HasColumnName("auth_name");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("last_upd_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Objtype)
                    .HasMaxLength(2)
                    .HasColumnName("objtype")
                    .IsFixedLength();
            });

            modelBuilder.Entity<AppsModuleFldsRef>(entity =>
            {
                entity.HasKey(e => new { e.ModuleId, e.FieldName })
                    .HasName("PRIMARY")
                    .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                entity.ToTable("apps_module_flds_ref");

                entity.Property(e => e.ModuleId).HasColumnName("module_id");

                entity.Property(e => e.FieldName)
                    .HasMaxLength(20)
                    .HasColumnName("field_name");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Description)
                    .HasMaxLength(50)
                    .HasColumnName("description");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("last_upd_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");
            });

            modelBuilder.Entity<AppsModuleRef>(entity =>
            {
                entity.HasKey(e => e.ModuleId)
                    .HasName("PRIMARY");

                entity.ToTable("apps_module_ref");

                entity.Property(e => e.ModuleId).HasColumnName("module_id");

                entity.Property(e => e.Code)
                    .HasMaxLength(10)
                    .HasColumnName("code")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.CreatedBy)
                    .HasColumnName("created_by")
                    .HasDefaultValueSql("'0'");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.FolderPath)
                    .HasMaxLength(50)
                    .HasColumnName("folder_path")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.FormName)
                    .HasMaxLength(50)
                    .HasColumnName("form_name")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.IsAdmin)
                    .HasMaxLength(1)
                    .HasColumnName("is_admin")
                    .HasDefaultValueSql("'N'")
                    .IsFixedLength();

                entity.Property(e => e.IsParent)
                    .HasMaxLength(1)
                    .HasColumnName("is_parent")
                    .HasDefaultValueSql("'N'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("last_upd_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.MenuLevel).HasColumnName("menu_level");

                entity.Property(e => e.ModuleName)
                    .HasMaxLength(50)
                    .HasColumnName("module_name");

                entity.Property(e => e.PageName)
                    .HasMaxLength(50)
                    .HasColumnName("page_name")
                    .HasDefaultValueSql("''");

                entity.Property(e => e.ParentId).HasColumnName("parent_id");

                entity.Property(e => e.SortOrder).HasColumnName("sort_order");

                entity.Property(e => e.Type)
                    .HasMaxLength(5)
                    .HasColumnName("type");
            });

            modelBuilder.Entity<AppsPersonnelMstr>(entity =>
            {
                entity.HasKey(e => e.Uuid)
                    .HasName("PRIMARY");

                entity.ToTable("apps_personnel_mstr");

                entity.Property(e => e.Uuid)
                    .ValueGeneratedNever()
                    .HasColumnName("uuid");

                entity.Property(e => e.Contactno)
                    .HasMaxLength(50)
                    .HasColumnName("contactno");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .HasColumnName("email");

                entity.Property(e => e.Firstname)
                    .HasMaxLength(50)
                    .HasColumnName("firstname");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate).HasColumnName("last_upd_date");

                entity.Property(e => e.Lastname)
                    .HasMaxLength(50)
                    .HasColumnName("lastname");

                entity.HasOne(d => d.Uu)
                    .WithOne(p => p.AppsPersonnelMstr)
                    .HasForeignKey<AppsPersonnelMstr>(d => d.Uuid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_apps_personnel_mstr");
            });

            modelBuilder.Entity<AppsRoleModuleAuthRef>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("apps_role_module_auth_ref");

                entity.HasIndex(e => e.RoleId, "fk_apps_role_module_auth_ref00");

                entity.Property(e => e.AuthName)
                    .HasMaxLength(50)
                    .HasColumnName("auth_name");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("last_upd_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.ModuleId).HasColumnName("module_id");

                entity.Property(e => e.RoleId).HasColumnName("role_id");

                entity.Property(e => e.Value)
                    .HasMaxLength(20)
                    .HasColumnName("value");

                entity.HasOne(d => d.Role)
                    .WithMany()
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_apps_role_module_auth_ref00");
            });

            modelBuilder.Entity<AppsRoleModuleFldsRef>(entity =>
            {
                entity.HasKey(e => new { e.RoleId, e.ModuleId, e.FieldName })
                    .HasName("PRIMARY")
                    .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0, 0 });

                entity.ToTable("apps_role_module_flds_ref");

                entity.Property(e => e.RoleId).HasColumnName("role_id");

                entity.Property(e => e.ModuleId).HasColumnName("module_id");

                entity.Property(e => e.FieldName)
                    .HasMaxLength(50)
                    .HasColumnName("field_name");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("last_upd_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Value)
                    .HasMaxLength(2)
                    .HasColumnName("value")
                    .IsFixedLength();
            });

            modelBuilder.Entity<AppsRoleModuleRef>(entity =>
            {
                entity.HasKey(e => new { e.RoleId, e.ModuleId })
                    .HasName("PRIMARY")
                    .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                entity.ToTable("apps_role_module_ref");

                entity.Property(e => e.RoleId).HasColumnName("role_id");

                entity.Property(e => e.ModuleId).HasColumnName("module_id");

                entity.Property(e => e.Autohrztn)
                    .HasMaxLength(5)
                    .HasColumnName("autohrztn")
                    .HasDefaultValueSql("'YYYYY'")
                    .IsFixedLength();

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("last_upd_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");
            });

            modelBuilder.Entity<AppsRoleRef>(entity =>
            {
                entity.HasKey(e => e.RoleId)
                    .HasName("PRIMARY");

                entity.ToTable("apps_role_ref");

                entity.Property(e => e.RoleId).HasColumnName("role_id");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.IsAdmin)
                    .HasMaxLength(1)
                    .HasColumnName("is_admin")
                    .HasDefaultValueSql("'N'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("last_upd_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.ParentId).HasColumnName("parent_id");

                entity.Property(e => e.RoleDescription)
                    .HasMaxLength(100)
                    .HasColumnName("role_description");

                entity.Property(e => e.RoleName)
                    .HasMaxLength(50)
                    .HasColumnName("role_name");
            });

            modelBuilder.Entity<AppsUserMapper>(entity =>
            {
                entity.HasKey(e => e.Uuid)
                    .HasName("PRIMARY");

                entity.ToTable("apps_user_mapper");

                entity.Property(e => e.Uuid)
                    .ValueGeneratedNever()
                    .HasColumnName("uuid");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate).HasColumnName("last_upd_date");

                entity.Property(e => e.Password)
                    .HasMaxLength(100)
                    .HasColumnName("password")
                    .UseCollation("utf8_general_ci")
                    .HasCharSet("utf8");

                entity.Property(e => e.Saltkey)
                    .HasMaxLength(50)
                    .HasColumnName("saltkey")
                    .HasDefaultValueSql("''")
                    .UseCollation("utf8_general_ci")
                    .HasCharSet("utf8");

                entity.Property(e => e.Username)
                    .HasMaxLength(50)
                    .HasColumnName("username");

                entity.HasOne(d => d.Uu)
                    .WithOne(p => p.AppsUserMapper)
                    .HasForeignKey<AppsUserMapper>(d => d.Uuid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("fk_apps_user_mapper");
            });

            modelBuilder.Entity<AppsUserModuleLog>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("apps_user_module_logs");

                entity.Property(e => e.Cmprname)
                    .HasMaxLength(100)
                    .HasColumnName("cmprname");

                entity.Property(e => e.LogDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("log_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.ModuleId).HasColumnName("module_id");

                entity.Property(e => e.Srvrname)
                    .HasMaxLength(100)
                    .HasColumnName("srvrname");

                entity.Property(e => e.Username)
                    .HasMaxLength(100)
                    .HasColumnName("username");

                entity.Property(e => e.Uuid).HasColumnName("uuid");
            });

            modelBuilder.Entity<AppsUserRef>(entity =>
            {
                entity.HasKey(e => e.Uuid)
                    .HasName("PRIMARY");

                entity.ToTable("apps_user_ref");

                entity.Property(e => e.Uuid).HasColumnName("uuid");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Defmod).HasColumnName("defmod");

                entity.Property(e => e.Fullname)
                    .HasMaxLength(200)
                    .HasColumnName("fullname");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate).HasColumnName("last_upd_date");
            });

            modelBuilder.Entity<AppsUserRoleRef>(entity =>
            {
                entity.HasKey(e => new { e.Uuid, e.RoleId })
                    .HasName("PRIMARY")
                    .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0 });

                entity.ToTable("apps_user_role_ref");

                entity.Property(e => e.Uuid).HasColumnName("uuid");

                entity.Property(e => e.RoleId).HasColumnName("role_id");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("timestamp")
                    .HasColumnName("last_upd_date")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");
            });

            modelBuilder.Entity<AppsUserSession>(entity =>
            {
                entity.HasKey(e => new { e.Sessonid, e.Username, e.Logindate })
                    .HasName("PRIMARY")
                    .HasAnnotation("MySql:IndexPrefixLength", new[] { 0, 0, 0 });

                entity.ToTable("apps_user_session");

                entity.Property(e => e.Sessonid)
                    .HasMaxLength(100)
                    .HasColumnName("sessonid");

                entity.Property(e => e.Username)
                    .HasMaxLength(100)
                    .HasColumnName("username");

                entity.Property(e => e.Logindate)
                    .HasColumnType("timestamp")
                    .HasColumnName("logindate")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.Cmprname)
                    .HasMaxLength(100)
                    .HasColumnName("cmprname");

                entity.Property(e => e.Deactdate)
                    .HasColumnType("timestamp")
                    .HasColumnName("deactdate");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.Srvrname)
                    .HasMaxLength(100)
                    .HasColumnName("srvrname");

                entity.Property(e => e.Uuid).HasColumnName("uuid");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("users");

                entity.HasIndex(e => e.Email, "email")
                    .IsUnique();

                entity.Property(e => e.Id).HasColumnName("id");

                entity.Property(e => e.Avatar)
                    .HasMaxLength(255)
                    .HasColumnName("avatar")
                    .HasDefaultValueSql("'default.png'");

                entity.Property(e => e.Chngpass)
                    .HasMaxLength(1)
                    .HasColumnName("chngpass")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("timestamp")
                    .HasColumnName("created_at")
                    .HasDefaultValueSql("CURRENT_TIMESTAMP");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.Defmod).HasColumnName("defmod");

                entity.Property(e => e.Email).HasColumnName("email");

                entity.Property(e => e.EmailVerifiedAt)
                    .HasColumnType("timestamp")
                    .HasColumnName("email_verified_at");

                entity.Property(e => e.GoogleId)
                    .HasMaxLength(255)
                    .HasColumnName("google_id");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("'Y'")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.Name)
                    .HasMaxLength(255)
                    .HasColumnName("name");

                entity.Property(e => e.Password)
                    .HasMaxLength(255)
                    .HasColumnName("password");

                entity.Property(e => e.RememberToken)
                    .HasMaxLength(100)
                    .HasColumnName("remember_token");

                entity.Property(e => e.UpdatedAt)
                    .HasColumnType("timestamp")
                    .HasColumnName("updated_at");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
