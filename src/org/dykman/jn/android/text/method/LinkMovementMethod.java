package org.dykman.jn.android.text.method;
public class LinkMovementMethod extends android.text.method.LinkMovementMethod{
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
public LinkMovementMethod(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public void initialize(android.widget.TextView arg1,android.text.Spannable arg2) { if (!testjnOverride( "initialize" )) { super.initialize( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "initialize_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean onKeyDown(android.widget.TextView arg1,android.text.Spannable arg2,int arg3,android.view.KeyEvent arg4) { if (!testjnOverride( "onKeyDown" )) return super.onKeyDown( arg1, arg2, arg3, arg4); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onKeyDown_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override protected boolean up(android.widget.TextView arg1,android.text.Spannable arg2) { if (!testjnOverride( "up" )) return super.up( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "up_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected boolean down(android.widget.TextView arg1,android.text.Spannable arg2) { if (!testjnOverride( "down" )) return super.down( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "down_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected boolean left(android.widget.TextView arg1,android.text.Spannable arg2) { if (!testjnOverride( "left" )) return super.left( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "left_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected boolean right(android.widget.TextView arg1,android.text.Spannable arg2) { if (!testjnOverride( "right" )) return super.right( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "right_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public boolean onKeyUp(android.widget.TextView arg1,android.text.Spannable arg2,int arg3,android.view.KeyEvent arg4) { if (!testjnOverride( "onKeyUp" )) return super.onKeyUp( arg1, arg2, arg3, arg4); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onKeyUp_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public boolean onTouchEvent(android.widget.TextView arg1,android.text.Spannable arg2,android.view.MotionEvent arg3) { if (!testjnOverride( "onTouchEvent" )) return super.onTouchEvent( arg1, arg2, arg3); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTouchEvent_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void onTakeFocus(android.widget.TextView arg1,android.text.Spannable arg2,int arg3) { if (!testjnOverride( "onTakeFocus" )) { super.onTakeFocus( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "onTakeFocus_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
}
