package org.dykman.jn.android.app;
public class ProgressDialog extends android.app.ProgressDialog{
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
public ProgressDialog(android.content.Context arg1, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
public ProgressDialog(android.content.Context arg1,int arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override protected void onCreate(android.os.Bundle arg1) { if (!testjnOverride( "onCreate" )) { super.onCreate( arg1); return; } jInterface.Jnido( this, jchildidx + "onCreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onStart(){ if (!testjnOverride( "onStart" )) { super.onStart(); return; } jInterface.Jnido( this, jchildidx + "onStart_" + jlocale + "_", null ); }
@Override protected void onStop(){ if (!testjnOverride( "onStop" )) { super.onStop(); return; } jInterface.Jnido( this, jchildidx + "onStop_" + jlocale + "_", null ); }
@Override public void setProgress(int arg1) { if (!testjnOverride( "setProgress" )) { super.setProgress( arg1); return; } jInterface.Jnido( this, jchildidx + "setProgress_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setSecondaryProgress(int arg1) { if (!testjnOverride( "setSecondaryProgress" )) { super.setSecondaryProgress( arg1); return; } jInterface.Jnido( this, jchildidx + "setSecondaryProgress_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getProgress(){ if (!testjnOverride( "getProgress" )) return super.getProgress(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getProgress_" + jlocale + "_", null ); }
@Override public int getSecondaryProgress(){ if (!testjnOverride( "getSecondaryProgress" )) return super.getSecondaryProgress(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getSecondaryProgress_" + jlocale + "_", null ); }
@Override public int getMax(){ if (!testjnOverride( "getMax" )) return super.getMax(); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getMax_" + jlocale + "_", null ); }
@Override public void setMax(int arg1) { if (!testjnOverride( "setMax" )) { super.setMax( arg1); return; } jInterface.Jnido( this, jchildidx + "setMax_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void incrementProgressBy(int arg1) { if (!testjnOverride( "incrementProgressBy" )) { super.incrementProgressBy( arg1); return; } jInterface.Jnido( this, jchildidx + "incrementProgressBy_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void incrementSecondaryProgressBy(int arg1) { if (!testjnOverride( "incrementSecondaryProgressBy" )) { super.incrementSecondaryProgressBy( arg1); return; } jInterface.Jnido( this, jchildidx + "incrementSecondaryProgressBy_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setProgressDrawable(android.graphics.drawable.Drawable arg1) { if (!testjnOverride( "setProgressDrawable" )) { super.setProgressDrawable( arg1); return; } jInterface.Jnido( this, jchildidx + "setProgressDrawable_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setIndeterminateDrawable(android.graphics.drawable.Drawable arg1) { if (!testjnOverride( "setIndeterminateDrawable" )) { super.setIndeterminateDrawable( arg1); return; } jInterface.Jnido( this, jchildidx + "setIndeterminateDrawable_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setIndeterminate(boolean arg1) { if (!testjnOverride( "setIndeterminate" )) { super.setIndeterminate( arg1); return; } jInterface.Jnido( this, jchildidx + "setIndeterminate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public boolean isIndeterminate(){ if (!testjnOverride( "isIndeterminate" )) return super.isIndeterminate(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "isIndeterminate_" + jlocale + "_", null ); }
@Override public void setMessage(java.lang.CharSequence arg1) { if (!testjnOverride( "setMessage" )) { super.setMessage( arg1); return; } jInterface.Jnido( this, jchildidx + "setMessage_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void setProgressStyle(int arg1) { if (!testjnOverride( "setProgressStyle" )) { super.setProgressStyle( arg1); return; } jInterface.Jnido( this, jchildidx + "setProgressStyle_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
