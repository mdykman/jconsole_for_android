package org.dykman.j.android;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.dykman.j.ExecutionListener;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.Editable;
import android.util.Log;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

public class JActivity extends Activity implements ExecutionListener {
	
	public static final String CONSOLE_NAME = "J Console";
	public static final String LogTag = "j-console";
	static final String tempDir = "user/temp";
	
	public static final String EMPTY = " -- empty -- ";
	
	Console console;
	ViewGroup container = null;
    File root;
	JConsoleApp theApp;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		container = (ViewGroup) findViewById(R.id.mainLayout);
		theApp = (JConsoleApp) this.getApplication();
		root = theApp.getRoot();
		console = (Console) findViewById(R.id.ws);
		theApp.setup(this,console);
	}
	public ViewGroup getContainer() {
		return container;
	}
	
	
	protected String filePath(String path) {
		String rp = root.getAbsolutePath();
		if (path.startsWith(rp)) {
			path = path.substring(rp.length());
		}
		return path;
	}
	
	protected void showHistoryDialog() {
		AlertDialog.Builder builder = new AlertDialog.Builder(this);
		
		String [] his = theApp.getHistoryAsArray();
		AlertDialog myadd;
		if(his.length > 0) {
			ArrayAdapter<String> add = new ArrayAdapter<String>(this, R.layout.list_item, his);
			final ListView lv = new ListView(this);
			
			lv.setAdapter(add);
			builder.setView(lv);
			
			final FileEdit editor = theApp.getCurrentEditor();
			
			final AlertDialog ad = myadd = builder.create();
			lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
				public void onItemClick(AdapterView<?> v, View vv, int index,
						long id) {
					TextView tv = (TextView) vv;
					String text = new StringBuilder(tv.getText()).toString();
					if(editor instanceof Console) {
						console.append(text);
						console.placeCursor();
					} else {
						Editable ed = editor.getEditableText();
						int n = editor.getSelectionStart();
						ed.insert(n, text);
						editor.setSelection(n+text.length());
					}
					ad.dismiss();
				}
			});
			
			ad.setOnShowListener(new DialogInterface.OnShowListener() {
				public void onShow(DialogInterface dialog) {
					int nn = lv.getChildCount();
					if(nn >0) {
	//					lv.smoothScrollToPosition(nn-1);
						lv.setSelection(0);
					}
				}
			});
		} else {
			builder.setView(emptyView());
			myadd = builder.create();
		}
		myadd.show();
	}
	
	protected View emptyView() {
		TextView view = new TextView(this);
		view.setPadding(4, 4, 4, 4);
		view.setBackgroundColor(0xff000000);
		view.setTextColor(0xffffffff);
		view.setText(EMPTY);
		return view;
	}
	
	public void requestWindowSelect() {
		AlertDialog.Builder builder = new AlertDialog.Builder(this);
		ArrayAdapter<String> add = new ArrayAdapter<String>(this,
				R.layout.list_item, theApp.getWindowsAsArray());
		final ListView lv = new ListView(this);
		lv.setAdapter(add);
		builder.setView(lv);
		final AlertDialog ad = builder.create();

		lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {

			public void onItemClick(AdapterView<?> arg0, View vv, int index,
					long id) {
				TextView ttv = ((TextView) vv);
				String ss = new StringBuilder(ttv.getText()).toString();
				theApp.setWindow(ss);
				ad.dismiss();
			}
		});
		
		ad.show();
	}

	protected String[] filterFilelist(File dir, List<String> files, int nfiles) {
		List<String> res = files;
		if(nfiles == 0) {
			files.add(EMPTY);
		}
		res = new ArrayList<String>(files.size());
		for (String s : files) {
			Log.d(LogTag,"testing " + s);
			File f = new File(dir, s);
			if (s.startsWith("..") || f.isDirectory()) {
				Log.d(LogTag,f.getAbsolutePath() + " is a directory");
				res.add(s + "/");
			} else {
				Log.d(LogTag,f.getAbsolutePath() + " is a file");
				res.add(s);
			}
		}

		String[] r = res.toArray(new String[res.size()]);
		if(nfiles > 0) Arrays.sort(r, new FileComparator(dir));
		return r;
}

	protected ArrayAdapter<String> createDirAdapter(File dir,boolean dirsOnly) {
		List<String> files = loadFileList(dir, null,dirsOnly);
		int nfiles = files.size();
		if(!(dir.equals(root) || dir.getAbsolutePath().equals("/mnt/sdcard") || dir.getAbsolutePath().equals("/sdcard"))) {
			files.add(0, "..");
		}
		String[] fl = filterFilelist(dir, files,nfiles);
		return new ArrayAdapter<String>(this,R.layout.list_item, fl);
	}
	
	protected AlertDialog fileListDialog(File dir,ListView lv,boolean dirsOnly) {
		AlertDialog.Builder builder = new AlertDialog.Builder(this);
		try {
			if(dir.exists()) {
				ArrayAdapter<String> add = createDirAdapter(dir,dirsOnly);
				lv.setAdapter(add);
				String title =  filePath(dir.getCanonicalPath());
				if(title == null || title.length() == 0 || title.equals("/mnt/sdcard") || title.equals("/sdcard")) {
					title = "/";
				}
				builder.setTitle(title);
				builder.setView(lv);
			} else {
				theApp.setLocalFile(true);
				theApp.setCurrentDirectory(root);
				builder.setMessage(dir.getAbsolutePath() + " does not exist.");
			}
			return builder.create();
		} catch(IOException e) {
			Log.e(LogTag,"error creating file list",e);
		}
		return null;
	}

	public String buildTitle(File f)  throws IOException {
		String title =  filePath(f.getCanonicalPath());
		if(title == null || title.length() == 0 || title.equals("/mnt/sdcard") || title.equals("/sdcard")) {
			title = "/";
		}
		return (theApp.isLocalFile() ? "local: " : "sdcard: ") + title;
	}
	
	public void requestFileOpen() {
		
		File f = theApp.getCurrentDirectory();
		FileAction fs = new OpenFileAction(); 
		requestFileSelect(f,fs);
	}
	public void requestFileRun() {
		
		File f = theApp.getCurrentDirectory();
		
		FileAction fs = new RunFileAction(); 
		requestFileSelect(f,fs);
	}
	
	interface  FileAction {
		public void useFile(File f);
	}
	
	class OpenFileAction implements FileAction {
		public void useFile(File f) {
			EditorData data = openEditor(f);
			theApp.setWindow(data, data.name);
		}
		
	}
	class RunFileAction implements FileAction {
		public void useFile(File f) {
			theApp.runFile(console,f);
		}
		
	}

	class SaveAsAction implements FileAction {
		
		EditText et;
		public SaveAsAction(EditText et) {
			this.et = et;
		}
		
		public void useFile(File f) {
			et.setText(f.getName());
		}
		
	}
	public void requestFileSaveAs() {
		FileEdit fe = theApp.getCurrentEditor();
		File ff = fe.getFile();
		final EditText et = new EditText(JActivity.this);
		et.setLayoutParams(new ViewGroup.LayoutParams(
			ViewGroup.LayoutParams.FILL_PARENT, 
			ViewGroup.LayoutParams.WRAP_CONTENT));
		et.setSingleLine();
		et.setText(ff.getName());
		
		FileAction fs = new SaveAsAction(et); 
		File dir = ff.getParentFile();
		theApp.setCurrentDirectory(dir);
		requestFileSelect(dir,fs,et);
	}
	
	public void requestFileSelect(File dir, final FileAction ffa) {
		requestFileSelect(dir, ffa, null);
	}
	
	public void requestFileSelect(final File dir, final FileAction ffa,
			final TextView textView) {
		AlertDialog.Builder builder = new AlertDialog.Builder(this);

		final LinearLayout ll = new LinearLayout(JActivity.this);
		ll.setLayoutParams(new ViewGroup.LayoutParams(
			ViewGroup.LayoutParams.FILL_PARENT, 
			ViewGroup.LayoutParams.FILL_PARENT));
		ll.setOrientation(LinearLayout.VERTICAL);

		final ListView lv = new ListView(this);
		lv.setFastScrollEnabled(true);
//		lv.setMinimumHeight(4);

		ArrayAdapter<String> add = createDirAdapter(dir,false);
		lv.setAdapter(add);
		
		Button save = null;
		Button cancel = null;
		try {
			ll.addView(lv);

			if(textView != null) {
				LinearLayout hl = new LinearLayout(JActivity.this);
				hl.setLayoutParams(new ViewGroup.LayoutParams(
						ViewGroup.LayoutParams.FILL_PARENT, 
						ViewGroup.LayoutParams.FILL_PARENT));
				hl.setOrientation(LinearLayout.HORIZONTAL);

				save = new Button(this);
				save.setLayoutParams(new LinearLayout.LayoutParams(
						ViewGroup.LayoutParams.FILL_PARENT, 
						ViewGroup.LayoutParams.WRAP_CONTENT,1f));
				save.setGravity(Gravity.CENTER);
				save.setText("Save");
				
				hl.addView(save);

				cancel = new Button(this);
				cancel.setLayoutParams(new LinearLayout.LayoutParams(
						ViewGroup.LayoutParams.FILL_PARENT, 
						ViewGroup.LayoutParams.WRAP_CONTENT,1f));
				cancel.setText("Cancel");
				cancel.setTextAppearance(this, 12);
				
				cancel.setGravity(Gravity.CENTER);
				hl.addView(cancel);
				
				ll.addView(textView);
				ll.addView(hl);
			}
			final Button dev = new Button(this);
			dev.setLayoutParams(new ViewGroup.LayoutParams(
				ViewGroup.LayoutParams.FILL_PARENT, 
				ViewGroup.LayoutParams.FILL_PARENT));
			dev.setText("browse " + (theApp.isLocalFile() ? "sdcard" : "local"));
			ll.addView(dev);

			builder.setTitle(buildTitle(dir));
			builder.setView(ll);
			
			final AlertDialog ad = builder.create();
			
			dev.setOnClickListener(new View.OnClickListener() {
				public void onClick(View vv) {
					theApp.setLocalFile(!theApp.isLocalFile());
					File newfile = theApp.getCurrentDirectory();
					ad.dismiss();
					ll.removeView(textView);
					requestFileSelect(newfile, ffa, textView);
				}
			});

			lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
				public void onItemClick(AdapterView<?> arg0, View vv,
						int index, long id) {
					TextView ttv = ((TextView) vv);
					File d = theApp.getCurrentDirectory();
					String ss = ttv.getText().toString();
					File newfile = ss.startsWith("..") ? d.getParentFile() : new File(d, ss);
					Log.d(LogTag, "file selected: " + newfile.getPath());
					
					if (newfile.isDirectory()) {
						Log.d(LogTag, "directory " + newfile.getPath());
						theApp.setCurrentDirectory(newfile);
						ArrayAdapter<String> add = createDirAdapter(newfile,false);
						lv.setAdapter(add);
						try {
							ad.setTitle(buildTitle(newfile));
						} catch(IOException e) {
							Log.e(LogTag,"error building title",e);
						}
						lv.setAdapter(add);
					} else {
						Log.d(LogTag, "file " + newfile.getPath());
						if(EMPTY.equals(ss)) {
							return;
						}
						ffa.useFile(newfile);
						if(textView == null) ad.dismiss();
					}
				}
			});
			
			if(save != null) save.setOnClickListener(new View.OnClickListener() {
				public void onClick(View v) {
					String name = new StringBuilder(textView.getText()).toString();
					File myfile = new File(theApp.getCurrentDirectory(),name);
					FileEdit fe = theApp.getCurrentEditor();
					try {
						theApp.saveAs(fe,myfile);
					} catch(IOException e) {
						Toast.makeText(JActivity.this, "there was an error saving " + myfile.getName(), 
							Toast.LENGTH_LONG);
						Log.e(LogTag,"there was an error saving the file " + myfile.getName(),e);
					}
					ad.dismiss();
					
				}
			});
			if(cancel != null) cancel.setOnClickListener(new View.OnClickListener() {
				public void onClick(View v) {
					ad.cancel();
				}
			});
			ad.show();
		} catch(IOException e) {
			Log.e(LogTag,"an error occurred opening file dialog.",e);
		}
	}

	@Override
	public boolean onSearchRequested() {
		showHistoryDialog();
		return true;
	}
	public void showHelp(int resId) {
		Intent myIntent = new Intent(Intent.ACTION_VIEW,
			Uri.parse(getResources().getString(resId)));
		startActivity(myIntent);	
	}
	public void showTextFile(int resId) {
		Intent intent = new Intent();
		intent.setClass(this.getApplicationContext(), HelpActivity.class);
		
		intent.putExtra("file", getResources().getString(resId));
		intent.putExtra("base", root.getAbsolutePath());
		this.startActivity(intent);

	}

	public void testQuit() {
		AlertDialog.Builder builder = new AlertDialog.Builder(this);
		builder.setMessage("Are you sure you want to exit J?")
			.setCancelable(false)
			.setPositiveButton("Yes",
				new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int id) {
						quit();
					}
				})
			.setNegativeButton("No", new DialogInterface.OnClickListener() {
				public void onClick(DialogInterface dialog, int id) {
					dialog.cancel();
				}
			});
		AlertDialog dialog = builder.create();
		dialog.show();
		
	}
	@Override
	public void onBackPressed() {
		testQuit();
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = this.getMenuInflater();
		inflater.inflate(R.menu.main, menu);
		return true;
	}

	@Override
	public boolean onMenuItemSelected(int featureId, MenuItem item) {
		boolean result = true;
		switch(item.getItemId()) {
			case R.id.reset:   reset();                       break;
			case R.id.clear:   clearConsole();                break;
			case R.id.newf:    newFile();                     break;
			case R.id.open:    requestFileOpen(); 	          break;
			case R.id.window:  requestWindowSelect();     	  break;
			case R.id.jbreak:  callBreak();                   break;
			case R.id.save:    saveCurrent();                 break;
			case R.id.saveas:  requestFileSaveAs();           break;
			case R.id.close:   theApp.closeCurrent();         break;
			case R.id.exit:    testQuit();					  break;
			case R.id.log:     showHistoryDialog();			  break;
			case R.id.runl:    runCurrentLine();              break;
			case R.id.runc:    theApp.runCurrentFile(console); break; 
			case R.id.runf:    requestFileRun();              break;
			case R.id.vocab:   showHelp(R.string.help_start); break;
			case R.id.learning: showHelp(R.string.learning);  break;
			case R.id.readme:  showTextFile(R.string.readme); break;
			case R.id.aboutj:  showTextFile(R.string.aboutj); break;
			default: result = false;
		}
		return result;
	}
	protected void runCurrentLine() {
		final FileEdit editor = theApp.getCurrentEditor();

		int n = editor.getSelectionStart();
		String line = editor.getLineForPosition(n);
		console.placeCursor();
		console.append("\n");
		console.append(line);
		console.append("\n");
		theApp.callJ(line);
	}
	
	protected void clearConsole() {
		console.replaceText("");
		console.prompt();
	}
	
	protected void callBreak() {
		theApp.getjInterface().callJ("break_z_ ''");
	}

	public void quit() {
		int pid = android.os.Process.myPid();
		android.os.Process.killProcess(pid);
	}

	protected void saveCurrent() {
		try {
			FileEdit v = theApp.getCurrentEditor();
			
			v.save();
			setTitle(v.createTitle());
		} catch(IOException e) {
			Log.e(LogTag,"error on save",e);
		}
	}
	protected EditorData openEditor(File f) {
		FileEdit fe =  openFileEditor(f);
		return theApp.toData(fe);
	}
	
	protected FileEdit openFileEditor(File f) {
		FileEdit ef = new FileEdit(this);
		try {
			ef.setName(f.getName());
			ef.open(f);
		} catch(IOException e) {
			Log.e(LogTag,"error opening file",e);
		}
		return ef;
	}

	protected  List<String> loadFileList(File mPath,final  String ext,final boolean dirsOnly) {
		List<String> result = new ArrayList<String>();
		if (mPath.exists()) {
			FilenameFilter filter = new FilenameFilter() {
				public boolean accept(File dir, String filename) {
					File sel = new File(dir, filename);
					if(dirsOnly) {
						return sel.isDirectory();
					} else {
						return ext == null || filename.endsWith(ext)
							|| sel.isDirectory();
					}
				}
			};
			String[] r = mPath.list(filter);
			for (String ee : r) {
				result.add(ee);
			}
		}
		return result;
	}

	public void newFile() {
		File tmp = new File(root, tempDir);
		int i = 1;
		File newf = new File(tmp, Integer.toString(i) + ".ijs");
		while (theApp.hasEditor(newf.getName()) || newf.exists()) {
			newf = new File(tmp, Integer.toString(++i) + ".ijs");
		}
		EditorData data = openEditor(newf);
		theApp.setWindow(data, data.name);
	}

	@Override
	protected void onDestroy() {
		theApp.setConsoleState(false);
		theApp.getCurrentEditor().markCursor();
//		jInterface.removeExecutionListener(this);
		if(isFinishing()) {
			theApp.getjInterface().destroyJ();
		}
		super.onDestroy();
	}

	public void onCommandComplete(int code) {
		Log.d(LogTag, "commandComplete receives " + code);
	}
	class EngineOutput {
		int type;
		String content;

		EngineOutput(int type, String content) {
			this.type = type;
			this.content = content;
		}
	}

	public void reset() {
		Toast.makeText(this, "resetting console", Toast.LENGTH_SHORT).show();

		theApp.getjInterface().reset();
		console.replaceText("");
		theApp.bootStrapSession(this,"''");
//		console.prompt();
		InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
		imm.restartInput(console);
	}
}