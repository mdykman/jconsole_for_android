package org.dykman.jn.android.widget;
public class ArrayAdapter extends android.widget.ArrayAdapter{
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
public ArrayAdapter(android.content.Context arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public ArrayAdapter(android.content.Context arg1,int arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
public ArrayAdapter(android.content.Context arg1,int arg2,java.lang.Object[] arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
public ArrayAdapter(android.content.Context arg1,int arg2,int arg3,java.lang.Object[] arg4, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
public ArrayAdapter(android.content.Context arg1,int arg2,java.util.List arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
public ArrayAdapter(android.content.Context arg1,int arg2,int arg3,java.util.List arg4, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void add(java.lang.Object arg1) { if (!testjnOverride( "add" )) { super.add( arg1); return; } jInterface.Jnido( this, jchildidx + "add_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void clear(){ if (!testjnOverride( "clear" )) { super.clear(); return; } jInterface.Jnido( this, jchildidx + "clear_" + jlocale + "_", null ); }
@Override public void remove(java.lang.Object arg1) { if (!testjnOverride( "remove" )) { super.remove( arg1); return; } jInterface.Jnido( this, jchildidx + "remove_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.content.Context getContext(){ if (!testjnOverride( "getContext" )) return super.getContext(); return (android.content.Context) jInterface.Jnido( this, jchildidx + "getContext_" + jlocale + "_", null ); }
@Override public void insert(java.lang.Object arg1,int arg2) { if (!testjnOverride( "insert" )) { super.insert( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "insert_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void sort(java.util.Comparator arg1) { if (!testjnOverride( "sort" )) { super.sort( arg1); return; } jInterface.Jnido( this, jchildidx + "sort_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void notifyDataSetChanged(){ if (!testjnOverride( "notifyDataSetChanged" )) { super.notifyDataSetChanged(); return; } jInterface.Jnido( this, jchildidx + "notifyDataSetChanged_" + jlocale + "_", null ); }
@Override public void setNotifyOnChange(boolean arg1) { if (!testjnOverride( "setNotifyOnChange" )) { super.setNotifyOnChange( arg1); return; } jInterface.Jnido( this, jchildidx + "setNotifyOnChange_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getCount(){ if (!testjnOverride( "getCount" )) return super.getCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCount_" + jlocale + "_", null ); }
@Override public java.lang.Object getItem(int arg1) { if (!testjnOverride( "getItem" )) return super.getItem( arg1); return (java.lang.Object) jInterface.Jnido( this, jchildidx + "getItem_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getPosition(java.lang.Object arg1) { if (!testjnOverride( "getPosition" )) return super.getPosition( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getPosition_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public long getItemId(int arg1) { if (!testjnOverride( "getItemId" )) return super.getItemId( arg1); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getItemId_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.view.View getView(int arg1,android.view.View arg2,android.view.ViewGroup arg3) { if (!testjnOverride( "getView" )) return super.getView( arg1, arg2, arg3); return (android.view.View) jInterface.Jnido( this, jchildidx + "getView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setDropDownViewResource(int arg1) { if (!testjnOverride( "setDropDownViewResource" )) { super.setDropDownViewResource( arg1); return; } jInterface.Jnido( this, jchildidx + "setDropDownViewResource_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.view.View getDropDownView(int arg1,android.view.View arg2,android.view.ViewGroup arg3) { if (!testjnOverride( "getDropDownView" )) return super.getDropDownView( arg1, arg2, arg3); return (android.view.View) jInterface.Jnido( this, jchildidx + "getDropDownView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public android.widget.Filter getFilter(){ if (!testjnOverride( "getFilter" )) return super.getFilter(); return (android.widget.Filter) jInterface.Jnido( this, jchildidx + "getFilter_" + jlocale + "_", null ); }
}
