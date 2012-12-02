package org.dykman.jn.android.widget;
public class SimpleCursorAdapter extends android.widget.SimpleCursorAdapter{
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
public SimpleCursorAdapter(android.content.Context arg1,int arg2,android.database.Cursor arg3,java.lang.String[] arg4,int[] arg5, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4, arg5); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public android.view.View newView(android.content.Context arg1,android.database.Cursor arg2,android.view.ViewGroup arg3) { if (!testjnOverride( "newView" )) return super.newView( arg1, arg2, arg3); return (android.view.View) jInterface.Jnido( this, jchildidx + "newView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public android.view.View newDropDownView(android.content.Context arg1,android.database.Cursor arg2,android.view.ViewGroup arg3) { if (!testjnOverride( "newDropDownView" )) return super.newDropDownView( arg1, arg2, arg3); return (android.view.View) jInterface.Jnido( this, jchildidx + "newDropDownView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void bindView(android.view.View arg1,android.content.Context arg2,android.database.Cursor arg3) { if (!testjnOverride( "bindView" )) { super.bindView( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "bindView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setViewBinder(android.widget.SimpleCursorAdapter.ViewBinder arg1) { if (!testjnOverride( "setViewBinder" )) { super.setViewBinder( arg1); return; } jInterface.Jnido( this, jchildidx + "setViewBinder_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setViewImage(android.widget.ImageView arg1,java.lang.String arg2) { if (!testjnOverride( "setViewImage" )) { super.setViewImage( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setViewImage_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setViewText(android.widget.TextView arg1,java.lang.String arg2) { if (!testjnOverride( "setViewText" )) { super.setViewText( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setViewText_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int getStringConversionColumn(){ if (!testjnOverride( "getStringConversionColumn" )) return super.getStringConversionColumn(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getStringConversionColumn_" + jlocale + "_", null ); }
@Override public void setStringConversionColumn(int arg1) { if (!testjnOverride( "setStringConversionColumn" )) { super.setStringConversionColumn( arg1); return; } jInterface.Jnido( this, jchildidx + "setStringConversionColumn_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setCursorToStringConverter(android.widget.SimpleCursorAdapter.CursorToStringConverter arg1) { if (!testjnOverride( "setCursorToStringConverter" )) { super.setCursorToStringConverter( arg1); return; } jInterface.Jnido( this, jchildidx + "setCursorToStringConverter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.CharSequence convertToString(android.database.Cursor arg1) { if (!testjnOverride( "convertToString" )) return super.convertToString( arg1); return (java.lang.CharSequence) jInterface.Jnido( this, jchildidx + "convertToString_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void changeCursor(android.database.Cursor arg1) { if (!testjnOverride( "changeCursor" )) { super.changeCursor( arg1); return; } jInterface.Jnido( this, jchildidx + "changeCursor_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void changeCursorAndColumns(android.database.Cursor arg1,java.lang.String[] arg2,int[] arg3) { if (!testjnOverride( "changeCursorAndColumns" )) { super.changeCursorAndColumns( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "changeCursorAndColumns_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
}
