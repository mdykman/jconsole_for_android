package org.dykman.jn.android.telephony;
public class PhoneStateListener extends android.telephony.PhoneStateListener{
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
public PhoneStateListener(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override public void onServiceStateChanged(android.telephony.ServiceState arg1) { if (!testjnOverride( "onServiceStateChanged" )) { super.onServiceStateChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "onServiceStateChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onSignalStrengthChanged(int arg1) { if (!testjnOverride( "onSignalStrengthChanged" )) { super.onSignalStrengthChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "onSignalStrengthChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onMessageWaitingIndicatorChanged(boolean arg1) { if (!testjnOverride( "onMessageWaitingIndicatorChanged" )) { super.onMessageWaitingIndicatorChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "onMessageWaitingIndicatorChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onCallForwardingIndicatorChanged(boolean arg1) { if (!testjnOverride( "onCallForwardingIndicatorChanged" )) { super.onCallForwardingIndicatorChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "onCallForwardingIndicatorChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onCellLocationChanged(android.telephony.CellLocation arg1) { if (!testjnOverride( "onCellLocationChanged" )) { super.onCellLocationChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "onCellLocationChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onCallStateChanged(int arg1,java.lang.String arg2) { if (!testjnOverride( "onCallStateChanged" )) { super.onCallStateChanged( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onCallStateChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onDataConnectionStateChanged(int arg1) { if (!testjnOverride( "onDataConnectionStateChanged" )) { super.onDataConnectionStateChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "onDataConnectionStateChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onDataConnectionStateChanged(int arg1,int arg2) { if (!testjnOverride( "onDataConnectionStateChanged" )) { super.onDataConnectionStateChanged( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onDataConnectionStateChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void onDataActivity(int arg1) { if (!testjnOverride( "onDataActivity" )) { super.onDataActivity( arg1); return; } jInterface.Jnido( this, jchildidx + "onDataActivity_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onSignalStrengthsChanged(android.telephony.SignalStrength arg1) { if (!testjnOverride( "onSignalStrengthsChanged" )) { super.onSignalStrengthsChanged( arg1); return; } jInterface.Jnido( this, jchildidx + "onSignalStrengthsChanged_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
