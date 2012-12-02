package org.dykman.jn.android.widget;
public class QuickContactBadge extends android.widget.QuickContactBadge{
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
public QuickContactBadge(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public QuickContactBadge(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public QuickContactBadge(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void setMode(int arg1) { if (!testjnOverride( "setMode" )) { super.setMode( arg1); return; } jInterface.Jnido( this, jchildidx + "setMode_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void assignContactUri(android.net.Uri arg1) { if (!testjnOverride( "assignContactUri" )) { super.assignContactUri( arg1); return; } jInterface.Jnido( this, jchildidx + "assignContactUri_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void assignContactFromEmail(java.lang.String arg1,boolean arg2) { if (!testjnOverride( "assignContactFromEmail" )) { super.assignContactFromEmail( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "assignContactFromEmail_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void assignContactFromPhone(java.lang.String arg1,boolean arg2) { if (!testjnOverride( "assignContactFromPhone" )) { super.assignContactFromPhone( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "assignContactFromPhone_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onClick(android.view.View arg1) { if (!testjnOverride( "onClick" )) { super.onClick( arg1); return; } jInterface.Jnido( this, jchildidx + "onClick_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setExcludeMimes(java.lang.String[] arg1) { if (!testjnOverride( "setExcludeMimes" )) { super.setExcludeMimes( arg1); return; } jInterface.Jnido( this, jchildidx + "setExcludeMimes_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
