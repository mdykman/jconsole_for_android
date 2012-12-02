package org.dykman.jn.android.text.style;
public class IconMarginSpan extends android.text.style.IconMarginSpan{
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
public IconMarginSpan(android.graphics.Bitmap arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public IconMarginSpan(android.graphics.Bitmap arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int getLeadingMargin(boolean arg1) { if (!testjnOverride( "getLeadingMargin" )) return super.getLeadingMargin( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getLeadingMargin_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void drawLeadingMargin(android.graphics.Canvas arg1,android.graphics.Paint arg2,int arg3,int arg4,int arg5,int arg6,int arg7,java.lang.CharSequence arg8,int arg9,int arg10,boolean arg11,android.text.Layout arg12) { if (!testjnOverride( "drawLeadingMargin" )) { super.drawLeadingMargin( arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12); return; } jInterface.Jnido( this, jchildidx + "drawLeadingMargin_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12 } ); }
@Override public void chooseHeight(java.lang.CharSequence arg1,int arg2,int arg3,int arg4,int arg5,android.graphics.Paint.FontMetricsInt arg6) { if (!testjnOverride( "chooseHeight" )) { super.chooseHeight( arg1, arg2, arg3, arg4, arg5, arg6); return; } jInterface.Jnido( this, jchildidx + "chooseHeight_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
}
