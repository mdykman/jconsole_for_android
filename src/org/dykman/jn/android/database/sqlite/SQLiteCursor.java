package org.dykman.jn.android.database.sqlite;
public class SQLiteCursor extends android.database.sqlite.SQLiteCursor{
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
public SQLiteCursor(android.database.sqlite.SQLiteDatabase arg1,android.database.sqlite.SQLiteCursorDriver arg2,java.lang.String arg3,android.database.sqlite.SQLiteQuery arg4, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override protected void finalize(){ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public void close(){ if (!testjnOverride( "close" )) { super.close(); return; } jInterface.Jnido( this, jchildidx + "close_" + jlocale + "_", null ); }
@Override public void registerDataSetObserver(android.database.DataSetObserver arg1) { if (!testjnOverride( "registerDataSetObserver" )) { super.registerDataSetObserver( arg1); return; } jInterface.Jnido( this, jchildidx + "registerDataSetObserver_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.database.sqlite.SQLiteDatabase getDatabase(){ if (!testjnOverride( "getDatabase" )) return super.getDatabase(); return (android.database.sqlite.SQLiteDatabase) jInterface.Jnido( this, jchildidx + "getDatabase_" + jlocale + "_", null ); }
@Override public boolean onMove(int arg1,int arg2) { if (!testjnOverride( "onMove" )) return super.onMove( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onMove_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int getCount(){ if (!testjnOverride( "getCount" )) return super.getCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCount_" + jlocale + "_", null ); }
@Override public int getColumnIndex(java.lang.String arg1) { if (!testjnOverride( "getColumnIndex" )) return super.getColumnIndex( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getColumnIndex_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String[] getColumnNames(){ if (!testjnOverride( "getColumnNames" )) return super.getColumnNames(); return (java.lang.String[]) jInterface.Jnidox( this, jchildidx + "getColumnNames_" + jlocale + "_", null ); }
@Override public void deactivate(){ if (!testjnOverride( "deactivate" )) { super.deactivate(); return; } jInterface.Jnido( this, jchildidx + "deactivate_" + jlocale + "_", null ); }
@Override public boolean requery(){ if (!testjnOverride( "requery" )) return super.requery(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "requery_" + jlocale + "_", null ); }
@Override public void setWindow(android.database.CursorWindow arg1) { if (!testjnOverride( "setWindow" )) { super.setWindow( arg1); return; } jInterface.Jnido( this, jchildidx + "setWindow_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setSelectionArguments(java.lang.String[] arg1) { if (!testjnOverride( "setSelectionArguments" )) { super.setSelectionArguments( arg1); return; } jInterface.Jnido( this, jchildidx + "setSelectionArguments_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
