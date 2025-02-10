using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsUserMapper
    {
        public int Uuid { get; set; }
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string? Saltkey { get; set; }
        public string? IsActive { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? LastUpdBy { get; set; }
        public DateOnly? LastUpdDate { get; set; }

        public virtual AppsUserRef Uu { get; set; } = null!;
    }
}
