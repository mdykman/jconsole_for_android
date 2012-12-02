package org.dykman.jn.android.widget;
public class SeekBar$OnSeekBarChangeListener implements android.widget.SeekBar.OnSeekBarChangeListener{
protected org.dykman.j.JInterface jInterface = null;
protected java.lang.String jlocale = null;
protected java.lang.String jchildid = null;
protected java.lang.String jchildidx = null;
protected void jparseargs (java.lang.String jlocale, java.lang.String jchildid ) { this.jlocale = jlocale; this.jchildid = jchildid; if (jchildid != null && jchildid.length() > 0) jchildidx = jchildid + "_"; else jchildidx = ""; }
public SeekBar$OnSeekBarChangeListener (java.lang.String jlocale,java.lang.String jchildid,java.lang.String dummy ){ jparseargs( jlocale, jchildid ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; }
@Override public void onProgressChanged(android.widget.SeekBar arg1,int arg2,boolean arg3) { jInterface.Jnido( this, jchildidx + "onProgressChanged_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2, arg3 } ); }
@Override public void onStartTrackingTouch(android.widget.SeekBar arg1) { jInterface.Jnido( this, jchildidx + "onStartTrackingTouch_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public void onStopTrackingTouch(android.widget.SeekBar arg1) { jInterface.Jnido( this, jchildidx + "onStopTrackingTouch_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
