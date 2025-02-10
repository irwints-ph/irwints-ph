using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsModuleRef
    {
        public AppsModuleRef()
        {
            AppsModuleAuthRefs = new HashSet<AppsModuleAuthRef>();
            AppsModuleFldsRefs = new HashSet<AppsModuleFldsRef>();
            AppsRoleModuleFldsRefs = new HashSet<AppsRoleModuleFldsRef>();
            AppsRoleModuleRefs = new HashSet<AppsRoleModuleRef>();
        }

        public decimal ModuleId { get; set; }
        public string? ModuleName { get; set; }
        public decimal? ParentId { get; set; }
        public decimal MenuLevel { get; set; }
        public decimal? SortOrder { get; set; }
        public string? FormName { get; set; }
        public string? PageName { get; set; }
        public string? FolderPath { get; set; }
        public string? Type { get; set; }
        public string? Code { get; set; }
        public string? IsActive { get; set; }
        public string? IsAdmin { get; set; }
        public decimal? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public decimal? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }

        public virtual AppsUserRef? CreatedByNavigation { get; set; }
        public virtual ICollection<AppsModuleAuthRef> AppsModuleAuthRefs { get; set; }
        public virtual ICollection<AppsModuleFldsRef> AppsModuleFldsRefs { get; set; }
        public virtual ICollection<AppsRoleModuleFldsRef> AppsRoleModuleFldsRefs { get; set; }
        public virtual ICollection<AppsRoleModuleRef> AppsRoleModuleRefs { get; set; }
    }
}
