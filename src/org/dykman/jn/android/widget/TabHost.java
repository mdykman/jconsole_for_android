package org.dykman.jn.android.widget;
public class TabHost extends android.widget.TabHost{
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
public TabHost(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public TabHost(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setup(){ if (!testjnOverride( "setup" )) { super.setup(); return; } jInterface.Jnido( this, jchildidx + "setup_" + jlocale + "_", null ); }
@Override public void setup(android.app.LocalActivityManager arg1) { if (!testjnOverride( "setup" )) { super.setup( arg1); return; } jInterface.Jnido( this, jchildidx + "setup_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onAttachedToWindow(){ if (!testjnOverride( "onAttachedToWindow" )) { super.onAttachedToWindow(); return; } jInterface.Jnido( this, jchildidx + "onAttachedToWindow_" + jlocale + "_", null ); }
@Override protected void onDetachedFromWindow(){ if (!testjnOverride( "onDetachedFromWindow" )) { super.onDetachedFromWindow(); return; } jInterface.Jnido( this, jchildidx + "onDetachedFromWindow_" + jlocale + "_", null ); }
@Override public void onTouchModeChanged(boolean arg1) { if (!testjnOverride( "onTouchModeChanged" )) { super.onTouchModeChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "onTouchModeChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void addTab(android.widget.TabHost.TabSpec arg1) { if (!testjnOverride( "addTab" )) { super.addTab( arg1); return; } jInterface.Jnido( this, jchildidx + "addTab_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void clearAllTabs(){ if (!testjnOverride( "clearAllTabs" )) { super.clearAllTabs(); return; } jInterface.Jnido( this, jchildidx + "clearAllTabs_" + jlocale + "_", null ); }
@Override public android.widget.TabWidget getTabWidget(){ if (!testjnOverride( "getTabWidget" )) return super.getTabWidget(); return (android.widget.TabWidget) jInterface.Jnido( this, jchildidx + "getTabWidget_" + jlocale + "_", null ); }
@Override public int getCurrentTab(){ if (!testjnOverride( "getCurrentTab" )) return super.getCurrentTab(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCurrentTab_" + jlocale + "_", null ); }
@Override public java.lang.String getCurrentTabTag(){ if (!testjnOverride( "getCurrentTabTag" )) return super.getCurrentTabTag(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getCurrentTabTag_" + jlocale + "_", null ); }
@Override public android.view.View getCurrentTabView(){ if (!testjnOverride( "getCurrentTabView" )) return super.getCurrentTabView(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getCurrentTabView_" + jlocale + "_", null ); }
@Override public android.view.View getCurrentView(){ if (!testjnOverride( "getCurrentView" )) return super.getCurrentView(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getCurrentView_" + jlocale + "_", null ); }
@Override public void setCurrentTabByTag(java.lang.String arg1) { if (!testjnOverride( "setCurrentTabByTag" )) { super.setCurrentTabByTag( arg1); return; } jInterface.Jnido( this, jchildidx + "setCurrentTabByTag_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.widget.FrameLayout getTabContentView(){ if (!testjnOverride( "getTabContentView" )) return super.getTabContentView(); return (android.widget.FrameLayout) jInterface.Jnido( this, jchildidx + "getTabContentView_" + jlocale + "_", null ); }
@Override public boolean dispatchKeyEvent(android.view.KeyEvent arg1) { if (!testjnOverride( "dispatchKeyEvent" )) return super.dispatchKeyEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "dispatchKeyEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void dispatchWindowFocusChanged(boolean arg1) { if (!testjnOverride( "dispatchWindowFocusChanged" )) { super.dispatchWindowFocusChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "dispatchWindowFocusChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setCurrentTab(int arg1) { if (!testjnOverride( "setCurrentTab" )) { super.setCurrentTab( arg1); return; } jInterface.Jnido( this, jchildidx + "setCurrentTab_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnTabChangedListener(android.widget.TabHost.OnTabChangeListener arg1) { if (!testjnOverride( "setOnTabChangedListener" )) { super.setOnTabChangedListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnTabChangedListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
