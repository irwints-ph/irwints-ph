using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsUserRef
    {
        public AppsUserRef()
        {
            AppsAuditHdrRefs = new HashSet<AppsAuditHdrRef>();
            AppsModuleAuthRefs = new HashSet<AppsModuleAuthRef>();
            AppsModuleFldsRefs = new HashSet<AppsModuleFldsRef>();
            AppsModuleRefs = new HashSet<AppsModuleRef>();
            AppsRoleModuleFldsRefs = new HashSet<AppsRoleModuleFldsRef>();
            AppsRoleModuleRefs = new HashSet<AppsRoleModuleRef>();
            AppsRoleRefs = new HashSet<AppsRoleRef>();
            AppsUserRoleRefCreatedByNavigations = new HashSet<AppsUserRoleRef>();
            AppsUserRoleRefUus = new HashSet<AppsUserRoleRef>();
        }

        public decimal Uuid { get; set; }
        public string? Fullname { get; set; }
        public decimal Defmod { get; set; }
        public string? IsActive { get; set; }
        public decimal? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public decimal? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }

        public virtual AppsPersonnelMstr AppsPersonnelMstr { get; set; } = null!;
        public virtual AppsUserMapper AppsUserMapper { get; set; } = null!;
        public virtual ICollection<AppsAuditHdrRef> AppsAuditHdrRefs { get; set; }
        public virtual ICollection<AppsModuleAuthRef> AppsModuleAuthRefs { get; set; }
        public virtual ICollection<AppsModuleFldsRef> AppsModuleFldsRefs { get; set; }
        public virtual ICollection<AppsModuleRef> AppsModuleRefs { get; set; }
        public virtual ICollection<AppsRoleModuleFldsRef> AppsRoleModuleFldsRefs { get; set; }
        public virtual ICollection<AppsRoleModuleRef> AppsRoleModuleRefs { get; set; }
        public virtual ICollection<AppsRoleRef> AppsRoleRefs { get; set; }
        public virtual ICollection<AppsUserRoleRef> AppsUserRoleRefCreatedByNavigations { get; set; }
        public virtual ICollection<AppsUserRoleRef> AppsUserRoleRefUus { get; set; }
    }
}
