package org.dykman.jn.android.content.pm;
public class Signature extends android.content.pm.Signature{
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
public Signature(byte[] arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public Signature(java.lang.String arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean equals(java.lang.Object arg1) { if (!testjnOverride( "equals" )) return super.equals( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "equals_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int hashCode(){ if (!testjnOverride( "hashCode" )) return super.hashCode(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "hashCode_" + jlocale + "_", null ); }
@Override public char[] toChars(){ if (!testjnOverride( "toChars" )) return super.toChars(); return (char[]) jInterface.Jnidow( this, jchildidx + "toChars_" + jlocale + "_", null ); }
@Override public char[] toChars(char[] arg1,int[] arg2) { if (!testjnOverride( "toChars" )) return super.toChars( arg1, arg2); return (char[]) jInterface.Jnidow( this, jchildidx + "toChars_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public byte[] toByteArray(){ if (!testjnOverride( "toByteArray" )) return super.toByteArray(); return (byte[]) jInterface.Jnidoc( this, jchildidx + "toByteArray_" + jlocale + "_", null ); }
@Override public java.lang.String toCharsString(){ if (!testjnOverride( "toCharsString" )) return super.toCharsString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toCharsString_" + jlocale + "_", null ); }
@Override public int describeContents(){ if (!testjnOverride( "describeContents" )) return super.describeContents(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "describeContents_" + jlocale + "_", null ); }
@Override public void writeToParcel(android.os.Parcel arg1,int arg2) { if (!testjnOverride( "writeToParcel" )) { super.writeToParcel( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "writeToParcel_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
