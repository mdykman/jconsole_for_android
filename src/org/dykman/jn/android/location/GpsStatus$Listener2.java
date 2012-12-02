package org.dykman.jn.android.location;
public class GpsStatus$Listener2 implements android.location.GpsStatus.Listener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public GpsStatus$Listener2 (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onGpsStatusChanged(int arg1) { jInterface.Jnido( this, "onGpsStatusChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
