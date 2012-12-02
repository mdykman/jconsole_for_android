package org.dykman.jn.android.media;
public class ExifInterface extends android.media.ExifInterface{
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
public ExifInterface(java.lang.String arg1, java.lang.String jlocale,String jchildid,String joverride ) throws java.io.IOException{ super( arg1); jnOverrideList = new java.util.ArrayList(); jparseargs( jlocale, jchildid, joverride ); jInterface = org.dykman.j.android.JConsoleApp.theApp.jInterface; if (testjnOverride( "jcreate" )) jInterface.Jnido( this, jchildidx + "jcreate_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public java.lang.String getAttribute(java.lang.String arg1) { if (!testjnOverride( "getAttribute" )) return super.getAttribute( arg1); return (java.lang.String) jInterface.Jnido( this, jchildidx + "getAttribute_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
@Override public int getAttributeInt(java.lang.String arg1,int arg2) { if (!testjnOverride( "getAttributeInt" )) return super.getAttributeInt( arg1, arg2); return (java.lang.Integer) jInterface.Jnido( this, jchildidx + "getAttributeInt_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void setAttribute(java.lang.String arg1,java.lang.String arg2) { if (!testjnOverride( "setAttribute" )) { super.setAttribute( arg1, arg2); return; } jInterface.Jnido( this, jchildidx + "setAttribute_" + jlocale + "_", new java.lang.Object[]{ arg1, arg2 } ); }
@Override public void saveAttributes() throws java.io.IOException{ if (!testjnOverride( "saveAttributes" )) { super.saveAttributes(); return; } jInterface.Jnido( this, jchildidx + "saveAttributes_" + jlocale + "_", null ); }
@Override public boolean hasThumbnail(){ if (!testjnOverride( "hasThumbnail" )) return super.hasThumbnail(); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "hasThumbnail_" + jlocale + "_", null ); }
@Override public byte[] getThumbnail(){ if (!testjnOverride( "getThumbnail" )) return super.getThumbnail(); return (byte[]) jInterface.Jnidoc( this, jchildidx + "getThumbnail_" + jlocale + "_", null ); }
@Override public boolean getLatLong(float[] arg1) { if (!testjnOverride( "getLatLong" )) return super.getLatLong( arg1); return (java.lang.Boolean) jInterface.Jnido( this, jchildidx + "getLatLong_" + jlocale + "_", new java.lang.Object[]{ arg1 } ); }
}
