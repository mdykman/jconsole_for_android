package org.dykman.jn.android.media;
public class MediaRecorder extends android.media.MediaRecorder{
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
public MediaRecorder(String jlocale,String jchildid,String joverride ){ super(); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", null ); }
@Override protected void finalize(){ if (!testjnOverride( "finalize" )) { super.finalize(); return; } jInterface.Jnido( this, jchildidx + "finalize_" + jlocale + "_", null ); }
@Override public void start() throws java.lang.IllegalStateException{ if (!testjnOverride( "start" )) { super.start(); return; } jInterface.Jnido( this, jchildidx + "start_" + jlocale + "_", null ); }
@Override public void stop() throws java.lang.IllegalStateException{ if (!testjnOverride( "stop" )) { super.stop(); return; } jInterface.Jnido( this, jchildidx + "stop_" + jlocale + "_", null ); }
@Override public void reset(){ if (!testjnOverride( "reset" )) { super.reset(); return; } jInterface.Jnido( this, jchildidx + "reset_" + jlocale + "_", null ); }
@Override public void release(){ if (!testjnOverride( "release" )) { super.release(); return; } jInterface.Jnido( this, jchildidx + "release_" + jlocale + "_", null ); }
@Override public void setCamera(android.hardware.Camera arg1) { if (!testjnOverride( "setCamera" )) { super.setCamera( arg1); return; } jInterface.Jnido( this, jchildidx + "setCamera_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setPreviewDisplay(android.view.Surface arg1) { if (!testjnOverride( "setPreviewDisplay" )) { super.setPreviewDisplay( arg1); return; } jInterface.Jnido( this, jchildidx + "setPreviewDisplay_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setAudioSource(int arg1) throws java.lang.IllegalStateException { if (!testjnOverride( "setAudioSource" )) { super.setAudioSource( arg1); return; } jInterface.Jnido( this, jchildidx + "setAudioSource_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setVideoSource(int arg1) throws java.lang.IllegalStateException { if (!testjnOverride( "setVideoSource" )) { super.setVideoSource( arg1); return; } jInterface.Jnido( this, jchildidx + "setVideoSource_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOutputFormat(int arg1) throws java.lang.IllegalStateException { if (!testjnOverride( "setOutputFormat" )) { super.setOutputFormat( arg1); return; } jInterface.Jnido( this, jchildidx + "setOutputFormat_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setVideoSize(int arg1,int arg2) throws java.lang.IllegalStateException { if (!testjnOverride( "setVideoSize" )) { super.setVideoSize( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setVideoSize_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setVideoFrameRate(int arg1) throws java.lang.IllegalStateException { if (!testjnOverride( "setVideoFrameRate" )) { super.setVideoFrameRate( arg1); return; } jInterface.Jnido( this, jchildidx + "setVideoFrameRate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setMaxDuration(int arg1) throws java.lang.IllegalArgumentException { if (!testjnOverride( "setMaxDuration" )) { super.setMaxDuration( arg1); return; } jInterface.Jnido( this, jchildidx + "setMaxDuration_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setMaxFileSize(long arg1) throws java.lang.IllegalArgumentException { if (!testjnOverride( "setMaxFileSize" )) { super.setMaxFileSize( arg1); return; } jInterface.Jnido( this, jchildidx + "setMaxFileSize_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setAudioEncoder(int arg1) throws java.lang.IllegalStateException { if (!testjnOverride( "setAudioEncoder" )) { super.setAudioEncoder( arg1); return; } jInterface.Jnido( this, jchildidx + "setAudioEncoder_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setVideoEncoder(int arg1) throws java.lang.IllegalStateException { if (!testjnOverride( "setVideoEncoder" )) { super.setVideoEncoder( arg1); return; } jInterface.Jnido( this, jchildidx + "setVideoEncoder_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOutputFile(java.io.FileDescriptor arg1) throws java.lang.IllegalStateException { if (!testjnOverride( "setOutputFile" )) { super.setOutputFile( arg1); return; } jInterface.Jnido( this, jchildidx + "setOutputFile_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOutputFile(java.lang.String arg1) throws java.lang.IllegalStateException { if (!testjnOverride( "setOutputFile" )) { super.setOutputFile( arg1); return; } jInterface.Jnido( this, jchildidx + "setOutputFile_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void prepare() throws java.lang.IllegalStateException,java.io.IOException{ if (!testjnOverride( "prepare" )) { super.prepare(); return; } jInterface.Jnido( this, jchildidx + "prepare_" + jlocale + "_", null ); }
@Override public int getMaxAmplitude() throws java.lang.IllegalStateException{ if (!testjnOverride( "getMaxAmplitude" )) return super.getMaxAmplitude(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getMaxAmplitude_" + jlocale + "_", null ); }
@Override public void setOnErrorListener(android.media.MediaRecorder.OnErrorListener arg1) { if (!testjnOverride( "setOnErrorListener" )) { super.setOnErrorListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnErrorListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnInfoListener(android.media.MediaRecorder.OnInfoListener arg1) { if (!testjnOverride( "setOnInfoListener" )) { super.setOnInfoListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnInfoListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
