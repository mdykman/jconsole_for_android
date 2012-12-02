package org.dykman.jn.android.opengl;
public class GLSurfaceView$EGLContextFactory implements android.opengl.GLSurfaceView.EGLContextFactory{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public GLSurfaceView$EGLContextFactory (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public javax.microedition.khronos.egl.EGLContext createContext(javax.microedition.khronos.egl.EGL10 arg1,javax.microedition.khronos.egl.EGLDisplay arg2,javax.microedition.khronos.egl.EGLConfig arg3) { return (javax.microedition.khronos.egl.EGLContext) jInterface.Jnido( this, jchildidx + "createContext_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void destroyContext(javax.microedition.khronos.egl.EGL10 arg1,javax.microedition.khronos.egl.EGLDisplay arg2,javax.microedition.khronos.egl.EGLContext arg3) { jInterface.Jnido( this, jchildidx + "destroyContext_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
}
