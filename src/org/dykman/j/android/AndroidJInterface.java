package org.dykman.j.android;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.LinkedList;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.dykman.j.ExecutionListener;
import org.dykman.j.JInterface;
import org.dykman.j.OutputListener;

import android.os.AsyncTask;
import android.util.Log;

public class AndroidJInterface extends JInterface {

	JConsoleApp theApp;
	JRunner runner = null;
	
	public AndroidJInterface(JConsoleApp theApp) {
		this.theApp = theApp;
		runner = new JRunner();
//		runner.execute(new String[]{});
	}
	
	public void stop() {
		runner.stop();
	}
	
	public void start() {
		runner.execute(new String[]{});
	}

	Thread thread = null;
	LinkedList<String> commandBuffer = new LinkedList<String>(); 
	public void addLine(String sentence) {
		synchronized (commandBuffer) {
			commandBuffer.addFirst(sentence);
			if(thread!= null && thread.getState() == Thread.State.TIMED_WAITING) {
				thread.interrupt();
			}
		}
	}
	
	public String nextLine() {
		try {
			while(true) {
				synchronized(commandBuffer) {
					thread = Thread.currentThread();
					if(commandBuffer.size() >0) {
						return commandBuffer.removeLast();
					}
				}
				try {
					Thread.sleep(250);
				} catch(Exception e) {
					// ignore sleep/interrupted exceptions
				}
			} 
		} catch(Exception e) {
			Log.e(LOGTAG,"rerror reading line",e);
		}
		synchronized(commandBuffer) {
			thread = null;
		}
		return null;
	}
	
	int downloadFile(String urlS, String fileS) {

		int result = -1;
		try {
//			Map<String, String> nv = System.getenv();

/*
			for (Map.Entry<String, String> en : nv.entrySet()) {
				Log.d(LOGTAG, "env: " + en.getKey() + "=" + en.getValue());
			}
*/
			URL url = new URL(urlS);
			
			HttpGet get = new HttpGet(url.toURI());
			HttpClient client = new DefaultHttpClient();
			HttpResponse response = client.execute(get);
			HttpEntity entity = response.getEntity();
			InputStream in = null;
			OutputStream out = null;

			try {
				File file = new File(fileS);
				// assure parent folder exists
				if(file.exists()) {
					if(!file.canWrite()) {
						return -2;
					}
				} else {
					file.getParentFile().mkdirs();
					if(!file.getParentFile().canWrite()) {
						return -3;
					}
				}
				out = new FileOutputStream(file);
				in = entity.getContent();
				int rcode = response.getStatusLine().getStatusCode();
				if (rcode != 200) {
					if (rcode == 0) {
						return -99;
					}
					return -rcode;
				}
				byte[] buff = new byte[8092];
				int s;
				int counter = 0;
				while ((s = in.read(buff)) != -1) {
					out.write(buff, 0, s);
					counter+=s;
				}
				result = counter;
				long cl = entity.getContentLength();
				if(cl >= 0) {
					if(cl != result) {
						Log.w(LOGTAG,"content length reports difference while downloading " + fileS + ". cl = "
								+ cl + ", downloaded bytes=" + result);
					}
				}
			} finally {
				try {
					if (out != null)
						out.close();
					if (in != null)
						in.close();
				} catch (Exception e) {
					// quietly ignore
				}
			}
		} catch (MalformedURLException e) {
			Log.e(LOGTAG, "failed to download file due to malformed url: "
					+ urlS);
			result = -5;
		} catch (IOException e) {
			Log.e(LOGTAG,
					"failed to download file due to IOException: "
							+ e.getLocalizedMessage(), e);
			result = -6;
		} catch (Exception e) {
			Log.e(LOGTAG, "failed to download file.", e);
			result = -1;
		}

		return result;
	}
	public int callSuperJ(String []sentence) {
		return super.callJ(sentence);
	}	
	@Override
	public int callJ(String []sentence) {
		runner.addSentence(sentence);
		return 0;
	}
	
	class JRunner extends AsyncTask<String, Object, Integer> 
		implements ExecutionListener, OutputListener {
		LinkedList<String> cms = new LinkedList<String>();
		Thread thread;
		boolean running = true;
		

		protected void intr() {
			if (thread.getState() == Thread.State.TIMED_WAITING) {
				thread.interrupt();
			}
		}
		public void stop() {
			running = false;
			intr();
		}
		public void addSentence(String []ss) {
			theApp.setEnableConsole(false);
			for(String s : ss) {
				addS(s);
			}
		
		}
		public void addS(String s) {
			try {
				synchronized (cms) {
					cms.addFirst(s);
				}
				intr();
			} catch (Exception e) {

			}
		}
		@Override
		protected void onProgressUpdate(Object... objs) {
			for(Object o : objs) {
				if(o instanceof Boolean) {
					theApp.setEnableConsole((Boolean)o);
				} else if(o instanceof EngineOutput) {
					theApp.consoleOutput((EngineOutput)o);
				}
			}
		}

		@Override
		protected Integer doInBackground(String... params) {
			AndroidJInterface.this.addOutputListener(this);
			thread = Thread.currentThread();
			boolean worked = false;
			while (running) {
				String cmd = null;
				synchronized (cms) {
					if (cms.size() > 0) {
						cmd = cms.removeLast();
					}
				}
				
				if(cmd != null) {
					StringBuilder sb = new StringBuilder();
			        Dimension dd = theApp.getDimension();
			        if(dd != null) {
				        sb.append("Cwh_j_=:").append(dd.width).append(" ").append(dd.height);
				        callSuperJ(new String[]{sb.toString()});
			        }
					AndroidJInterface.this.addExecutionListener(this);
					callSuperJ(new String[]{cmd});
					AndroidJInterface.this.removeExecutionListener(this);
					worked = true;
				} else {
					if(worked) publishProgress(true);
					try {
						Thread.sleep(250);
					} catch (Exception e) {
						// ignore
					}
				}
			}
			AndroidJInterface.this.removeOutputListener(this);
			return 0;
		}
		
		public void onCommandComplete(int resultCode) {
			EngineOutput eo = new EngineOutput(AndroidJInterface.MTYOFM, "  ");
			publishProgress(eo);

//			theApp.consoleOutput(AndroidJInterface.MTYOFM, "\n  ");
			Log.d(LOGTAG,"command completes receives " + resultCode);
		}
		public void onOutput(int type, String s) {
			EngineOutput eo = new EngineOutput(type, s);
			publishProgress(eo);
		}
	}
}
