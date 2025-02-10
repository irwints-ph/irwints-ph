using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsModuleRef
    {
        public int ModuleId { get; set; }
        public string? ModuleName { get; set; }
        public int? ParentId { get; set; }
        public int MenuLevel { get; set; }
        public int? SortOrder { get; set; }
        public string? FormName { get; set; }
        public string? PageName { get; set; }
        public string? FolderPath { get; set; }
        public string? Type { get; set; }
        public string? IsParent { get; set; }
        public string? Code { get; set; }
        public string? IsActive { get; set; }
        public string? IsAdmin { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }
    }
}
