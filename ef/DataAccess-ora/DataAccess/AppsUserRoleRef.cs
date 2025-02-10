using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsUserRoleRef
    {
        public decimal Uuid { get; set; }
        public decimal RoleId { get; set; }
        public string? IsActive { get; set; }
        public decimal? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public decimal? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }

        public virtual AppsUserRef? CreatedByNavigation { get; set; }
        public virtual AppsRoleRef Role { get; set; } = null!;
        public virtual AppsUserRef Uu { get; set; } = null!;
    }
}
