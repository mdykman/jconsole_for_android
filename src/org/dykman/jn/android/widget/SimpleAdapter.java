package org.dykman.jn.android.widget;
public class SimpleAdapter extends android.widget.SimpleAdapter{
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
public SimpleAdapter(android.content.Context arg1,java.util.List arg2,int arg3,java.lang.String[] arg4,int[] arg5, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3, arg4, arg5); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public int getCount(){ if (!testjnOverride( "getCount" )) return super.getCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCount_" + jlocale + "_", null ); }
@Override public java.lang.Object getItem(int arg1) { if (!testjnOverride( "getItem" )) return super.getItem( arg1); return (java.lang.Object) jInterface.Jnido( this, jchildidx + "getItem_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public long getItemId(int arg1) { if (!testjnOverride( "getItemId" )) return super.getItemId( arg1); return (java.lang.Long) jInterface.Jnido( this, jchildidx + "getItemId_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.view.View getView(int arg1,android.view.View arg2,android.view.ViewGroup arg3) { if (!testjnOverride( "getView" )) return super.getView( arg1, arg2, arg3); return (android.view.View) jInterface.Jnido( this, jchildidx + "getView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setDropDownViewResource(int arg1) { if (!testjnOverride( "setDropDownViewResource" )) { super.setDropDownViewResource( arg1); return; } jInterface.Jnido( this, jchildidx + "setDropDownViewResource_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.view.View getDropDownView(int arg1,android.view.View arg2,android.view.ViewGroup arg3) { if (!testjnOverride( "getDropDownView" )) return super.getDropDownView( arg1, arg2, arg3); return (android.view.View) jInterface.Jnido( this, jchildidx + "getDropDownView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setViewBinder(android.widget.SimpleAdapter.ViewBinder arg1) { if (!testjnOverride( "setViewBinder" )) { super.setViewBinder( arg1); return; } jInterface.Jnido( this, jchildidx + "setViewBinder_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setViewImage(android.widget.ImageView arg1,int arg2) { if (!testjnOverride( "setViewImage" )) { super.setViewImage( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setViewImage_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setViewImage(android.widget.ImageView arg1,java.lang.String arg2) { if (!testjnOverride( "setViewImage" )) { super.setViewImage( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setViewImage_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setViewText(android.widget.TextView arg1,java.lang.String arg2) { if (!testjnOverride( "setViewText" )) { super.setViewText( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setViewText_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.widget.Filter getFilter(){ if (!testjnOverride( "getFilter" )) return super.getFilter(); return (android.widget.Filter) jInterface.Jnido( this, jchildidx + "getFilter_" + jlocale + "_", null ); }
}
