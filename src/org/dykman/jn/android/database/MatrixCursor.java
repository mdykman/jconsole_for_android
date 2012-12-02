package org.dykman.jn.android.database;
public class MatrixCursor extends android.database.MatrixCursor{
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
public MatrixCursor(java.lang.String[] arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public MatrixCursor(java.lang.String[] arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public short getShort(int arg1) { if (!testjnOverride( "getShort" )) return super.getShort( arg1); return (java.lang.Short) jInterface.Jnido( this, jchildidx + "getShort_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getInt(int arg1) { if (!testjnOverride( "getInt" )) return super.getInt( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getInt_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public long getLong(int arg1) { if (!testjnOverride( "getLong" )) return super.getLong( arg1); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getLong_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public float getFloat(int arg1) { if (!testjnOverride( "getFloat" )) return super.getFloat( arg1); return (java.lang.Float) jInterface.Jnido( this, jchildidx + "getFloat_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public double getDouble(int arg1) { if (!testjnOverride( "getDouble" )) return super.getDouble( arg1); return (java.lang.Double) jInterface.Jnido( this, jchildidx + "getDouble_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getString(int arg1) { if (!testjnOverride( "getString" )) return super.getString( arg1); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getString_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void addRow(java.lang.Object[] arg1) { if (!testjnOverride( "addRow" )) { super.addRow( arg1); return; } jInterface.Jnido( this, jchildidx + "addRow_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void addRow(java.lang.Iterable arg1) { if (!testjnOverride( "addRow" )) { super.addRow( arg1); return; } jInterface.Jnido( this, jchildidx + "addRow_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getCount(){ if (!testjnOverride( "getCount" )) return super.getCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCount_" + jlocale + "_", null ); }
@Override public java.lang.String[] getColumnNames(){ if (!testjnOverride( "getColumnNames" )) return super.getColumnNames(); return (java.lang.String[]) jInterface.Jnidox( this, jchildidx + "getColumnNames_" + jlocale + "_", null ); }
@Override public boolean isNull(int arg1) { if (!testjnOverride( "isNull" )) return super.isNull( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isNull_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
