using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsRoleRef
    {
        public AppsRoleRef()
        {
            AppsRoleModuleFldsRefs = new HashSet<AppsRoleModuleFldsRef>();
            AppsRoleModuleRefs = new HashSet<AppsRoleModuleRef>();
            AppsUserRoleRefs = new HashSet<AppsUserRoleRef>();
        }

        public decimal RoleId { get; set; }
        public string? RoleName { get; set; }
        public string? RoleDescription { get; set; }
        public decimal? ParentId { get; set; }
        public string? IsActive { get; set; }
        public string? IsAdmin { get; set; }
        public decimal? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public decimal? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }

        public virtual AppsUserRef? CreatedByNavigation { get; set; }
        public virtual ICollection<AppsRoleModuleFldsRef> AppsRoleModuleFldsRefs { get; set; }
        public virtual ICollection<AppsRoleModuleRef> AppsRoleModuleRefs { get; set; }
        public virtual ICollection<AppsUserRoleRef> AppsUserRoleRefs { get; set; }
    }
}
