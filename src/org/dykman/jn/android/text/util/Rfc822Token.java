package org.dykman.jn.android.text.util;
public class Rfc822Token extends android.text.util.Rfc822Token{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected java.util.ArrayList jnOverrideList = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid, java.lang.String joverride ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; if (joverride != null && joverride.length() > 0) { java.lang.String[] ss = joverride.split(" "); for (int i = 0; i < ss.length; i++) setjnOverride(ss[i]); } }
public void clearjnOverride () { jnOverrideList.clear (); }
public void setjnOverride (java.lang.String arg1 ) { if (!testjnOverride (arg1)) jnOverrideList.add (arg1); }
public void setjnOverride (java.lang.String arg1, boolean arg2 ) { if (arg2) { if (!testjnOverride (arg1)) jnOverrideList.add (arg1); } else jnOverrideList.remove (arg1); }
public boolean testjnOverride (java.lang.String arg1 ) { return jnOverrideList.contains (arg1); }
public Rfc822Token(java.lang.String arg1,java.lang.String arg2,java.lang.String arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public boolean equals(java.lang.Object arg1) { if (!testjnOverride( "equals" )) return super.equals( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "equals_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public int hashCode(){ if (!testjnOverride( "hashCode" )) return super.hashCode(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "hashCode_" + jlocale + "_", null ); }
@Override public java.lang.String getAddress(){ if (!testjnOverride( "getAddress" )) return super.getAddress(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getAddress_" + jlocale + "_", null ); }
@Override public java.lang.String getName(){ if (!testjnOverride( "getName" )) return super.getName(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getName_" + jlocale + "_", null ); }
@Override public void setName(java.lang.String arg1) { if (!testjnOverride( "setName" )) { super.setName( arg1); return; } jInterface.Jnido( this, jchildidx + "setName_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getComment(){ if (!testjnOverride( "getComment" )) return super.getComment(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getComment_" + jlocale + "_", null ); }
@Override public void setComment(java.lang.String arg1) { if (!testjnOverride( "setComment" )) { super.setComment( arg1); return; } jInterface.Jnido( this, jchildidx + "setComment_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setAddress(java.lang.String arg1) { if (!testjnOverride( "setAddress" )) { super.setAddress( arg1); return; } jInterface.Jnido( this, jchildidx + "setAddress_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
