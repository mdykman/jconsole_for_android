package org.dykman.jn.android.widget;
public class HeaderViewListAdapter extends android.widget.HeaderViewListAdapter{
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
public HeaderViewListAdapter(java.util.ArrayList arg1,java.util.ArrayList arg2,android.widget.ListAdapter arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public boolean isEmpty(){ if (!testjnOverride( "isEmpty" )) return super.isEmpty(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isEmpty_" + jlocale + "_", null ); }
@Override public int getHeadersCount(){ if (!testjnOverride( "getHeadersCount" )) return super.getHeadersCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getHeadersCount_" + jlocale + "_", null ); }
@Override public int getFootersCount(){ if (!testjnOverride( "getFootersCount" )) return super.getFootersCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getFootersCount_" + jlocale + "_", null ); }
@Override public boolean removeHeader(android.view.View arg1) { if (!testjnOverride( "removeHeader" )) return super.removeHeader( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "removeHeader_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean removeFooter(android.view.View arg1) { if (!testjnOverride( "removeFooter" )) return super.removeFooter( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "removeFooter_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getCount(){ if (!testjnOverride( "getCount" )) return super.getCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCount_" + jlocale + "_", null ); }
@Override public boolean areAllItemsEnabled(){ if (!testjnOverride( "areAllItemsEnabled" )) return super.areAllItemsEnabled(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "areAllItemsEnabled_" + jlocale + "_", null ); }
@Override public boolean isEnabled(int arg1) { if (!testjnOverride( "isEnabled" )) return super.isEnabled( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.Object getItem(int arg1) { if (!testjnOverride( "getItem" )) return super.getItem( arg1); return (java.lang.Object) jInterface.Jnido( this, jchildidx + "getItem_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public long getItemId(int arg1) { if (!testjnOverride( "getItemId" )) return super.getItemId( arg1); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getItemId_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean hasStableIds(){ if (!testjnOverride( "hasStableIds" )) return super.hasStableIds(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasStableIds_" + jlocale + "_", null ); }
@Override public android.view.View getView(int arg1,android.view.View arg2,android.view.ViewGroup arg3) { if (!testjnOverride( "getView" )) return super.getView( arg1, arg2, arg3); return (android.view.View) jInterface.Jnido( this, jchildidx + "getView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public int getItemViewType(int arg1) { if (!testjnOverride( "getItemViewType" )) return super.getItemViewType( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getItemViewType_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getViewTypeCount(){ if (!testjnOverride( "getViewTypeCount" )) return super.getViewTypeCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getViewTypeCount_" + jlocale + "_", null ); }
@Override public void registerDataSetObserver(android.database.DataSetObserver arg1) { if (!testjnOverride( "registerDataSetObserver" )) { super.registerDataSetObserver( arg1); return; } jInterface.Jnido( this, jchildidx + "registerDataSetObserver_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void unregisterDataSetObserver(android.database.DataSetObserver arg1) { if (!testjnOverride( "unregisterDataSetObserver" )) { super.unregisterDataSetObserver( arg1); return; } jInterface.Jnido( this, jchildidx + "unregisterDataSetObserver_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.widget.Filter getFilter(){ if (!testjnOverride( "getFilter" )) return super.getFilter(); return (android.widget.Filter) jInterface.Jnido( this, jchildidx + "getFilter_" + jlocale + "_", null ); }
@Override public android.widget.ListAdapter getWrappedAdapter(){ if (!testjnOverride( "getWrappedAdapter" )) return super.getWrappedAdapter(); return (android.widget.ListAdapter) jInterface.Jnido( this, jchildidx + "getWrappedAdapter_" + jlocale + "_", null ); }
}
