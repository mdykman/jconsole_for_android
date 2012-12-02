package org.dykman.jn.android.app;
public class ExpandableListActivity extends android.app.ExpandableListActivity{
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
public ExpandableListActivity(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public void onCreateContextMenu(android.view.ContextMenu arg1,android.view.View arg2,android.view.ContextMenu.ContextMenuInfo arg3) { if (!testjnOverride( "onCreateContextMenu" )) { super.onCreateContextMenu( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "onCreateContextMenu_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public boolean onChildClick(android.widget.ExpandableListView arg1,android.view.View arg2,int arg3,int arg4,long arg5) { if (!testjnOverride( "onChildClick" )) return super.onChildClick( arg1, arg2, arg3, arg4, arg5); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onChildClick_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public void onGroupCollapse(int arg1) { if (!testjnOverride( "onGroupCollapse" )) { super.onGroupCollapse( arg1); return; } jInterface.Jnido( this, jchildidx + "onGroupCollapse_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onGroupExpand(int arg1) { if (!testjnOverride( "onGroupExpand" )) { super.onGroupExpand( arg1); return; } jInterface.Jnido( this, jchildidx + "onGroupExpand_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onRestoreInstanceState(android.os.Bundle arg1) { if (!testjnOverride( "onRestoreInstanceState" )) { super.onRestoreInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "onRestoreInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onContentChanged(){ if (!testjnOverride( "onContentChanged" )) { super.onContentChanged(); return; } jInterface.Jnido( this, jchildidx + "onContentChanged_" + jlocale + "_", null ); }
@Override public void setListAdapter(android.widget.ExpandableListAdapter arg1) { if (!testjnOverride( "setListAdapter" )) { super.setListAdapter( arg1); return; } jInterface.Jnido( this, jchildidx + "setListAdapter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.widget.ExpandableListView getExpandableListView(){ if (!testjnOverride( "getExpandableListView" )) return super.getExpandableListView(); return (android.widget.ExpandableListView) jInterface.Jnido( this, jchildidx + "getExpandableListView_" + jlocale + "_", null ); }
@Override public android.widget.ExpandableListAdapter getExpandableListAdapter(){ if (!testjnOverride( "getExpandableListAdapter" )) return super.getExpandableListAdapter(); return (android.widget.ExpandableListAdapter) jInterface.Jnido( this, jchildidx + "getExpandableListAdapter_" + jlocale + "_", null ); }
@Override public long getSelectedId(){ if (!testjnOverride( "getSelectedId" )) return super.getSelectedId(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getSelectedId_" + jlocale + "_", null ); }
@Override public long getSelectedPosition(){ if (!testjnOverride( "getSelectedPosition" )) return super.getSelectedPosition(); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getSelectedPosition_" + jlocale + "_", null ); }
@Override public boolean setSelectedChild(int arg1,int arg2,boolean arg3) { if (!testjnOverride( "setSelectedChild" )) return super.setSelectedChild( arg1, arg2, arg3); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "setSelectedChild_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setSelectedGroup(int arg1) { if (!testjnOverride( "setSelectedGroup" )) { super.setSelectedGroup( arg1); return; } jInterface.Jnido( this, jchildidx + "setSelectedGroup_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
