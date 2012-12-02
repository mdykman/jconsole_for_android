package org.dykman.jn.android.appwidget;
public class AppWidgetHost extends android.appwidget.AppWidgetHost{
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
public AppWidgetHost(android.content.Context arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void startListening(){ if (!testjnOverride( "startListening" )) { super.startListening(); return; } jInterface.Jnido( this, jchildidx + "startListening_" + jlocale + "_", null ); }
@Override public void stopListening(){ if (!testjnOverride( "stopListening" )) { super.stopListening(); return; } jInterface.Jnido( this, jchildidx + "stopListening_" + jlocale + "_", null ); }
@Override public int allocateAppWidgetId(){ if (!testjnOverride( "allocateAppWidgetId" )) return super.allocateAppWidgetId(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "allocateAppWidgetId_" + jlocale + "_", null ); }
@Override public void deleteAppWidgetId(int arg1) { if (!testjnOverride( "deleteAppWidgetId" )) { super.deleteAppWidgetId( arg1); return; } jInterface.Jnido( this, jchildidx + "deleteAppWidgetId_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void deleteHost(){ if (!testjnOverride( "deleteHost" )) { super.deleteHost(); return; } jInterface.Jnido( this, jchildidx + "deleteHost_" + jlocale + "_", null ); }
@Override protected android.appwidget.AppWidgetHostView onCreateView(android.content.Context arg1,int arg2,android.appwidget.AppWidgetProviderInfo arg3) { if (!testjnOverride( "onCreateView" )) return super.onCreateView( arg1, arg2, arg3); return (android.appwidget.AppWidgetHostView) jInterface.Jnido( this, jchildidx + "onCreateView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override protected void onProviderChanged(int arg1,android.appwidget.AppWidgetProviderInfo arg2) { if (!testjnOverride( "onProviderChanged" )) { super.onProviderChanged( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onProviderChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
