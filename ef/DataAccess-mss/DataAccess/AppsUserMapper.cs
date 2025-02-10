using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsUserMapper
    {
        public decimal Uuid { get; set; }
        public string Username { get; set; } = null!;
        public string Password { get; set; } = null!;
        public string Saltkey { get; set; } = null!;
        public string? IsActive { get; set; }
        public decimal? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public decimal? LastUpdBy { get; set; }
        public DateTime? LastUpdDate { get; set; }

        public virtual AppsUserRef Uu { get; set; } = null!;
    }
}
