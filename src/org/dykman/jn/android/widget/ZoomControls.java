package org.dykman.jn.android.widget;
public class ZoomControls extends android.widget.ZoomControls{
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
public ZoomControls(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public ZoomControls(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setOnZoomInClickListener(android.view.View.OnClickListener arg1) { if (!testjnOverride( "setOnZoomInClickListener" )) { super.setOnZoomInClickListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnZoomInClickListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnZoomOutClickListener(android.view.View.OnClickListener arg1) { if (!testjnOverride( "setOnZoomOutClickListener" )) { super.setOnZoomOutClickListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnZoomOutClickListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setZoomSpeed(long arg1) { if (!testjnOverride( "setZoomSpeed" )) { super.setZoomSpeed( arg1); return; } jInterface.Jnido( this, jchildidx + "setZoomSpeed_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onTouchEvent(android.view.MotionEvent arg1) { if (!testjnOverride( "onTouchEvent" )) return super.onTouchEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTouchEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void show(){ if (!testjnOverride( "show" )) { super.show(); return; } jInterface.Jnido( this, jchildidx + "show_" + jlocale + "_", null ); }
@Override public void hide(){ if (!testjnOverride( "hide" )) { super.hide(); return; } jInterface.Jnido( this, jchildidx + "hide_" + jlocale + "_", null ); }
@Override public void setIsZoomInEnabled(boolean arg1) { if (!testjnOverride( "setIsZoomInEnabled" )) { super.setIsZoomInEnabled( arg1); return; } jInterface.Jnido( this, jchildidx + "setIsZoomInEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setIsZoomOutEnabled(boolean arg1) { if (!testjnOverride( "setIsZoomOutEnabled" )) { super.setIsZoomOutEnabled( arg1); return; } jInterface.Jnido( this, jchildidx + "setIsZoomOutEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean hasFocus(){ if (!testjnOverride( "hasFocus" )) return super.hasFocus(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasFocus_" + jlocale + "_", null ); }
}
