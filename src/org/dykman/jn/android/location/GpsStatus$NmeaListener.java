package org.dykman.jn.android.location;
public class GpsStatus$NmeaListener implements android.location.GpsStatus.NmeaListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public GpsStatus$NmeaListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onNmeaReceived(long arg1,java.lang.String arg2) { jInterface.Jnido( this, jchildidx + "onNmeaReceived_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
}
