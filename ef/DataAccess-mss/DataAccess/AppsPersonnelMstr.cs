using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsPersonnelMstr
    {
        public decimal Uuid { get; set; }
        public string? Email { get; set; }
        public string? Lastname { get; set; }
        public string? Firstname { get; set; }
        public string? Contactno { get; set; }
        public string? IsActive { get; set; }
        public decimal? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public decimal? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }

        public virtual AppsUserRef Uu { get; set; } = null!;
    }
}
