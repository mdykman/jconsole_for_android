package org.dykman.jn.android.text.method;
public class DigitsKeyListener extends android.text.method.DigitsKeyListener{
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
public DigitsKeyListener(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public DigitsKeyListener(boolean arg1,boolean arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected char[] getAcceptedChars(){ if (!testjnOverride( "getAcceptedChars" )) return super.getAcceptedChars(); return (char[]) jInterface.Jnidow( this, jchildidx + "getAcceptedChars_" + jlocale + "_", null ); }
@Override public int getInputType(){ if (!testjnOverride( "getInputType" )) return super.getInputType(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getInputType_" + jlocale + "_", null ); }
@Override public java.lang.CharSequence filter(java.lang.CharSequence arg1,int arg2,int arg3,android.text.Spanned arg4,int arg5,int arg6) { if (!testjnOverride( "filter" )) return super.filter( arg1, arg2, arg3, arg4, arg5, arg6); return (java.lang.CharSequence) jInterface.Jnido( this, jchildidx + "filter_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
}
