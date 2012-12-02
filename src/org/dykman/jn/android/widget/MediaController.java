package org.dykman.jn.android.widget;
public class MediaController extends android.widget.MediaController{
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
public MediaController(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public MediaController(android.content.Context arg1,boolean arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public MediaController(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onFinishInflate(){ if (!testjnOverride( "onFinishInflate" )) { super.onFinishInflate(); return; } jInterface.Jnido( this, jchildidx + "onFinishInflate_" + jlocale + "_", null ); }
@Override public void setMediaPlayer(android.widget.MediaController.MediaPlayerControl arg1) { if (!testjnOverride( "setMediaPlayer" )) { super.setMediaPlayer( arg1); return; } jInterface.Jnido( this, jchildidx + "setMediaPlayer_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setAnchorView(android.view.View arg1) { if (!testjnOverride( "setAnchorView" )) { super.setAnchorView( arg1); return; } jInterface.Jnido( this, jchildidx + "setAnchorView_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void show(){ if (!testjnOverride( "show" )) { super.show(); return; } jInterface.Jnido( this, jchildidx + "show_" + jlocale + "_", null ); }
@Override public void show(int arg1) { if (!testjnOverride( "show" )) { super.show( arg1); return; } jInterface.Jnido( this, jchildidx + "show_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isShowing(){ if (!testjnOverride( "isShowing" )) return super.isShowing(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isShowing_" + jlocale + "_", null ); }
@Override public void hide(){ if (!testjnOverride( "hide" )) { super.hide(); return; } jInterface.Jnido( this, jchildidx + "hide_" + jlocale + "_", null ); }
@Override public boolean onTouchEvent(android.view.MotionEvent arg1) { if (!testjnOverride( "onTouchEvent" )) return super.onTouchEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTouchEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onTrackballEvent(android.view.MotionEvent arg1) { if (!testjnOverride( "onTrackballEvent" )) return super.onTrackballEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTrackballEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean dispatchKeyEvent(android.view.KeyEvent arg1) { if (!testjnOverride( "dispatchKeyEvent" )) return super.dispatchKeyEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "dispatchKeyEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setEnabled(boolean arg1) { if (!testjnOverride( "setEnabled" )) { super.setEnabled( arg1); return; } jInterface.Jnido( this, jchildidx + "setEnabled_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setPrevNextListeners(android.view.View.OnClickListener arg1,android.view.View.OnClickListener arg2) { if (!testjnOverride( "setPrevNextListeners" )) { super.setPrevNextListeners( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setPrevNextListeners_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
