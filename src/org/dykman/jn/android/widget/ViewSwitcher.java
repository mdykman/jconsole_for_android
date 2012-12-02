package org.dykman.jn.android.widget;
public class ViewSwitcher extends android.widget.ViewSwitcher{
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
public ViewSwitcher(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public ViewSwitcher(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void reset(){ if (!testjnOverride( "reset" )) { super.reset(); return; } jInterface.Jnido( this, jchildidx + "reset_" + jlocale + "_", null ); }
@Override public void addView(android.view.View arg1,int arg2,android.view.ViewGroup.LayoutParams arg3) { if (!testjnOverride( "addView" )) { super.addView( arg1, arg2, arg3); return; } jInterface.Jnido( this, jchildidx + "addView_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public android.view.View getNextView(){ if (!testjnOverride( "getNextView" )) return super.getNextView(); return (android.view.View) jInterface.Jnido( this, jchildidx + "getNextView_" + jlocale + "_", null ); }
@Override public void setFactory(android.widget.ViewSwitcher.ViewFactory arg1) { if (!testjnOverride( "setFactory" )) { super.setFactory( arg1); return; } jInterface.Jnido( this, jchildidx + "setFactory_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
