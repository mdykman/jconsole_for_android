package org.dykman.jn.android.app;
public class LocalActivityManager extends android.app.LocalActivityManager{
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
public LocalActivityManager(android.app.Activity arg1,boolean arg2, java.lang.String jlocale,String jchildid,String joverride ) { super( arg1, arg2); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.view.Window startActivity(java.lang.String arg1,android.content.Intent arg2) { if (!testjnOverride( "startActivity" )) return super.startActivity( arg1, arg2); return (android.view.Window) jInterface.Jnido( this, jchildidx + "startActivity_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.view.Window destroyActivity(java.lang.String arg1,boolean arg2) { if (!testjnOverride( "destroyActivity" )) return super.destroyActivity( arg1, arg2); return (android.view.Window) jInterface.Jnido( this, jchildidx + "destroyActivity_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public android.app.Activity getCurrentActivity(){ if (!testjnOverride( "getCurrentActivity" )) return super.getCurrentActivity(); return (android.app.Activity) jInterface.Jnido( this, jchildidx + "getCurrentActivity_" + jlocale + "_", null ); }
@Override public java.lang.String getCurrentId(){ if (!testjnOverride( "getCurrentId" )) return super.getCurrentId(); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getCurrentId_" + jlocale + "_", null ); }
@Override public android.app.Activity getActivity(java.lang.String arg1) { if (!testjnOverride( "getActivity" )) return super.getActivity( arg1); return (android.app.Activity) jInterface.Jnido( this, jchildidx + "getActivity_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void dispatchCreate(android.os.Bundle arg1) { if (!testjnOverride( "dispatchCreate" )) { super.dispatchCreate( arg1); return; } jInterface.Jnido( this, jchildidx + "dispatchCreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public android.os.Bundle saveInstanceState(){ if (!testjnOverride( "saveInstanceState" )) return super.saveInstanceState(); return (android.os.Bundle) jInterface.Jnido( this, jchildidx + "saveInstanceState_" + jlocale + "_", null ); }
@Override public void dispatchResume(){ if (!testjnOverride( "dispatchResume" )) { super.dispatchResume(); return; } jInterface.Jnido( this, jchildidx + "dispatchResume_" + jlocale + "_", null ); }
@Override public void dispatchPause(boolean arg1) { if (!testjnOverride( "dispatchPause" )) { super.dispatchPause( arg1); return; } jInterface.Jnido( this, jchildidx + "dispatchPause_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void dispatchStop(){ if (!testjnOverride( "dispatchStop" )) { super.dispatchStop(); return; } jInterface.Jnido( this, jchildidx + "dispatchStop_" + jlocale + "_", null ); }
@Override public void removeAllActivities(){ if (!testjnOverride( "removeAllActivities" )) { super.removeAllActivities(); return; } jInterface.Jnido( this, jchildidx + "removeAllActivities_" + jlocale + "_", null ); }
@Override public void dispatchDestroy(boolean arg1) { if (!testjnOverride( "dispatchDestroy" )) { super.dispatchDestroy( arg1); return; } jInterface.Jnido( this, jchildidx + "dispatchDestroy_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
