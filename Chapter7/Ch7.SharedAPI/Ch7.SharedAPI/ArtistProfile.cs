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
    
    public partial class ArtistProfile
    {
        public int ArtistId { get; set; }
        public string Bio { get; set; }
        public string MusicalInfluences { get; set; }
        public string ProfileTemplateName { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
    
        public virtual Artist Artist { get; set; }
    }
}