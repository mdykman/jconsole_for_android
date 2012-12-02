package org.dykman.jn.android.app;
public class TabActivity extends android.app.TabActivity{
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
public TabActivity(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public void setDefaultTab(java.lang.String arg1) { if (!testjnOverride( "setDefaultTab" )) { super.setDefaultTab( arg1); return; } jInterface.Jnido( this, jchildidx + "setDefaultTab_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setDefaultTab(int arg1) { if (!testjnOverride( "setDefaultTab" )) { super.setDefaultTab( arg1); return; } jInterface.Jnido( this, jchildidx + "setDefaultTab_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onRestoreInstanceState(android.os.Bundle arg1) { if (!testjnOverride( "onRestoreInstanceState" )) { super.onRestoreInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "onRestoreInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onPostCreate(android.os.Bundle arg1) { if (!testjnOverride( "onPostCreate" )) { super.onPostCreate( arg1); return; } else super.onPostCreate( arg1); jInterface.Jnido( this, jchildidx + "onPostCreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onSaveInstanceState(android.os.Bundle arg1) { if (!testjnOverride( "onSaveInstanceState" )) { super.onSaveInstanceState( arg1); return; } jInterface.Jnido( this, jchildidx + "onSaveInstanceState_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onContentChanged(){ if (!testjnOverride( "onContentChanged" )) { super.onContentChanged(); return; } jInterface.Jnido( this, jchildidx + "onContentChanged_" + jlocale + "_", null ); }
@Override protected void onChildTitleChanged(android.app.Activity arg1,java.lang.CharSequence arg2) { if (!testjnOverride( "onChildTitleChanged" )) { super.onChildTitleChanged( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onChildTitleChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.widget.TabHost getTabHost(){ if (!testjnOverride( "getTabHost" )) return super.getTabHost(); return (android.widget.TabHost) jInterface.Jnido( this, jchildidx + "getTabHost_" + jlocale + "_", null ); }
@Override public android.widget.TabWidget getTabWidget(){ if (!testjnOverride( "getTabWidget" )) return super.getTabWidget(); return (android.widget.TabWidget) jInterface.Jnido( this, jchildidx + "getTabWidget_" + jlocale + "_", null ); }
}
