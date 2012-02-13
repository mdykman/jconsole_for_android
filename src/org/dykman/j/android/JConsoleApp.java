package org.dykman.j.android;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.dykman.j.JInterface;
import org.dykman.j.OutputListener;
import org.dykman.j.android.Console.Dimension;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Application;
import android.content.DialogInterface;
import android.content.res.AssetManager;
import android.os.AsyncTask;
import android.util.Log;
import android.widget.Toast;

public class JConsoleApp extends Application {
	
	

	protected JInterface jInterface = null;
	protected FileEdit currentEditor = null;
	JActivity activity;

	protected Map<String, EditorData> windows = new HashMap<String, EditorData>();
	
	protected java.util.List<String> history = new LinkedList<String>();
	protected final String tempDir = "user/temp";
	protected File root;
	protected File currentLocalDir;
	protected File currentExternDir = new File("/sdcard");
	private Console console;
	boolean localFile = true;
	
	public boolean isLocalFile() {
		return localFile;
	}

	public void setLocalFile(boolean localFile) {
		this.localFile = localFile;
	}

	List<EngineOutput> outputs = new LinkedList<JConsoleApp.EngineOutput>();
	
//	protected Console console;
//	protected ViewGroup container = null;
	protected String currentWindow;
	boolean consoleState = false;
	boolean started = false;
	public JConsoleApp() {
		// TODO Auto-generated constructor stub
	}
	
	protected void flushOutputs() {
		for(EngineOutput eo : outputs) {
			console.consoleOutput(eo.type, eo.content);
		}
		outputs.clear();
	}
	
	public void consoleOutput(EngineOutput output) {
		if(!consoleState) {
			outputs.add(output);
		} else {
			flushOutputs();
			console.consoleOutput(output.type, output.content);
		}
	}
	@Override
	public void onCreate() {
		root = getDir("jconsole",0);
		if(currentLocalDir == null) {
			currentLocalDir = root;
		}
		jInterface = new JInterface();
	}

	public void setup(JActivity activity,Console console) {
		this.activity = activity;
		this.console = console;
		this.console.setApplication(this);
		if(currentWindow == null) {
			setConsole(console, JActivity.CONSOLE_NAME);
		} else {
			setWindow(currentWindow);
		}
		
		if(!started) {
			started = true;
			StringBuilder sb = new StringBuilder();
			sb.append("1!:44 '").append(root.getAbsolutePath()).append("'");
			jInterface.callJ(sb.toString());
			installSystemFiles(activity,console,root,false);
		}
		setConsoleState(true);
		flushOutputs();
	}
	
	public void setConsoleState(boolean n) {
		consoleState = n;
	}
	protected String[] getHistoryAsArray() {
		return history.toArray(new String[history.size()]);
	}
	protected String[] getWindowsAsArray() {
		Set<String> k = windows.keySet();
		return k.toArray(new String[k.size()]);
	}
	public void addHistory(String line) {
		if (line != null && line.trim().length() > 0) {
			line = line.trim();
			if (history.size() >= 100) {
				history.remove(history.size()-1);
//				history.remove(0);
			}
			if(history.contains(line)) {
				history.remove(line);
			}
//			history.add(line);
			history.add(0,line);
		}
	}
	public void setWindow(String label) {
		if(JActivity.CONSOLE_NAME.equals(label)) {
			setConsole(console, label);
		} else {
			EditorData fe = windows.get(label);
			if(fe!=null) {
				setWindow(fe,label);
			}
		}
	}
	
	protected EditorData toData(FileEdit fe) {
		File f = fe.getFile();
		return new EditorData(
				fe.getName(),
				f == null ? null : f.getAbsolutePath(), 
				fe.getText(), 
				fe.getSelectionStart(),
				fe.textChanged);
	}
	
	protected FileEdit toView(FileEdit fe,EditorData data) {
		if(data.text != null) fe.setText(data.text);
		else fe.setText("");
		fe.cursorPosition = data.cursorPosition;
		fe.setName(data.name);
		if(data.path != null) {
			fe.setFile(new File(data.path));
		}
		fe.setTextChanged(data.changed);
		return fe;
	}
	
	protected void preserveCurrentWindow() {
		if(currentEditor != null) {
			currentEditor.markCursor();
				EditorData old = toData(currentEditor);
				String ol = getCurrentWindow();
				windows.put(ol, old);
		}
	}
	
	protected void setView(String label, FileEdit win) {
//Log.d(JActivity.LogTag,"SETVIEW " + label + ", " + win.getClass().getName());
		setCurrentWindow(label);
		currentEditor =  win;
		activity.getContainer().removeAllViews();
		activity.getContainer().addView(win);
		if(win instanceof Console) {
			activity.setTitle(label);
		} else {
			activity.setTitle(win.createTitle());
		}
		win.requestFocus();
		win.restoreCursor();
	}

	public void setConsole(Console console, String label) {
		preserveCurrentWindow();
		EditorData data = windows.get(label);
		windows.put(label, null);
		if(data != null) toView(console,data);
		setView(label, console);
		console.requestFocus();
		console.restoreCursor();
	}

