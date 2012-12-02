package org.dykman.jn.android.media;
public class AudioRecord extends android.media.AudioRecord{
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
public AudioRecord(int arg1,int arg2,int arg3,int arg4,int arg5, java.lang.String jlocale,String jchildid,String joverride ) throws java.lang.IllegalArgumentException{ super( arg1, arg2, arg3, arg4, arg5); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5 } ); }
@Override protected void finalize(){ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public int getState(){ if (!testjnOverride( "getState" )) return super.getState(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getState_" + jlocale + "_", null ); }
@Override public void stop() throws java.lang.IllegalStateException{ if (!testjnOverride( "stop" )) { super.stop(); return; } jInterface.Jnido( this, jchildidx + "stop_" + jlocale + "_", null ); }
@Override public int read(byte[] arg1,int arg2,int arg3) { if (!testjnOverride( "read" )) return super.read( arg1, arg2, arg3); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "read_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public int read(short[] arg1,int arg2,int arg3) { if (!testjnOverride( "read" )) return super.read( arg1, arg2, arg3); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "read_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public int read(java.nio.ByteBuffer arg1,int arg2) { if (!testjnOverride( "read" )) return super.read( arg1, arg2); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "read_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void release(){ if (!testjnOverride( "release" )) { super.release(); return; } jInterface.Jnido( this, jchildidx + "release_" + jlocale + "_", null ); }
@Override public int getSampleRate(){ if (!testjnOverride( "getSampleRate" )) return super.getSampleRate(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getSampleRate_" + jlocale + "_", null ); }
@Override public int getAudioSource(){ if (!testjnOverride( "getAudioSource" )) return super.getAudioSource(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getAudioSource_" + jlocale + "_", null ); }
@Override public int getAudioFormat(){ if (!testjnOverride( "getAudioFormat" )) return super.getAudioFormat(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getAudioFormat_" + jlocale + "_", null ); }
@Override public int getChannelConfiguration(){ if (!testjnOverride( "getChannelConfiguration" )) return super.getChannelConfiguration(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getChannelConfiguration_" + jlocale + "_", null ); }
@Override public int getChannelCount(){ if (!testjnOverride( "getChannelCount" )) return super.getChannelCount(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getChannelCount_" + jlocale + "_", null ); }
@Override public int getRecordingState(){ if (!testjnOverride( "getRecordingState" )) return super.getRecordingState(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getRecordingState_" + jlocale + "_", null ); }
@Override public int getNotificationMarkerPosition(){ if (!testjnOverride( "getNotificationMarkerPosition" )) return super.getNotificationMarkerPosition(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getNotificationMarkerPosition_" + jlocale + "_", null ); }
@Override public int getPositionNotificationPeriod(){ if (!testjnOverride( "getPositionNotificationPeriod" )) return super.getPositionNotificationPeriod(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getPositionNotificationPeriod_" + jlocale + "_", null ); }
@Override public void startRecording() throws java.lang.IllegalStateException{ if (!testjnOverride( "startRecording" )) { super.startRecording(); return; } jInterface.Jnido( this, jchildidx + "startRecording_" + jlocale + "_", null ); }
@Override public void setRecordPositionUpdateListener(android.media.AudioRecord.OnRecordPositionUpdateListener arg1) { if (!testjnOverride( "setRecordPositionUpdateListener" )) { super.setRecordPositionUpdateListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setRecordPositionUpdateListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setRecordPositionUpdateListener(android.media.AudioRecord.OnRecordPositionUpdateListener arg1,android.os.Handler arg2) { if (!testjnOverride( "setRecordPositionUpdateListener" )) { super.setRecordPositionUpdateListener( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setRecordPositionUpdateListener_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int setNotificationMarkerPosition(int arg1) { if (!testjnOverride( "setNotificationMarkerPosition" )) return super.setNotificationMarkerPosition( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "setNotificationMarkerPosition_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int setPositionNotificationPeriod(int arg1) { if (!testjnOverride( "setPositionNotificationPeriod" )) return super.setPositionNotificationPeriod( arg1); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "setPositionNotificationPeriod_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
