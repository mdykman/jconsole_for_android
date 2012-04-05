package org.dykman.j;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipInputStream;


import android.util.Log;

public class JInterface {

	/// output format constants from jlib.h
	public static final int MTYOFM	 =	1;	/* formatted result array output */
	public static final int MTYOER	 =	2;	/* error output */
	public static final int MTYOLOG	 =	3;	/* output log */
	public static final int MTYOSYS	 =	4;	/* system assertion failure */
	public static final int MTYOEXIT =	5;	/* exit */
	public static final int MTYOFILE =	6;	/* output 1!:2[2 */
	
	public static final String LOGTAG = "j-interface";

	private long nativeInstance = 0L;

	private List<ExecutionListener> execlist = new ArrayList<ExecutionListener>();
	private List<OutputListener> outputs = new ArrayList<OutputListener>();

    public int callJ(String []s) {
    	int result = -1;
    	try {
    		if(nativeInstance == 0L) {
	    		synchronized(this) {
			    	if(nativeInstance == 0L) {
			    		nativeInstance = initializeJ();
			    	}
	    		}
    		}
    		for(String sentence : s) {
    			result = -1;
        		Log.i(LOGTAG, "executing: " + sentence);
    			result = callJNative(nativeInstance,sentence);
    		}
    	} catch(Throwable e) {
    		Log.e(LOGTAG, "error executing sentence: " + s, e);
    	} finally { 
	    	for(ExecutionListener l : execlist) {
	    		l.onCommandComplete(result);
	    	}
    	}
    	return result;
    }

    
    protected synchronized long initializeJ() {
    	return initializeJNative();
    }
    
    public synchronized void destroyJ() {
    	if(nativeInstance != 0L) {
    		destroyJNative(nativeInstance);
    		nativeInstance = 0L;
    	}
    }
	public Object getVariable(String ident) {
		return getVariableNative(nativeInstance, ident);
	}

	public void reset() {
    	if(nativeInstance != 0L) {
    		synchronized(this) {
	        	if(nativeInstance != 0L) {
		    		nativeInstance = 0L;
		    		destroyJ();
	        	}
	        	nativeInstance = initializeJ();
    		}
    	}
	}

    public void addExecutionListener(ExecutionListener listener) {
		if(!execlist.contains(listener)) {
			execlist.add(listener);
		}
	}
	public void removeExecutionListener(ExecutionListener listener) {
		if(execlist.contains(listener)) {
			execlist.remove(listener);
		}
	}
	
	public void addOutputListener(OutputListener listener) {
		if(!outputs.contains(listener)) {
			outputs.add(listener);
		}
	}
	
	public void removeOutputListener(OutputListener listener) {
		if(outputs.contains(listener)) {
			outputs.remove(listener);
		}
	}
	
	public int unzipS(String fs, String toDirs) {
		File f = new File(fs);
		File dir = toDirs == null || toDirs.length() == 0 ? null : new File(toDirs);
		return unzipF(f,dir);
	}

	public int unzipF(File f, File toDir) {
		final int BUFFER = 8192;
		File of = null;
		ZipInputStream zin = null;
		int result = 0;
		
		if(toDir == null) toDir = f.getParentFile();
		if(!f.exists()) {
			return -2;
		}
		if(!toDir.canWrite()) {
			return -3;
		}
		try {
			FileInputStream fin = new FileInputStream(f);
			zin = new ZipInputStream(fin);
			ZipEntry entry;
			byte[] buff = new byte[BUFFER];
			while((entry = zin.getNextEntry())!=null) {
				of = new File(toDir,entry.getName());
				if(entry.isDirectory()) {
					of.mkdirs();
				} else {
					BufferedOutputStream bout = null;
					try {
						FileOutputStream fos = new FileOutputStream(of);
						bout = new BufferedOutputStream(fos,8192);
						int n;
						while((n = zin.read(buff,0,BUFFER)) != -1) {
							fos.write(buff, 0, n);
						}
						zin.closeEntry();
						bout.flush();
					} finally {
						if(bout!=null) {
							bout.close();
						}
					}
				}
			}
			zin.close();
		} catch(ZipException e) {
			Log.e(LOGTAG,"zip exception " + f.getName() + ": " + e.getLocalizedMessage(),e);
			if(of != null) of.delete();
			return -4;
		} catch(IOException e) {
			Log.e(LOGTAG,"error unzipping file " + f.getName() + ": " + e.getLocalizedMessage(),e);
			if(of != null) of.delete();
			return -1;
		} finally {
			try {
				if(zin!=null) zin.close();
			}catch(Exception e) {
				
			}
		}
	
		return result;
	}
	
/// not implemented, returns null
    native public Object getVariableNative(long inst,String name); 
  /// not implemented
    native public void setVariableNative(long inst,String name, Object value); 
	
    native public int callJNative(long inst,String s); 
    native public void destroyJNative(long inst); 
    native public long initializeJNative();
    native public void setEnv(String key,String value);

// to be called back from library    
    public void output(int type,String s) {
    	for(OutputListener oo : outputs) {
    		oo.onOutput(type,s);
    	}
    }
    
    static {
    	try {
    		System.loadLibrary("j");
    	} catch(Exception e) {
    		Log.e("J-interface", "failed to load j shared object", e);
    	}
    }

    
 
}
