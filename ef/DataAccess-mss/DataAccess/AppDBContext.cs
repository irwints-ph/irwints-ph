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
                optionsBuilder.UseSqlServer(_CS);
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<AppsAuditDtlRef>(entity =>
            {
                entity.HasKey(e => new { e.AuditId, e.Linenubr, e.Fieldnam })
                    .HasName("PK_APPS_AUDIT_DTL_REF01");

                entity.ToTable("APPS_AUDIT_DTL_REF");

                entity.Property(e => e.AuditId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("AUDIT_ID");

                entity.Property(e => e.Linenubr)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LINENUBR");

                entity.Property(e => e.Fieldnam)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("FIELDNAM");

                entity.Property(e => e.Newvalue)
                    .HasMaxLength(150)
                    .IsUnicode(false)
                    .HasColumnName("NEWVALUE");

                entity.Property(e => e.Oldvalue)
                    .HasMaxLength(150)
                    .IsUnicode(false)
                    .HasColumnName("OLDVALUE");

                entity.HasOne(d => d.Audit)
                    .WithMany(p => p.AppsAuditDtlRefs)
                    .HasForeignKey(d => d.AuditId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_AUDIT_DTL_REF01");
            });

            modelBuilder.Entity<AppsAuditHdrRef>(entity =>
            {
                entity.HasKey(e => e.AuditId)
                    .HasName("PK_APPS_AUDIT_HDR_REF01");

                entity.ToTable("APPS_AUDIT_HDR_REF");

                entity.Property(e => e.AuditId)
                    .HasColumnType("numeric(18, 0)")
                    .ValueGeneratedOnAdd()
                    .HasColumnName("AUDIT_ID");

                entity.Property(e => e.ActionRmrk)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.ActionType)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .IsFixedLength();

                entity.Property(e => e.CompName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("COMP_NAME");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.ModuleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("MODULE_ID");

                entity.Property(e => e.TableKey)
                    .HasMaxLength(30)
                    .IsUnicode(false)
                    .HasColumnName("table_key");

                entity.Property(e => e.TableName)
                    .HasMaxLength(50)
                    .IsUnicode(false);

                entity.Property(e => e.UserName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("USER_NAME");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.AppsAuditHdrRefs)
                    .HasForeignKey(d => d.CreatedBy)
                    .HasConstraintName("FK_APPS_AUDIT_HDR_REF01");
            });

            modelBuilder.Entity<AppsModuleAuthRef>(entity =>
            {
                entity.HasKey(e => new { e.ModuleId, e.AuthName })
                    .HasName("PK_APPS_MODULE_AUTH_REF_00");

                entity.ToTable("APPS_MODULE_AUTH_REF");

                entity.Property(e => e.ModuleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("MODULE_ID");

                entity.Property(e => e.AuthName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("AUTH_NAME");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.Property(e => e.Objtype)
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasColumnName("OBJTYPE")
                    .IsFixedLength();

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.AppsModuleAuthRefs)
                    .HasForeignKey(d => d.CreatedBy)
                    .HasConstraintName("FK_APPS_MODULE_AUTH_REF_01");

                entity.HasOne(d => d.Module)
                    .WithMany(p => p.AppsModuleAuthRefs)
                    .HasForeignKey(d => d.ModuleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_MODULE_AUTH_REF_00");
            });

            modelBuilder.Entity<AppsModuleFldsRef>(entity =>
            {
                entity.HasKey(e => new { e.ModuleId, e.FieldName })
                    .HasName("PK_APPS_MODULE_FLDS_REF_REF00");

                entity.ToTable("APPS_MODULE_FLDS_REF");

                entity.Property(e => e.ModuleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("MODULE_ID");

                entity.Property(e => e.FieldName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("FIELD_NAME");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.AppsModuleFldsRefs)
                    .HasForeignKey(d => d.CreatedBy)
                    .HasConstraintName("FK_APPS_MODULE_FLDS_REF01");

                entity.HasOne(d => d.Module)
                    .WithMany(p => p.AppsModuleFldsRefs)
                    .HasForeignKey(d => d.ModuleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_MODULE_FLDS_REF00");
            });

            modelBuilder.Entity<AppsModuleRef>(entity =>
            {
                entity.HasKey(e => e.ModuleId)
                    .HasName("PK_APPS_REF_MODULE00");

                entity.ToTable("APPS_MODULE_REF");

                entity.Property(e => e.ModuleId)
                    .HasColumnType("numeric(18, 0)")
                    .ValueGeneratedOnAdd()
                    .HasColumnName("MODULE_ID");

                entity.Property(e => e.Code)
                    .HasMaxLength(10)
                    .IsUnicode(false)
                    .HasColumnName("CODE");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.FolderPath)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("FOLDER_PATH");

                entity.Property(e => e.FormName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("form_name");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.IsAdmin)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ADMIN")
                    .HasDefaultValueSql("('N')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.Property(e => e.MenuLevel)
                    .HasColumnType("numeric(1, 0)")
                    .HasColumnName("MENU_LEVEL");

                entity.Property(e => e.ModuleName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("MODULE_NAME");

                entity.Property(e => e.PageName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("PAGE_NAME");

                entity.Property(e => e.ParentId)
                    .HasColumnType("numeric(10, 0)")
                    .HasColumnName("PARENT_ID");

                entity.Property(e => e.SortOrder)
                    .HasColumnType("numeric(3, 0)")
                    .HasColumnName("SORT_ORDER");

                entity.Property(e => e.Type)
                    .HasMaxLength(5)
                    .IsUnicode(false)
                    .HasColumnName("TYPE");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.AppsModuleRefs)
                    .HasForeignKey(d => d.CreatedBy)
                    .HasConstraintName("FK_APPS_REF_MODULE01");
            });

            modelBuilder.Entity<AppsPersonnelMstr>(entity =>
            {
                entity.HasKey(e => e.Uuid);

                entity.ToTable("APPS_PERSONNEL_MSTR");

                entity.Property(e => e.Uuid)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("UUID");

                entity.Property(e => e.Contactno)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("CONTACTNO");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Email)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("EMAIL");

                entity.Property(e => e.Firstname)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("FIRSTNAME");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.Property(e => e.Lastname)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("LASTNAME");

                entity.HasOne(d => d.Uu)
                    .WithOne(p => p.AppsPersonnelMstr)
                    .HasForeignKey<AppsPersonnelMstr>(d => d.Uuid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_PERSONNEL_MSTR");
            });

            modelBuilder.Entity<AppsRoleModuleAuthRef>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("APPS_ROLE_MODULE_AUTH_REF");

                entity.Property(e => e.AuthName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("AUTH_NAME");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.Property(e => e.ModuleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("MODULE_ID");

                entity.Property(e => e.RoleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("ROLE_ID");

                entity.Property(e => e.Value)
                    .HasMaxLength(20)
                    .IsUnicode(false)
                    .HasColumnName("VALUE");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany()
                    .HasForeignKey(d => d.CreatedBy)
                    .HasConstraintName("FK_APPS_ROLE_MODULE_AUTH_REF02");

                entity.HasOne(d => d.Module)
                    .WithMany()
                    .HasForeignKey(d => d.ModuleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_ROLE_MODULE_AUTH_REF01");

                entity.HasOne(d => d.Role)
                    .WithMany()
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_ROLE_MODULE_AUTH_REF00");
            });

            modelBuilder.Entity<AppsRoleModuleFldsRef>(entity =>
            {
                entity.HasKey(e => new { e.RoleId, e.ModuleId, e.FieldName })
                    .HasName("PK_APPS_ROLE_MODULE_FLDS00");

                entity.ToTable("APPS_ROLE_MODULE_FLDS_REF");

                entity.Property(e => e.RoleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("ROLE_ID");

                entity.Property(e => e.ModuleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("MODULE_ID");

                entity.Property(e => e.FieldName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("FIELD_NAME");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.Property(e => e.Value)
                    .HasMaxLength(2)
                    .IsUnicode(false)
                    .HasColumnName("VALUE")
                    .IsFixedLength();

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.AppsRoleModuleFldsRefs)
                    .HasForeignKey(d => d.CreatedBy)
                    .HasConstraintName("FK_APPS_ROLE_MODULE_FLDS02");

                entity.HasOne(d => d.Module)
                    .WithMany(p => p.AppsRoleModuleFldsRefs)
                    .HasForeignKey(d => d.ModuleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_ROLE_MODULE_FLDS00");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.AppsRoleModuleFldsRefs)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_ROLE_MODULE_FLDS01");
            });

            modelBuilder.Entity<AppsRoleModuleRef>(entity =>
            {
                entity.HasKey(e => new { e.RoleId, e.ModuleId })
                    .HasName("PK_APPS_REF_ROLE_MODULE00");

                entity.ToTable("APPS_ROLE_MODULE_REF");

                entity.Property(e => e.RoleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("ROLE_ID");

                entity.Property(e => e.ModuleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("MODULE_ID");

                entity.Property(e => e.Autohrztn)
                    .HasMaxLength(5)
                    .IsUnicode(false)
                    .HasColumnName("AUTOHRZTN")
                    .HasDefaultValueSql("('YYYYY')")
                    .IsFixedLength();

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.AppsRoleModuleRefs)
                    .HasForeignKey(d => d.CreatedBy)
                    .HasConstraintName("FK_APPS_REF_ROLE_MODULE03");

                entity.HasOne(d => d.Module)
                    .WithMany(p => p.AppsRoleModuleRefs)
                    .HasForeignKey(d => d.ModuleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_REF_ROLE_MODULE02");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.AppsRoleModuleRefs)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_REF_ROLE_MODULE01");
            });

            modelBuilder.Entity<AppsRoleRef>(entity =>
            {
                entity.HasKey(e => e.RoleId)
                    .HasName("PK_APPS_REF_ROLE00");

                entity.ToTable("APPS_ROLE_REF");

                entity.Property(e => e.RoleId)
                    .HasColumnType("numeric(18, 0)")
                    .ValueGeneratedOnAdd()
                    .HasColumnName("ROLE_ID");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.IsAdmin)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ADMIN")
                    .HasDefaultValueSql("('N')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.Property(e => e.ParentId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("PARENT_ID");

                entity.Property(e => e.RoleDescription)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("ROLE_DESCRIPTION");

                entity.Property(e => e.RoleName)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("ROLE_NAME");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.AppsRoleRefs)
                    .HasForeignKey(d => d.CreatedBy)
                    .HasConstraintName("FK_APPS_REF_ROLE01");
            });

            modelBuilder.Entity<AppsUserMapper>(entity =>
            {
                entity.HasKey(e => e.Uuid);

                entity.ToTable("APPS_USER_MAPPER");

                entity.Property(e => e.Uuid)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("UUID");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.Property(e => e.Password)
                    .HasMaxLength(100)
                    .HasColumnName("PASSWORD");

                entity.Property(e => e.Saltkey)
                    .HasMaxLength(50)
                    .HasColumnName("SALTKEY");

                entity.Property(e => e.Username)
                    .HasMaxLength(50)
                    .IsUnicode(false)
                    .HasColumnName("USERNAME");

                entity.HasOne(d => d.Uu)
                    .WithOne(p => p.AppsUserMapper)
                    .HasForeignKey<AppsUserMapper>(d => d.Uuid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_USER_MAPPER");
            });

            modelBuilder.Entity<AppsUserModuleLog>(entity =>
            {
                entity.HasNoKey();

                entity.ToTable("APPS_USER_MODULE_LOGS");

                entity.Property(e => e.Cmprname)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("CMPRNAME");

                entity.Property(e => e.LogDate)
                    .HasColumnType("date")
                    .HasColumnName("LOG_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.ModuleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("MODULE_ID");

                entity.Property(e => e.Srvrname)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("SRVRNAME");

                entity.Property(e => e.Time)
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasColumnName("TIME")
                    .HasDefaultValueSql("((replace(str(datepart(hour,getdate()),(2)),' ','0')+replace(str(datepart(minute,getdate()),(2)),' ','0'))+replace(str(datepart(second,getdate()),(2)),' ','0'))")
                    .IsFixedLength();

                entity.Property(e => e.Username)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("USERNAME");

                entity.Property(e => e.Uuid)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("UUID");

                entity.HasOne(d => d.Module)
                    .WithMany()
                    .HasForeignKey(d => d.ModuleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_USER_ML01");

                entity.HasOne(d => d.Uu)
                    .WithMany()
                    .HasForeignKey(d => d.Uuid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_USER_ML02");
            });

            modelBuilder.Entity<AppsUserRef>(entity =>
            {
                entity.HasKey(e => e.Uuid)
                    .HasName("PK_APPS_REF_USERS_PK00");

                entity.ToTable("APPS_USER_REF");

                entity.Property(e => e.Uuid)
                    .HasColumnType("numeric(18, 0)")
                    .ValueGeneratedOnAdd()
                    .HasColumnName("UUID");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Defmod)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("DEFMOD");

                entity.Property(e => e.Fullname)
                    .HasMaxLength(200)
                    .IsUnicode(false)
                    .HasColumnName("FULLNAME");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");
            });

            modelBuilder.Entity<AppsUserRoleRef>(entity =>
            {
                entity.HasKey(e => new { e.Uuid, e.RoleId })
                    .HasName("PK_APPS_REF_USER_ROLE00");

                entity.ToTable("APPS_USER_ROLE_REF");

                entity.Property(e => e.Uuid)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("UUID");

                entity.Property(e => e.RoleId)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("ROLE_ID");

                entity.Property(e => e.CreatedBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("CREATED_BY");

                entity.Property(e => e.CreatedDate)
                    .HasColumnType("date")
                    .HasColumnName("CREATED_DATE")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("LAST_UPD_BY");

                entity.Property(e => e.LastUpdDate)
                    .HasColumnType("date")
                    .HasColumnName("LAST_UPD_DATE");

                entity.HasOne(d => d.CreatedByNavigation)
                    .WithMany(p => p.AppsUserRoleRefCreatedByNavigations)
                    .HasForeignKey(d => d.CreatedBy)
                    .HasConstraintName("FK_APPS_REF_USER_ROLE03");

                entity.HasOne(d => d.Role)
                    .WithMany(p => p.AppsUserRoleRefs)
                    .HasForeignKey(d => d.RoleId)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_REF_USER_ROLE02");

                entity.HasOne(d => d.Uu)
                    .WithMany(p => p.AppsUserRoleRefUus)
                    .HasForeignKey(d => d.Uuid)
                    .OnDelete(DeleteBehavior.ClientSetNull)
                    .HasConstraintName("FK_APPS_REF_USER_ROLE01");
            });

            modelBuilder.Entity<AppsUserSession>(entity =>
            {
                entity.HasKey(e => new { e.Sessonid, e.Username, e.Logindate, e.Logintime });

                entity.ToTable("APPS_USER_SESSION");

                entity.Property(e => e.Sessonid)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("SESSONID");

                entity.Property(e => e.Username)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("USERNAME");

                entity.Property(e => e.Logindate)
                    .HasColumnType("date")
                    .HasColumnName("logindate")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.Logintime)
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasColumnName("logintime")
                    .IsFixedLength();

                entity.Property(e => e.Cmprname)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("CMPRNAME");

                entity.Property(e => e.Deactdate)
                    .HasColumnType("date")
                    .HasColumnName("deactdate");

                entity.Property(e => e.Deacttime)
                    .HasMaxLength(6)
                    .IsUnicode(false)
                    .HasColumnName("deacttime")
                    .IsFixedLength();

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("IS_ACTIVE")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.Srvrname)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("SRVRNAME");

                entity.Property(e => e.Uuid)
                    .HasColumnType("numeric(18, 0)")
                    .HasColumnName("UUID");
            });

            modelBuilder.Entity<User>(entity =>
            {
                entity.ToTable("users");

                entity.HasIndex(e => e.Email, "UQ__users__AB6E616407CFFDA8")
                    .IsUnique();

                entity.Property(e => e.Id)
                    .HasColumnType("numeric(18, 0)")
                    .ValueGeneratedOnAdd()
                    .HasColumnName("id");

                entity.Property(e => e.Avatar)
                    .HasMaxLength(255)
                    .IsUnicode(false)
                    .HasColumnName("avatar")
                    .HasDefaultValueSql("('default.png')");

                entity.Property(e => e.Chngpass)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("chngpass")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.CreatedAt)
                    .HasColumnType("datetime")
                    .HasColumnName("created_at")
                    .HasDefaultValueSql("(getdate())");

                entity.Property(e => e.CreatedBy).HasColumnName("created_by");

                entity.Property(e => e.Defmod).HasColumnName("defmod");

                entity.Property(e => e.Email)
                    .HasMaxLength(255)
                    .IsUnicode(false)
                    .HasColumnName("email");

                entity.Property(e => e.EmailVerifiedAt)
                    .HasColumnType("datetime")
                    .HasColumnName("email_verified_at");

                entity.Property(e => e.GoogleId)
                    .HasMaxLength(255)
                    .IsUnicode(false)
                    .HasColumnName("google_id");

                entity.Property(e => e.IsActive)
                    .HasMaxLength(1)
                    .IsUnicode(false)
                    .HasColumnName("is_active")
                    .HasDefaultValueSql("('Y')")
                    .IsFixedLength();

                entity.Property(e => e.LastUpdBy).HasColumnName("last_upd_by");

                entity.Property(e => e.Name)
                    .HasMaxLength(255)
                    .IsUnicode(false)
                    .HasColumnName("name");

                entity.Property(e => e.Password)
                    .HasMaxLength(255)
                    .IsUnicode(false)
                    .HasColumnName("password");

                entity.Property(e => e.RememberToken)
                    .HasMaxLength(100)
                    .IsUnicode(false)
                    .HasColumnName("remember_token");

                entity.Property(e => e.UpdatedAt)
                    .HasColumnType("datetime")
                    .HasColumnName("updated_at");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
