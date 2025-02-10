using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class User
    {
        public decimal Id { get; set; }
        public string Name { get; set; } = null!;
        public string Email { get; set; } = null!;
        public string Avatar { get; set; } = null!;
        public DateTime? EmailVerifiedAt { get; set; }
        public string? Password { get; set; }
        public string? RememberToken { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public string? GoogleId { get; set; }
        public int? Defmod { get; set; }
        public string? IsActive { get; set; }
        public string? Chngpass { get; set; }
        public int? CreatedBy { get; set; }
        public int? LastUpdBy { get; set; }
    }
}
