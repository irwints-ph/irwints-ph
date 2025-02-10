using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsModuleFldsRef
    {
        public int ModuleId { get; set; }
        public string FieldName { get; set; } = null!;
        public string Description { get; set; } = null!;
        public string? IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }
    }
}
