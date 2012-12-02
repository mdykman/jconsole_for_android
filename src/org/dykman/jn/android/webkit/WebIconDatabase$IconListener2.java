package org.dykman.jn.android.webkit;
public class WebIconDatabase$IconListener2 implements android.webkit.WebIconDatabase.IconListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public WebIconDatabase$IconListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onReceivedIcon(java.lang.String arg1,android.graphics.Bitmap arg2) { jInterface.Jnido( this, "onReceivedIcon_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
