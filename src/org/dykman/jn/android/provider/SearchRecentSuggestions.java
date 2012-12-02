package org.dykman.jn.android.provider;
public class SearchRecentSuggestions extends android.provider.SearchRecentSuggestions{
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
public SearchRecentSuggestions(android.content.Context arg1,java.lang.String arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void saveRecentQuery(java.lang.String arg1,java.lang.String arg2) { if (!testjnOverride( "saveRecentQuery" )) { super.saveRecentQuery( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "saveRecentQuery_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void clearHistory(){ if (!testjnOverride( "clearHistory" )) { super.clearHistory(); return; } jInterface.Jnido( this, jchildidx + "clearHistory_" + jlocale + "_", null ); }
@Override protected void truncateHistory(android.content.ContentResolver arg1,int arg2) { if (!testjnOverride( "truncateHistory" )) { super.truncateHistory( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "truncateHistory_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
