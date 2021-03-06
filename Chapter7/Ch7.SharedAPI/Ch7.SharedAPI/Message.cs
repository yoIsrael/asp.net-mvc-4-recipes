//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Ch7.SharedAPI
{
    using System;
    using System.Collections.Generic;
    
    public partial class Message
    {
        public Message()
        {
            this.MessageRecipients = new HashSet<MessageRecipient>();
        }
    
        public int MessageId { get; set; }
        public int ArtistID { get; set; }
        public string Subject { get; set; }
        public short Importance { get; set; }
        public System.DateTime DateSent { get; set; }
        public string MessageBody { get; set; }
    
        public virtual ICollection<MessageRecipient> MessageRecipients { get; set; }
        public virtual Artist Artist { get; set; }
    }
}
