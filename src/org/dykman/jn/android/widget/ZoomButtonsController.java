package org.dykman.jn.android.widget;
public class ZoomButtonsController extends android.widget.ZoomButtonsController{
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
public ZoomButtonsController(android.view.View arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setZoomInEnabled(boolean arg1) { if (!testjnOverride( "setZoomInEnabled" )) { super.setZoomInEnabled( arg1); return; } jInterface.Jnido( this, jchildidx + "setZoomInEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setZoomOutEnabled(boolean arg1) { if (!testjnOverride( "setZoomOutEnabled" )) { super.setZoomOutEnabled( arg1); return; } jInterface.Jnido( this, jchildidx + "setZoomOutEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setZoomSpeed(long arg1) { if (!testjnOverride( "setZoomSpeed" )) { super.setZoomSpeed( arg1); return; } jInterface.Jnido( this, jchildidx + "setZoomSpeed_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnZoomListener(android.widget.ZoomButtonsController.OnZoomListener arg1) { if (!testjnOverride( "setOnZoomListener" )) { super.setOnZoomListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnZoomListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setFocusable(boolean arg1) { if (!testjnOverride( "setFocusable" )) { super.setFocusable( arg1); return; } jInterface.Jnido( this, jchildidx + "setFocusable_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isAutoDismissed(){ if (!testjnOverride( "isAutoDismissed" )) return super.isAutoDismissed(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isAutoDismissed_" + jlocale + "_", null ); }
@Override public void setAutoDismissed(boolean arg1) { if (!testjnOverride( "setAutoDismissed" )) { super.setAutoDismissed( arg1); return; } jInterface.Jnido( this, jchildidx + "setAutoDismissed_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isVisible(){ if (!testjnOverride( "isVisible" )) return super.isVisible(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isVisible_" + jlocale + "_", null ); }
@Override public void setVisible(boolean arg1) { if (!testjnOverride( "setVisible" )) { super.setVisible( arg1); return; } jInterface.Jnido( this, jchildidx + "setVisible_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.view.ViewGroup getContainer(){ if (!testjnOverride( "getContainer" )) return super.getContainer(); return (android.view.ViewGroup) jInterface.Jnido( this, jchildidx + "getContainer_" + jlocale + "_", null ); }
@Override public android.view.View getZoomControls(){ if (!testjnOverride( "getZoomControls" )) return super.getZoomControls(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getZoomControls_" + jlocale + "_", null ); }
@Override public boolean onTouch(android.view.View arg1,android.view.MotionEvent arg2) { if (!testjnOverride( "onTouch" )) return super.onTouch( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTouch_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
