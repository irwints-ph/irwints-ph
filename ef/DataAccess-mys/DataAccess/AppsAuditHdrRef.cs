using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsAuditHdrRef
    {
        public int AuditId { get; set; }
        public string Actiontype { get; set; } = null!;
        public string? UserName { get; set; }
        public string? CompName { get; set; }
        public int? ModuleId { get; set; }
        public string? Tablename { get; set; }
        public string? TableKey { get; set; }
        public string? Actionrmrk { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
    }
}
