package org.dykman.jn.android.database.sqlite;
public class SQLiteDatabase$CursorFactory2 implements android.database.sqlite.SQLiteDatabase.CursorFactory{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public SQLiteDatabase$CursorFactory2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public android.database.Cursor newCursor(android.database.sqlite.SQLiteDatabase arg1,android.database.sqlite.SQLiteCursorDriver arg2,java.lang.String arg3,android.database.sqlite.SQLiteQuery arg4) { return (android.database.Cursor) jInterface.Jnido( this, "newCursor_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
}
