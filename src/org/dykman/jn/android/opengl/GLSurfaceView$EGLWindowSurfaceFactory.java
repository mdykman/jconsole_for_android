package org.dykman.jn.android.opengl;
public class GLSurfaceView$EGLWindowSurfaceFactory implements android.opengl.GLSurfaceView.EGLWindowSurfaceFactory{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public GLSurfaceView$EGLWindowSurfaceFactory (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public javax.microedition.khronos.egl.EGLSurface createWindowSurface(javax.microedition.khronos.egl.EGL10 arg1,javax.microedition.khronos.egl.EGLDisplay arg2,javax.microedition.khronos.egl.EGLConfig arg3,java.lang.Object arg4) { return (javax.microedition.khronos.egl.EGLSurface) jInterface.Jnido( this, jchildidx + "createWindowSurface_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3, arg4 } ); }
@Override public void destroySurface(javax.microedition.khronos.egl.EGL10 arg1,javax.microedition.khronos.egl.EGLDisplay arg2,javax.microedition.khronos.egl.EGLSurface arg3) { jInterface.Jnido( this, jchildidx + "destroySurface_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
}