	public void setWindow(EditorData data, String label) {
		preserveCurrentWindow();
		FileEdit win = new FileEdit(activity);
		toView(win,data);
		windows.put(label, data);
		setView(label, win);
		win.restoreCursor();
	}

	protected void doCloseCurrent() {
		final FileEdit editor = getCurrentEditor();

		if(!(editor instanceof Console)) {
			String cw = getCurrentWindow();
			windows.remove(cw);
		}
	}
	
	protected void promptSaveWithAction(final FileEdit fe, final ResponseAction action) 
			throws IOException {
		AlertDialog.Builder builder = new AlertDialog.Builder(this);
		builder.setMessage("Save " + fe.getName() +"?")
//				.setCancelable(false)
			.setPositiveButton("Yes",
				new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int id) {
						try {
							fe.save();
							if(action != null) action.action(true);
//							doCloseCurrent();
							dialog.dismiss();
						} catch(IOException e) {
							Log.e(JActivity.LogTag,"error saving file",e);
						}
					}
				})
			.setNegativeButton("No", new DialogInterface.OnClickListener() {
				public void onClick(DialogInterface dialog, int id) {
					if(action != null) action.action(false);
					dialog.cancel();
				}
				});
		AlertDialog dd = builder.create();
		dd.show();
	}
	protected void closeCurrent() {
		try {
			final FileEdit fe = getCurrentEditor();
			if(! JActivity.CONSOLE_NAME.equals(fe.getName())) {
				if(fe.isTextChanged()) {
					promptSaveWithAction(fe, new ResponseAction() {
						public void action(boolean state) {
							doCloseCurrent();
						}
					});
				} else {
					doCloseCurrent();
				}
			}
		} catch(IOException e) {
			Log.e(JActivity.LogTag,"error on close",e);
		}
	}

	public boolean hasEditor(String name) {
		return windows.keySet().contains(name);
	}
	   
	protected void runCurrentFile(final Console console) {
		final FileEdit editor = getCurrentEditor();
		if(!(editor instanceof Console)) {
			try {
				if(editor.isTextChanged()) {
					promptSaveWithAction(editor, new ResponseAction() {
						public void action(boolean state) {
							if(state) {
								File f = editor.getFile();
								runFile(console,f);
							}
						}
					});
				} else {
					File f = editor.getFile();
					runFile(console,f);
				}
			} catch(IOException e) {
				Log.e(JActivity.LogTag,"error running current file",e);
			}
		}
	}
	protected void runFile(Console console,File f) {
		StringBuilder sb = new StringBuilder("load '");
		sb.append(f.getAbsolutePath()).append("'");
		
		console.placeCursor();
		console.append("\n");
		console.append(sb.toString());
		console.append("\n");
		callJ(sb.toString());
	}
	public void callJ(String... sentences) {
		JTask task = new JTask();
		task.execute(sentences);
	}

	
	protected void bootstrap(Console console) {
		Toast.makeText(activity, "booting session", Toast.LENGTH_SHORT).show();
		bootStrapSession(activity,"''");
	}

	protected void bootStrapSession(JActivity activity, String... args) {
		String argv = "''";
		if(args.length > 0) {
			argv = args[0];
		}
		String home = root.getPath();
		StringBuilder sb = new StringBuilder();
		sb.append("(3 : '0!:0 y')<BINPATH,'/profile.ijs' [ ARGV_z_=: ")
				.append(argv).append(" [ BINPATH_z_ =: '")
				.append(home)
				.append("/bin").append("'");
		Log.d(JActivity.LogTag, "initialize engine: " + sb.toString());
		
		if(args.length > 1) {
			String [] ss = new String[args.length];
			ss[0] = sb.toString();
			Log.d(JActivity.LogTag,ss[0]);
			for(int i =1; i<args.length; ++i) {
				ss[i] = args[i];
				Log.d(JActivity.LogTag,ss[i]);
			}
			callJ(ss);
			
		} else {
			Log.d(JActivity.LogTag,sb.toString());
			callJ(sb.toString());
		}
	}


	protected void installSystemFiles(JActivity activity,Console console,File base,boolean force) {
		if(force || !checkInstall(base)) {
			InstallationTask task = new InstallationTask(activity,console);
			task.execute(base);
		} else {
			Log.d(JActivity.LogTag,"bootstrapping");
			bootstrap(console);
		}
	}
	protected boolean checkInstall(File base) {
		return new File(base, "system").exists();
	}
	protected void showToast(String message) {
		showToast(message,false);
	}
	protected void showToast(String message, boolean islong) {
		Toast toast = Toast.makeText(this, message, islong ? Toast.LENGTH_LONG
				: Toast.LENGTH_SHORT);
		toast.show();
	}
	
	interface ResponseAction {
		public void action(boolean state);
	}

	class InstallationTask extends AsyncTask<File, String, String> {

		Activity activity;
		Console console;

		InstallationTask(Activity activity, Console console) {
			this.activity = activity;
			this.console = console;
		}

		@Override
		public void onPreExecute() {
			console.setEnabled(false);
		}

		@Override
		public void onPostExecute(String s) {
			bootstrap(console);
			
			console.setEnabled(true);
		}

		@Override
		protected void onProgressUpdate(String... i) {
			String limit = i[0];
			showToast(limit);
		}

		@Override
		protected String doInBackground(File... params) {
			try {
				doInstall(params[0]);
			} catch (IOException e) {
				publishProgress("error during installation: "
						+ e.getLocalizedMessage());
			}
			return "OK";
		}

		protected boolean doInstall(File base) throws IOException {
			publishProgress("performing first-boot installation");
			publishProgress("installing system files");
			installDirectory(base, "system");
			installDirectory(base, "bin");

			publishProgress("installing help files");
			installDirectory(base, "docs");

			publishProgress("installing addons");
			publishProgress("(addons take awhile)");
			installDirectory(base, "addons");			
			
			publishProgress("installing test files");
			installDirectory(base, "test");
			
			publishProgress("installation complete");

			return true;
		}

		protected boolean _installFile(File base, String path) 
			throws IOException {
			byte buff[] = new byte[8092];
			InputStream in = getAssets().open(path);
			OutputStream out = new FileOutputStream(new File(base, path));
			int n;
			while ((n = in.read(buff)) != -1) {
				out.write(buff, 0, n);
			}
			out.close();
			in.close();
			return true;
		}		
		
		
		protected boolean installFile(File base, String path) {
			try {
				return _installFile(base,path);
			} catch (Exception e) {
				Log.e(JActivity.LogTag, "failed to install " + path);
			}
			return false;
		}

		protected File createDirectory(File base, String d) {
			File f = new File(base, d);
			f.mkdirs();
			return f;
		}

		protected boolean installDirectory(File base, String directory)
				throws IOException {
			AssetManager am = getAssets();
			boolean res = true;
			String[] tests = am.list(directory);
			createDirectory(base, directory);
			for (String t : tests) {
				try {
					res &= _installFile(base, directory + "/" + t);
				} catch(FileNotFoundException e) {
					Log.i(JActivity.LogTag,"recursing to " + directory + "/" + t);
					installDirectory(base,directory + "/" + t);
				}
			}
			return res;
		}
	}
	
	public JInterface getjInterface() {
		return jInterface;
	}
	public void setjInterface(JInterface jInterface) {
		this.jInterface = jInterface;
	}
	public String getCurrentWindow() {
		return currentWindow;
	}
	public void setCurrentWindow(String currentWindow) {
		this.currentWindow = currentWindow;
	}
	public FileEdit getCurrentEditor() {
		return currentEditor;
	}
	public void setCurrentEditor(FileEdit currentEditor) {
		this.currentEditor = currentEditor;
	}
	public java.util.List<String> getHistory() {
		return history;
	}
	public void setHistory(java.util.List<String> history) {
		this.history = history;
	}
	public File getRoot() {
		return root;
	}
	public void setRoot(File root) {
		this.root = root;
	}
	public File getCurrentLocalDir() {
		return currentLocalDir;
	}
	public void setCurrentLocalDir(File currentDir) {
		currentLocalDir = currentDir;
	}
	public File getCurrentExternDir() {
		return currentExternDir;
	}
	public void setCurrentExternDir(File currentDir) {
		currentExternDir = currentDir;
	}
	
	public void setCurrentDirectory(File dir) {
		if(localFile) setCurrentLocalDir(dir);
		else setCurrentExternDir(dir);			
	}

	
	public File getCurrentDirectory() {
		File f = null;
		if(localFile) {
			f = getCurrentLocalDir();
		} else {
			f = getCurrentExternDir();
		}
		return f;
	}
	public String getTempDir() {
		return tempDir;
	}
	static class EngineOutput {
		int type;
		String content;

		EngineOutput(int type, String content) {
			this.type = type;
			this.content = content;
		}
	}

	class JTask extends AsyncTask<String, EngineOutput, Integer> 
		implements OutputListener {
	
		int width, height;
		@Override
		public void onProgressUpdate(EngineOutput... oo) {
			EngineOutput o = oo[0];
			consoleOutput(o);
		}
	
		public void onOutput(int type, String content) {
			publishProgress(new EngineOutput(type, content));
		}
	
		@Override
		protected void onPreExecute() {
			console.setEnabled(false);
			Dimension dd = console.getDimension();
			width = dd.width;
			height = dd.height;
		}
	
		@Override
		protected Integer doInBackground(String... params) {
			Integer res = -1;
			StringBuilder sb = new StringBuilder();
			sb.append("Cwh_j_ =: ").append(width).append(" ").append(height);
			res = jInterface.callJ(sb.toString());
			jInterface.addOutputListener(this);
			for(String sentence : params) {
				res = jInterface.callJ(sentence);
			}
			jInterface.removeOutputListener(this);
			return res;
		}
	
		@Override
		protected void onPostExecute(Integer code) {
			// this is a worry, in the world of async windows
			EditorData ed = windows.get(JActivity.CONSOLE_NAME);
			if(ed!=null) {
				ed.placeCursor();
			}
			console.placeCursor();
			console.prompt();
			console.setEnabled(true);
		}
	}

}
