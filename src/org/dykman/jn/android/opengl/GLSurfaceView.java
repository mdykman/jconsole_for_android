package org.dykman.jn.android.opengl;
public class GLSurfaceView extends android.opengl.GLSurfaceView{
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
public GLSurfaceView(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public GLSurfaceView(android.content.Context arg1,android.util.AttributeSet arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setGLWrapper(android.opengl.GLSurfaceView.GLWrapper arg1) { if (!testjnOverride( "setGLWrapper" )) { super.setGLWrapper( arg1); return; } jInterface.Jnido( this, jchildidx + "setGLWrapper_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setDebugFlags(int arg1) { if (!testjnOverride( "setDebugFlags" )) { super.setDebugFlags( arg1); return; } jInterface.Jnido( this, jchildidx + "setDebugFlags_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getDebugFlags(){ if (!testjnOverride( "getDebugFlags" )) return super.getDebugFlags(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getDebugFlags_" + jlocale + "_", null ); }
@Override public void setRenderer(android.opengl.GLSurfaceView.Renderer arg1) { if (!testjnOverride( "setRenderer" )) { super.setRenderer( arg1); return; } jInterface.Jnido( this, jchildidx + "setRenderer_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setEGLContextFactory(android.opengl.GLSurfaceView.EGLContextFactory arg1) { if (!testjnOverride( "setEGLContextFactory" )) { super.setEGLContextFactory( arg1); return; } jInterface.Jnido( this, jchildidx + "setEGLContextFactory_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setEGLWindowSurfaceFactory(android.opengl.GLSurfaceView.EGLWindowSurfaceFactory arg1) { if (!testjnOverride( "setEGLWindowSurfaceFactory" )) { super.setEGLWindowSurfaceFactory( arg1); return; } jInterface.Jnido( this, jchildidx + "setEGLWindowSurfaceFactory_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setEGLConfigChooser(android.opengl.GLSurfaceView.EGLConfigChooser arg1) { if (!testjnOverride( "setEGLConfigChooser" )) { super.setEGLConfigChooser( arg1); return; } jInterface.Jnido( this, jchildidx + "setEGLConfigChooser_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setEGLConfigChooser(boolean arg1) { if (!testjnOverride( "setEGLConfigChooser" )) { super.setEGLConfigChooser( arg1); return; } jInterface.Jnido( this, jchildidx + "setEGLConfigChooser_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setEGLConfigChooser(int arg1,int arg2,int arg3,int arg4,int arg5,int arg6) { if (!testjnOverride( "setEGLConfigChooser" )) { super.setEGLConfigChooser( arg1, arg2, arg3, arg4, arg5, arg6); return; } jInterface.Jnido( this, jchildidx + "setEGLConfigChooser_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4, arg5, arg6 } ); }
@Override public void setRenderMode(int arg1) { if (!testjnOverride( "setRenderMode" )) { super.setRenderMode( arg1); return; } jInterface.Jnido( this, jchildidx + "setRenderMode_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getRenderMode(){ if (!testjnOverride( "getRenderMode" )) return super.getRenderMode(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getRenderMode_" + jlocale + "_", null ); }
@Override public void requestRender(){ if (!testjnOverride( "requestRender" )) { super.requestRender(); return; } jInterface.Jnido( this, jchildidx + "requestRender_" + jlocale + "_", null ); }
@Override public void surfaceCreated(android.view.SurfaceHolder arg1) { if (!testjnOverride( "surfaceCreated" )) { super.surfaceCreated( arg1); return; } jInterface.Jnido( this, jchildidx + "surfaceCreated_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void surfaceDestroyed(android.view.SurfaceHolder arg1) { if (!testjnOverride( "surfaceDestroyed" )) { super.surfaceDestroyed( arg1); return; } jInterface.Jnido( this, jchildidx + "surfaceDestroyed_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void surfaceChanged(android.view.SurfaceHolder arg1,int arg2,int arg3,int arg4) { if (!testjnOverride( "surfaceChanged" )) { super.surfaceChanged( arg1, arg2, arg3, arg4); return; } jInterface.Jnido( this, jchildidx + "surfaceChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void onPause(){ if (!testjnOverride( "onPause" )) { super.onPause(); return; } jInterface.Jnido( this, jchildidx + "onPause_" + jlocale + "_", null ); }
@Override public void onResume(){ if (!testjnOverride( "onResume" )) { super.onResume(); return; } jInterface.Jnido( this, jchildidx + "onResume_" + jlocale + "_", null ); }
@Override public void queueEvent(java.lang.Runnable arg1) { if (!testjnOverride( "queueEvent" )) { super.queueEvent( arg1); return; } jInterface.Jnido( this, jchildidx + "queueEvent_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override protected void onDetachedFromWindow(){ if (!testjnOverride( "onDetachedFromWindow" )) { super.onDetachedFromWindow(); return; } jInterface.Jnido( this, jchildidx + "onDetachedFromWindow_" + jlocale + "_", null ); }
}
