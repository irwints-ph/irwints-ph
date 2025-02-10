using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsRoleModuleAuthRef
    {
        public int RoleId { get; set; }
        public int ModuleId { get; set; }
        public string AuthName { get; set; } = null!;
        public string Value { get; set; } = null!;
        public string? IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }

        public virtual AppsRoleRef Role { get; set; } = null!;
    }
}
