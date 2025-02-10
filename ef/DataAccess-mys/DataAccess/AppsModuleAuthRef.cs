using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsModuleAuthRef
    {
        public int ModuleId { get; set; }
        public string AuthName { get; set; } = null!;
        public string Objtype { get; set; } = null!;
        public string? IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }
    }
}
