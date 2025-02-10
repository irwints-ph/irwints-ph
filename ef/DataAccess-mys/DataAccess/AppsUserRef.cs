using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsUserRef
    {
        public int Uuid { get; set; }
        public string? Fullname { get; set; }
        public int Defmod { get; set; }
        public string? IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateOnly? LastUpdDate { get; set; }

        public virtual AppsPersonnelMstr AppsPersonnelMstr { get; set; } = null!;
        public virtual AppsUserMapper AppsUserMapper { get; set; } = null!;
    }
}
