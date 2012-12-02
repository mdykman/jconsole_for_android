package org.dykman.jn.android.app;
public class ListActivity extends android.app.ListActivity{
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
public ListActivity(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override protected void onListItemClick(android.widget.ListView arg1,android.view.View arg2,int arg3,long arg4) { if (!testjnOverride( "onListItemClick" )) { super.onListItemClick( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "onListItemClick_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override protected void onRestoreInstanceState(android.os.Bundle arg1) { if (!testjnOverride( "onRestoreInstanceState" )) { super.onRestoreInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "onRestoreInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onContentChanged(){ if (!testjnOverride( "onContentChanged" )) { super.onContentChanged(); return; } jInterface.Jnido( this, jchildidx + "onContentChanged_" + jlocale + "_", null ); }
@Override public void setListAdapter(android.widget.ListAdapter arg1) { if (!testjnOverride( "setListAdapter" )) { super.setListAdapter( arg1); return; } jInterface.Jnido( this, jchildidx + "setListAdapter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setSelection(int arg1) { if (!testjnOverride( "setSelection" )) { super.setSelection( arg1); return; } jInterface.Jnido( this, jchildidx + "setSelection_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getSelectedItemPosition(){ if (!testjnOverride( "getSelectedItemPosition" )) return super.getSelectedItemPosition(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getSelectedItemPosition_" + jlocale + "_", null ); }
@Override public long getSelectedItemId(){ if (!testjnOverride( "getSelectedItemId" )) return super.getSelectedItemId(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getSelectedItemId_" + jlocale + "_", null ); }
@Override public android.widget.ListView getListView(){ if (!testjnOverride( "getListView" )) return super.getListView(); return (android.widget.ListView) jInterface.Jnido( this, jchildidx + "getListView_" + jlocale + "_", null ); }
@Override public android.widget.ListAdapter getListAdapter(){ if (!testjnOverride( "getListAdapter" )) return super.getListAdapter(); return (android.widget.ListAdapter) jInterface.Jnido( this, jchildidx + "getListAdapter_" + jlocale + "_", null ); }
}
