package org.dykman.jn.android.webkit;
public class WebView$PictureListener2 implements android.webkit.WebView.PictureListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public WebView$PictureListener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onNewPicture(android.webkit.WebView arg1,android.graphics.Picture arg2) { jInterface.Jnido( this, "onNewPicture_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
