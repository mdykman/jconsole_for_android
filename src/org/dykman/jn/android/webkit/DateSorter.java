package org.dykman.jn.android.webkit;
public class DateSorter extends android.webkit.DateSorter{
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
public DateSorter(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getIndex(long arg1) { if (!testjnOverride( "getIndex" )) return super.getIndex( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getIndex_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getLabel(int arg1) { if (!testjnOverride( "getLabel" )) return super.getLabel( arg1); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getLabel_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public long getBoundary(int arg1) { if (!testjnOverride( "getBoundary" )) return super.getBoundary( arg1); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getBoundary_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
