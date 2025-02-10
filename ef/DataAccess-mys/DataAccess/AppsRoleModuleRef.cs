using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsRoleModuleRef
    {
        public int RoleId { get; set; }
        public int ModuleId { get; set; }
        public string? Autohrztn { get; set; }
        public string? IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }
    }
}
