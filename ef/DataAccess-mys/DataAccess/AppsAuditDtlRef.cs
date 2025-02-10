using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsAuditDtlRef
    {
        public int AuditId { get; set; }
        public int Linenubr { get; set; }
        public string Fieldnam { get; set; } = null!;
        public string? Oldvalue { get; set; }
        public string? Newvalue { get; set; }
    }
}
