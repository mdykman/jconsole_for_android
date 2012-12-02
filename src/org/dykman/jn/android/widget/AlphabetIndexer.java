package org.dykman.jn.android.widget;
public class AlphabetIndexer extends android.widget.AlphabetIndexer{
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
public AlphabetIndexer(android.database.Cursor arg1,int arg2,java.lang.CharSequence arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override protected int compare(java.lang.String arg1,java.lang.String arg2) { if (!testjnOverride( "compare" )) return super.compare( arg1, arg2); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "compare_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public java.lang.Object[] getSections(){ if (!testjnOverride( "getSections" )) return super.getSections(); return (java.lang.Object[]) jInterface.Jnidox( this, jchildidx + "getSections_" + jlocale + "_", null ); }
@Override public void setCursor(android.database.Cursor arg1) { if (!testjnOverride( "setCursor" )) { super.setCursor( arg1); return; } jInterface.Jnido( this, jchildidx + "setCursor_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getPositionForSection(int arg1) { if (!testjnOverride( "getPositionForSection" )) return super.getPositionForSection( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getPositionForSection_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getSectionForPosition(int arg1) { if (!testjnOverride( "getSectionForPosition" )) return super.getSectionForPosition( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getSectionForPosition_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onChanged(){ if (!testjnOverride( "onChanged" )) { super.onChanged(); return; } jInterface.Jnido( this, jchildidx + "onChanged_" + jlocale + "_", null ); }
@Override public void onInvalidated(){ if (!testjnOverride( "onInvalidated" )) { super.onInvalidated(); return; } jInterface.Jnido( this, jchildidx + "onInvalidated_" + jlocale + "_", null ); }
}
