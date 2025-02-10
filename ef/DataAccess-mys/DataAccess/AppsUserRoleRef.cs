using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsUserRoleRef
    {
        public int Uuid { get; set; }
        public int RoleId { get; set; }
        public string? IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }
    }
}
