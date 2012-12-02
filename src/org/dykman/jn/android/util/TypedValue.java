package org.dykman.jn.android.util;
public class TypedValue extends android.util.TypedValue{
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
public TypedValue(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public java.lang.String toString(){ if (!testjnOverride( "toString" )) return super.toString(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "toString_" + jlocale + "_", null ); }
@Override public float getDimension(android.util.DisplayMetrics arg1) { if (!testjnOverride( "getDimension" )) return super.getDimension( arg1); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getDimension_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getFraction(float arg1,float arg2) { if (!testjnOverride( "getFraction" )) return super.getFraction( arg1, arg2); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getFraction_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setTo(android.util.TypedValue arg1) { if (!testjnOverride( "setTo" )) { super.setTo( arg1); return; } jInterface.Jnido( this, jchildidx + "setTo_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
