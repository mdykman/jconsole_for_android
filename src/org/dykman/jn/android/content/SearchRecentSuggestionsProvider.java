package org.dykman.jn.android.content;
public class SearchRecentSuggestionsProvider extends android.content.SearchRecentSuggestionsProvider{
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
public SearchRecentSuggestionsProvider(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public java.lang.String getType(android.net.Uri arg1) { if (!testjnOverride( "getType" )) return super.getType( arg1); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getType_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int delete(android.net.Uri arg1,java.lang.String arg2,java.lang.String[] arg3) { if (!testjnOverride( "delete" )) return super.delete( arg1, arg2, arg3); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "delete_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public android.net.Uri insert(android.net.Uri arg1,android.content.ContentValues arg2) { if (!testjnOverride( "insert" )) return super.insert( arg1, arg2); return (android.net.Uri) jInterface.Jnido( this, jchildidx + "insert_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.database.Cursor query(android.net.Uri arg1,java.lang.String[] arg2,java.lang.String arg3,java.lang.String[] arg4,java.lang.String arg5) { if (!testjnOverride( "query" )) return super.query( arg1, arg2, arg3, arg4, arg5); return (android.database.Cursor) jInterface.Jnido( this, jchildidx + "query_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public int update(android.net.Uri arg1,android.content.ContentValues arg2,java.lang.String arg3,java.lang.String[] arg4) { if (!testjnOverride( "update" )) return super.update( arg1, arg2, arg3, arg4); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "update_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override protected void setupSuggestions(java.lang.String arg1,int arg2) { if (!testjnOverride( "setupSuggestions" )) { super.setupSuggestions( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setupSuggestions_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean onCreate(){ if (!testjnOverride( "onCreate" )) return super.onCreate(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onCreate_" + jlocale + "_", null ); }
}
