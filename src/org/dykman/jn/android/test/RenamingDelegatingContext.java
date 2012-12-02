package org.dykman.jn.android.test;
public class RenamingDelegatingContext extends android.test.RenamingDelegatingContext{
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
public RenamingDelegatingContext(android.content.Context arg1,java.lang.String arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public RenamingDelegatingContext(android.content.Context arg1,android.content.Context arg2,java.lang.String arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void makeExistingFilesAndDbsAccessible(){ if (!testjnOverride( "makeExistingFilesAndDbsAccessible" )) { super.makeExistingFilesAndDbsAccessible(); return; } jInterface.Jnido( this, jchildidx + "makeExistingFilesAndDbsAccessible_" + jlocale + "_", null ); }
@Override public java.lang.String getDatabasePrefix(){ if (!testjnOverride( "getDatabasePrefix" )) return super.getDatabasePrefix(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getDatabasePrefix_" + jlocale + "_", null ); }
@Override public android.database.sqlite.SQLiteDatabase openOrCreateDatabase(java.lang.String arg1,int arg2,android.database.sqlite.SQLiteDatabase.CursorFactory arg3) { if (!testjnOverride( "openOrCreateDatabase" )) return super.openOrCreateDatabase( arg1, arg2, arg3); return (android.database.sqlite.SQLiteDatabase) jInterface.Jnido( this, jchildidx + "openOrCreateDatabase_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public boolean deleteDatabase(java.lang.String arg1) { if (!testjnOverride( "deleteDatabase" )) return super.deleteDatabase( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "deleteDatabase_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.io.File getDatabasePath(java.lang.String arg1) { if (!testjnOverride( "getDatabasePath" )) return super.getDatabasePath( arg1); return (java.io.File) jInterface.Jnido( this, jchildidx + "getDatabasePath_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String[] databaseList(){ if (!testjnOverride( "databaseList" )) return super.databaseList(); return (java.lang.String[]) jInterface.Jnidox( this, jchildidx + "databaseList_" + jlocale + "_", null ); }
@Override public java.io.FileInputStream openFileInput(java.lang.String arg1) throws java.io.FileNotFoundException { if (!testjnOverride( "openFileInput" )) return super.openFileInput( arg1); return (java.io.FileInputStream) jInterface.Jnido( this, jchildidx + "openFileInput_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.io.FileOutputStream openFileOutput(java.lang.String arg1,int arg2) throws java.io.FileNotFoundException { if (!testjnOverride( "openFileOutput" )) return super.openFileOutput( arg1, arg2); return (java.io.FileOutputStream) jInterface.Jnido( this, jchildidx + "openFileOutput_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public java.io.File getFileStreamPath(java.lang.String arg1) { if (!testjnOverride( "getFileStreamPath" )) return super.getFileStreamPath( arg1); return (java.io.File) jInterface.Jnido( this, jchildidx + "getFileStreamPath_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean deleteFile(java.lang.String arg1) { if (!testjnOverride( "deleteFile" )) return super.deleteFile( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "deleteFile_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String[] fileList(){ if (!testjnOverride( "fileList" )) return super.fileList(); return (java.lang.String[]) jInterface.Jnidox( this, jchildidx + "fileList_" + jlocale + "_", null ); }
@Override public java.io.File getCacheDir(){ if (!testjnOverride( "getCacheDir" )) return super.getCacheDir(); return (java.io.File) jInterface.Jnido( this, jchildidx + "getCacheDir_" + jlocale + "_", null ); }
}
