using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsPersonnelMstr
    {
        public int Uuid { get; set; }
        public string? Email { get; set; }
        public string? Lastname { get; set; }
        public string? Firstname { get; set; }
        public string? Contactno { get; set; }
        public string? IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateOnly? LastUpdDate { get; set; }

        public virtual AppsUserRef Uu { get; set; } = null!;
    }
}
