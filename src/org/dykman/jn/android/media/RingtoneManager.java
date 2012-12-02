package org.dykman.jn.android.media;
public class RingtoneManager extends android.media.RingtoneManager{
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
public RingtoneManager(android.app.Activity arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public RingtoneManager(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setType(int arg1) { if (!testjnOverride( "setType" )) { super.setType( arg1); return; } jInterface.Jnido( this, jchildidx + "setType_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int inferStreamType(){ if (!testjnOverride( "inferStreamType" )) return super.inferStreamType(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "inferStreamType_" + jlocale + "_", null ); }
@Override public void setStopPreviousRingtone(boolean arg1) { if (!testjnOverride( "setStopPreviousRingtone" )) { super.setStopPreviousRingtone( arg1); return; } jInterface.Jnido( this, jchildidx + "setStopPreviousRingtone_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void stopPreviousRingtone(){ if (!testjnOverride( "stopPreviousRingtone" )) { super.stopPreviousRingtone(); return; } jInterface.Jnido( this, jchildidx + "stopPreviousRingtone_" + jlocale + "_", null ); }
@Override public boolean getStopPreviousRingtone(){ if (!testjnOverride( "getStopPreviousRingtone" )) return super.getStopPreviousRingtone(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getStopPreviousRingtone_" + jlocale + "_", null ); }
@Override public boolean getIncludeDrm(){ if (!testjnOverride( "getIncludeDrm" )) return super.getIncludeDrm(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getIncludeDrm_" + jlocale + "_", null ); }
@Override public void setIncludeDrm(boolean arg1) { if (!testjnOverride( "setIncludeDrm" )) { super.setIncludeDrm( arg1); return; } jInterface.Jnido( this, jchildidx + "setIncludeDrm_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.database.Cursor getCursor(){ if (!testjnOverride( "getCursor" )) return super.getCursor(); return (android.database.Cursor) jInterface.Jnido( this, jchildidx + "getCursor_" + jlocale + "_", null ); }
@Override public android.media.Ringtone getRingtone(int arg1) { if (!testjnOverride( "getRingtone" )) return super.getRingtone( arg1); return (android.media.Ringtone) jInterface.Jnido( this, jchildidx + "getRingtone_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.net.Uri getRingtoneUri(int arg1) { if (!testjnOverride( "getRingtoneUri" )) return super.getRingtoneUri( arg1); return (android.net.Uri) jInterface.Jnido( this, jchildidx + "getRingtoneUri_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getRingtonePosition(android.net.Uri arg1) { if (!testjnOverride( "getRingtonePosition" )) return super.getRingtonePosition( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getRingtonePosition_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
