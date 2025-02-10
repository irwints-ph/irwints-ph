using System;
using System.Collections.Generic;

namespace DataLayer
{
    public partial class AppsUserModuleLog
    {
        public int ModuleId { get; set; }
        public int Uuid { get; set; }
        public DateTime? LogDate { get; set; }
        public string Username { get; set; } = null!;
        public string? Cmprname { get; set; }
        public string? Srvrname { get; set; }
    }
}
