using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsRoleRef
    {
        public int RoleId { get; set; }
        public string? RoleName { get; set; }
        public string? RoleDescription { get; set; }
        public int? ParentId { get; set; }
        public string? IsActive { get; set; }
        public string? IsAdmin { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }
    }
}
