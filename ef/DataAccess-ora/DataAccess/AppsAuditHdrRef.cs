using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsAuditHdrRef
    {
        public AppsAuditHdrRef()
        {
            AppsAuditDtlRefs = new HashSet<AppsAuditDtlRef>();
        }

        public decimal AuditId { get; set; }
        public string Actiontype { get; set; } = null!;
        public string? UserName { get; set; }
        public string? CompName { get; set; }
        public decimal? ModuleId { get; set; }
        public string? Tablename { get; set; }
        public string? TableKey { get; set; }
        public string? Actionrmrk { get; set; }
        public decimal? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }

        public virtual AppsUserRef? CreatedByNavigation { get; set; }
        public virtual ICollection<AppsAuditDtlRef> AppsAuditDtlRefs { get; set; }
    }
}
