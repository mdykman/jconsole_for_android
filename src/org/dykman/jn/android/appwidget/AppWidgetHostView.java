package org.dykman.jn.android.appwidget;
public class AppWidgetHostView extends android.appwidget.AppWidgetHostView{
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
public AppWidgetHostView(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public AppWidgetHostView(android.content.Context arg1,int arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setAppWidget(int arg1,android.appwidget.AppWidgetProviderInfo arg2) { if (!testjnOverride( "setAppWidget" )) { super.setAppWidget( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setAppWidget_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int getAppWidgetId(){ if (!testjnOverride( "getAppWidgetId" )) return super.getAppWidgetId(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getAppWidgetId_" + jlocale + "_", null ); }
@Override public android.appwidget.AppWidgetProviderInfo getAppWidgetInfo(){ if (!testjnOverride( "getAppWidgetInfo" )) return super.getAppWidgetInfo(); return (android.appwidget.AppWidgetProviderInfo) jInterface.Jnido( this, jchildidx + "getAppWidgetInfo_" + jlocale + "_", null ); }
@Override protected void dispatchSaveInstanceState(android.util.SparseArray arg1) { if (!testjnOverride( "dispatchSaveInstanceState" )) { super.dispatchSaveInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "dispatchSaveInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void dispatchRestoreInstanceState(android.util.SparseArray arg1) { if (!testjnOverride( "dispatchRestoreInstanceState" )) { super.dispatchRestoreInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "dispatchRestoreInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void updateAppWidget(android.widget.RemoteViews arg1) { if (!testjnOverride( "updateAppWidget" )) { super.updateAppWidget( arg1); return; } jInterface.Jnido( this, jchildidx + "updateAppWidget_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected boolean drawChild(android.graphics.Canvas arg1,android.view.View arg2,long arg3) { if (!testjnOverride( "drawChild" )) return super.drawChild( arg1, arg2, arg3); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "drawChild_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override protected void prepareView(android.view.View arg1) { if (!testjnOverride( "prepareView" )) { super.prepareView( arg1); return; } jInterface.Jnido( this, jchildidx + "prepareView_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected android.view.View getDefaultView(){ if (!testjnOverride( "getDefaultView" )) return super.getDefaultView(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getDefaultView_" + jlocale + "_", null ); }
@Override protected android.view.View getErrorView(){ if (!testjnOverride( "getErrorView" )) return super.getErrorView(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getErrorView_" + jlocale + "_", null ); }
}
