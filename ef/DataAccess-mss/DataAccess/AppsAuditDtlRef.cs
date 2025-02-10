using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsAuditDtlRef
    {
        public decimal AuditId { get; set; }
        public decimal Linenubr { get; set; }
        public string Fieldnam { get; set; } = null!;
        public string? Oldvalue { get; set; }
        public string? Newvalue { get; set; }

        public virtual AppsAuditHdrRef Audit { get; set; } = null!;
    }
}
