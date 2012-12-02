package org.dykman.jn.android.widget;
public class VideoView extends android.widget.VideoView{
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
public VideoView(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public VideoView(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
public VideoView(android.content.Context arg1,android.util.AttributeSet arg2,int arg3, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2, arg3); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void start(){ if (!testjnOverride( "start" )) { super.start(); return; } jInterface.Jnido( this, jchildidx + "start_" + jlocale + "_", null ); }
@Override protected void onMeasure(int arg1,int arg2) { if (!testjnOverride( "onMeasure" )) { super.onMeasure( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "onMeasure_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public int resolveAdjustedSize(int arg1,int arg2) { if (!testjnOverride( "resolveAdjustedSize" )) return super.resolveAdjustedSize( arg1, arg2); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "resolveAdjustedSize_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setVideoPath(java.lang.String arg1) { if (!testjnOverride( "setVideoPath" )) { super.setVideoPath( arg1); return; } jInterface.Jnido( this, jchildidx + "setVideoPath_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setVideoURI(android.net.Uri arg1) { if (!testjnOverride( "setVideoURI" )) { super.setVideoURI( arg1); return; } jInterface.Jnido( this, jchildidx + "setVideoURI_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void stopPlayback(){ if (!testjnOverride( "stopPlayback" )) { super.stopPlayback(); return; } jInterface.Jnido( this, jchildidx + "stopPlayback_" + jlocale + "_", null ); }
@Override public void setMediaController(android.widget.MediaController arg1) { if (!testjnOverride( "setMediaController" )) { super.setMediaController( arg1); return; } jInterface.Jnido( this, jchildidx + "setMediaController_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnPreparedListener(android.media.MediaPlayer.OnPreparedListener arg1) { if (!testjnOverride( "setOnPreparedListener" )) { super.setOnPreparedListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnPreparedListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnCompletionListener(android.media.MediaPlayer.OnCompletionListener arg1) { if (!testjnOverride( "setOnCompletionListener" )) { super.setOnCompletionListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnCompletionListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setOnErrorListener(android.media.MediaPlayer.OnErrorListener arg1) { if (!testjnOverride( "setOnErrorListener" )) { super.setOnErrorListener( arg1); return; } jInterface.Jnido( this, jchildidx + "setOnErrorListener_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onTouchEvent(android.view.MotionEvent arg1) { if (!testjnOverride( "onTouchEvent" )) return super.onTouchEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTouchEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onTrackballEvent(android.view.MotionEvent arg1) { if (!testjnOverride( "onTrackballEvent" )) return super.onTrackballEvent( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onTrackballEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean onKeyDown(int arg1,android.view.KeyEvent arg2) { if (!testjnOverride( "onKeyDown" )) return super.onKeyDown( arg1, arg2); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "onKeyDown_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void pause(){ if (!testjnOverride( "pause" )) { super.pause(); return; } jInterface.Jnido( this, jchildidx + "pause_" + jlocale + "_", null ); }
@Override public int getDuration(){ if (!testjnOverride( "getDuration" )) return super.getDuration(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDuration_" + jlocale + "_", null ); }
@Override public int getCurrentPosition(){ if (!testjnOverride( "getCurrentPosition" )) return super.getCurrentPosition(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getCurrentPosition_" + jlocale + "_", null ); }
@Override public void seekTo(int arg1) { if (!testjnOverride( "seekTo" )) { super.seekTo( arg1); return; } jInterface.Jnido( this, jchildidx + "seekTo_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isPlaying(){ if (!testjnOverride( "isPlaying" )) return super.isPlaying(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isPlaying_" + jlocale + "_", null ); }
@Override public int getBufferPercentage(){ if (!testjnOverride( "getBufferPercentage" )) return super.getBufferPercentage(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getBufferPercentage_" + jlocale + "_", null ); }
@Override public boolean canPause(){ if (!testjnOverride( "canPause" )) return super.canPause(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "canPause_" + jlocale + "_", null ); }
@Override public boolean canSeekBackward(){ if (!testjnOverride( "canSeekBackward" )) return super.canSeekBackward(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "canSeekBackward_" + jlocale + "_", null ); }
@Override public boolean canSeekForward(){ if (!testjnOverride( "canSeekForward" )) return super.canSeekForward(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "canSeekForward_" + jlocale + "_", null ); }
}
