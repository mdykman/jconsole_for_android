package org.dykman.jn.android.widget;
public class SlidingDrawer extends android.widget.SlidingDrawer{
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
public SlidingDrawer(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public SlidingDrawer(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void lock(){ if (!testjnOverride( "lock" )) { super.lock(); return; } jInterface.Jnido( this, jchildidx + "lock_" + jlocale + "_", null ); }
@Override public void close(){ if (!testjnOverride( "close" )) { super.close(); return; } jInterface.Jnido( this, jchildidx + "close_" + jlocale + "_", null ); }
@Override public void open(){ if (!testjnOverride( "open" )) { super.open(); return; } jInterface.Jnido( this, jchildidx + "open_" + jlocale + "_", null ); }
@Override public android.view.View getHandle(){ if (!testjnOverride( "getHandle" )) return super.getHandle(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getHandle_" + jlocale + "_", null ); }
@Override public android.view.View getContent(){ if (!testjnOverride( "getContent" )) return super.getContent(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getContent_" + jlocale + "_", null ); }
@Override public void unlock(){ if (!testjnOverride( "unlock" )) { super.unlock(); return; } jInterface.Jnido( this, jchildidx + "unlock_" + jlocale + "_", null ); }
@Override protected void onFinishInflate(){ if (!testjnOverride( "onFinishInflate" )) { super.onFinishInflate(); return; } jInterface.Jnido( this, jchildidx + "onFinishInflate_" + jlocale + "_", null ); }
@Override protected void onMeasure(int arg1,int arg2) { if (!testjnOverride( "onMeasure" )) { super.onMeasure( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onMeasure_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void dispatchDraw(android.graphics.Canvas arg1) { if (!testjnOverride( "dispatchDraw" )) { super.dispatchDraw( arg1); return; } jInterface.Jnido( this, jchildidx + "dispatchDraw_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onLayout(boolean arg1,int arg2,int arg3,int arg4,int arg5) { if (!testjnOverride( "onLayout" )) { super.onLayout( arg1, arg2, arg3, arg4, arg5); return; } jInterface.Jnido( this, jchildidx + "onLayout_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override public boolean onInterceptTouchEvent(android.view.MotionEvent arg1) { if (!testjnOverride( "onInterceptTouchEvent" )) return super.onInterceptTouchEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onInterceptTouchEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onTouchEvent(android.view.MotionEvent arg1) { if (!testjnOverride( "onTouchEvent" )) return super.onTouchEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTouchEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void toggle(){ if (!testjnOverride( "toggle" )) { super.toggle(); return; } jInterface.Jnido( this, jchildidx + "toggle_" + jlocale + "_", null ); }
@Override public void animateToggle(){ if (!testjnOverride( "animateToggle" )) { super.animateToggle(); return; } jInterface.Jnido( this, jchildidx + "animateToggle_" + jlocale + "_", null ); }
@Override public void animateClose(){ if (!testjnOverride( "animateClose" )) { super.animateClose(); return; } jInterface.Jnido( this, jchildidx + "animateClose_" + jlocale + "_", null ); }
@Override public void animateOpen(){ if (!testjnOverride( "animateOpen" )) { super.animateOpen(); return; } jInterface.Jnido( this, jchildidx + "animateOpen_" + jlocale + "_", null ); }
@Override public void setOnDrawerOpenListener(android.widget.SlidingDrawer.OnDrawerOpenListener arg1) { if (!testjnOverride( "setOnDrawerOpenListener" )) { super.setOnDrawerOpenListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnDrawerOpenListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnDrawerCloseListener(android.widget.SlidingDrawer.OnDrawerCloseListener arg1) { if (!testjnOverride( "setOnDrawerCloseListener" )) { super.setOnDrawerCloseListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnDrawerCloseListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnDrawerScrollListener(android.widget.SlidingDrawer.OnDrawerScrollListener arg1) { if (!testjnOverride( "setOnDrawerScrollListener" )) { super.setOnDrawerScrollListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnDrawerScrollListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isOpened(){ if (!testjnOverride( "isOpened" )) return super.isOpened(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isOpened_" + jlocale + "_", null ); }
@Override public boolean isMoving(){ if (!testjnOverride( "isMoving" )) return super.isMoving(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isMoving_" + jlocale + "_", null ); }
}
