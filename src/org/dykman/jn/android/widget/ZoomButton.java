package org.dykman.jn.android.widget;
public class ZoomButton extends android.widget.ZoomButton{
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
public ZoomButton(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public ZoomButton(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public ZoomButton(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public boolean onTouchEvent(android.view.MotionEvent arg1) { if (!testjnOverride( "onTouchEvent" )) return super.onTouchEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTouchEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setZoomSpeed(long arg1) { if (!testjnOverride( "setZoomSpeed" )) { super.setZoomSpeed( arg1); return; } jInterface.Jnido( this, jchildidx + "setZoomSpeed_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onLongClick(android.view.View arg1) { if (!testjnOverride( "onLongClick" )) return super.onLongClick( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onLongClick_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onKeyUp(int arg1,android.view.KeyEvent arg2) { if (!testjnOverride( "onKeyUp" )) return super.onKeyUp( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onKeyUp_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setEnabled(boolean arg1) { if (!testjnOverride( "setEnabled" )) { super.setEnabled( arg1); return; } jInterface.Jnido( this, jchildidx + "setEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean dispatchUnhandledMove(android.view.View arg1,int arg2) { if (!testjnOverride( "dispatchUnhandledMove" )) return super.dispatchUnhandledMove( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "dispatchUnhandledMove_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
