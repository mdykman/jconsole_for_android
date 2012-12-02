package org.dykman.jn.android.text.util;
public class Rfc822Tokenizer extends android.text.util.Rfc822Tokenizer{
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
public Rfc822Tokenizer(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public int findTokenStart(java.lang.CharSequence arg1,int arg2) { if (!testjnOverride( "findTokenStart" )) return super.findTokenStart( arg1, arg2); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "findTokenStart_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int findTokenEnd(java.lang.CharSequence arg1,int arg2) { if (!testjnOverride( "findTokenEnd" )) return super.findTokenEnd( arg1, arg2); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "findTokenEnd_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public java.lang.CharSequence terminateToken(java.lang.CharSequence arg1) { if (!testjnOverride( "terminateToken" )) return super.terminateToken( arg1); return (java.lang.CharSequence) jInterface.Jnido( this, jchildidx + "terminateToken_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
