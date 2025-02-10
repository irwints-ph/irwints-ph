using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsUserModuleLog
    {
        public decimal ModuleId { get; set; }
        public decimal Uuid { get; set; }
        public DateTime? LogDate { get; set; }
        public string Time { get; set; } = null!;
        public string Username { get; set; } = null!;
        public string? Cmprname { get; set; }
        public string? Srvrname { get; set; }

        public virtual AppsModuleRef Module { get; set; } = null!;
        public virtual AppsUserRef Uu { get; set; } = null!;
    }
}
