using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsRoleModuleRef
    {
        public decimal RoleId { get; set; }
        public decimal ModuleId { get; set; }
        public string? Autohrztn { get; set; }
        public string? IsActive { get; set; }
        public decimal? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public decimal? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }

        public virtual AppsUserRef? CreatedByNavigation { get; set; }
        public virtual AppsModuleRef Module { get; set; } = null!;
        public virtual AppsRoleRef Role { get; set; } = null!;
    }
}
