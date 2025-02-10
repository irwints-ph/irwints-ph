using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsUserSession
    {
        public string Sessonid { get; set; } = null!;
        public string Username { get; set; } = null!;
        public DateTime Logindate { get; set; }
        public string? Cmprname { get; set; }
        public int? Uuid { get; set; }
        public string? Srvrname { get; set; }
        public string? IsActive { get; set; }
        public DateTime? Deactdate { get; set; }
    }
}
