package org.dykman.jn.android.view;
public class ContextThemeWrapper extends android.view.ContextThemeWrapper{
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
public ContextThemeWrapper(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
public ContextThemeWrapper(android.content.Context arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void attachBaseContext(android.content.Context arg1) { if (!testjnOverride( "attachBaseContext" )) { super.attachBaseContext( arg1); return; } jInterface.Jnido( this, jchildidx + "attachBaseContext_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setTheme(int arg1) { if (!testjnOverride( "setTheme" )) { super.setTheme( arg1); return; } jInterface.Jnido( this, jchildidx + "setTheme_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.Object getSystemService(java.lang.String arg1) { if (!testjnOverride( "getSystemService" )) return super.getSystemService( arg1); return (java.lang.Object) jInterface.Jnido( this, jchildidx + "getSystemService_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onApplyThemeResource(android.content.res.Resources.Theme arg1,int arg2,boolean arg3) { if (!testjnOverride( "onApplyThemeResource" )) { super.onApplyThemeResource( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "onApplyThemeResource_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
}
