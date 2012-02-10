package org.dykman.j.android;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.dykman.j.ExecutionListener;
import org.dykman.j.JInterface;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.Editable;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

public class JActivity extends Activity implements ExecutionListener {
	
	public static final String CONSOLE_NAME = "J Console";
	public static final String LogTag = "j-console";
	static final String tempDir = "user/temp";
	
	Console console;
	ViewGroup container = null;
    JInterface jInterface;
    File root;
	JConsoleApp theApp;
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		container = (ViewGroup) findViewById(R.id.mainLayout);
		theApp = (JConsoleApp) this.getApplication();
		jInterface = theApp.getjInterface();
		root = theApp.getRoot();
		console = (Console) findViewById(R.id.ws);
//		console.setjInterface(jInterface);
//		console.setApplication(theApp);
//		console.setBaseDirectory(root);
		//		console.setjActivity(this);
//		console.setBaseDirectory(root);
		
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
	protected void saveCurrentAs() {
	
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
		view.setText(" -- empty -- ");
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

	protected String[] filterFilelist(File dir, List<String> files) {
		List<String> res = new ArrayList<String>(files.size());
		for (String s : files) {
			File f = new File(dir, s);
			if (f.isDirectory()) {
				res.add(s + "/");
			} else {
				res.add(s);
			}
		}

		String[] r = res.toArray(new String[res.size()]);
		Arrays.sort(r, new FileComparator(dir));
		return r;
	}

	protected ArrayAdapter<String> createDirAdapter(File dir,boolean dirsOnly) {
		List<String> files = loadFileList(dir, null,dirsOnly);
		if(!(dir.equals(root) || dir.getAbsolutePath().equals("/mnt/sdcard") || dir.getAbsolutePath().equals("/sdcard"))) {
			files.add(0, "..");
		}
		String[] fl = filterFilelist(dir, files);
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

	protected AlertDialog saveAsView(File dir, String name) {
		AlertDialog.Builder builder = new AlertDialog.Builder(this);
		try {
			ViewGroup group = new LinearLayout(this);
			TextView dirname = new TextView(this);
			dirname.setText(filePath(dir.getCanonicalPath()));
			dirname.setSingleLine();
			dirname.setOnTouchListener(new View.OnTouchListener() {
				public boolean onTouch(View v, MotionEvent event) {
					return false;
					// change directory
				}
			});
			group.addView(dirname);
			EditText et = new EditText(this);
			et.setSingleLine();
			if(name!=null) et.setText(name);
			group.addView(et);
			builder.setView(group);
		} catch(IOException e ) {
			Log.d(LogTag,"error during SaveAs",e);
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
	
	public void requestFileSelect() {
		File f = theApp.getCurrentDirectory();
		requestFileSelect(f);
	}
	public void requestFileSelect(final File dir) {
		final ListView lv = new ListView(this);
//		theApp.setCurrentLocalDir(dir);

		AlertDialog.Builder builder = new AlertDialog.Builder(this);
//		builder.setMessage("a message here");
		ArrayAdapter<String> add = createDirAdapter(dir,false);
		lv.setAdapter(add);
		try {
			builder.setView(lv);
			final AlertDialog ad = builder.create();
			ad.setTitle(buildTitle(dir));
			ad.setButton(theApp.isLocalFile() ? "sdcard" : "local", 
				new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						theApp.setLocalFile(!theApp.isLocalFile());
						ad.dismiss();
						requestFileSelect();
					}
			});
			
			lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
				public void onItemClick(AdapterView<?> arg0, View vv,
						int index, long id) {
					TextView ttv = ((TextView) vv);
					File d = theApp.getCurrentLocalDir();
					String ss = new StringBuilder(ttv.getText()).toString();
					File newfile = ss.startsWith("..") ? d.getParentFile() : new File(d, ss);
					Log.d(LogTag, "file selected: " + newfile.getPath());
					
					if (newfile.isDirectory()) {
						theApp.setCurrentDirectory(newfile);
						ArrayAdapter<String> add = createDirAdapter(newfile,false);
						try {
							ad.setTitle(buildTitle(newfile));
						} catch(IOException e) {
							Log.d(LogTag,"error building title",e);
						}
						lv.setAdapter(add);
					} else {
						EditorData data = openEditor(newfile);
						theApp.setWindow(data, data.name);
						ad.dismiss();
					}
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
	public void showHelp() {
		Intent myIntent = new Intent(Intent.ACTION_VIEW,
			Uri.parse(getResources().getString(R.string.help_start)));
		startActivity(myIntent); 
/*		
		Intent intent = new Intent();
		intent.setClass(this.getApplicationContext(), HelpActivity.class);
		this.startActivity(intent);
*/
		
	}
	public void showTextFile(String file) {
		File f = new File(root,file);
		Intent intent = new Intent();
		intent.setClass(this.getApplicationContext(), HelpActivity.class);
		
		intent.putExtra("file", file);
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
			case R.id.open:    requestFileSelect(); 		  break;
			case R.id.window:  requestWindowSelect();     	  break;
			case R.id.jbreak:  callBreak();                   break;
			case R.id.save:    saveCurrent();                 break;
			case R.id.close:   theApp.closeCurrent();         break;
			case R.id.exit:    testQuit();					  break;
			case R.id.log:     showHistoryDialog();			  break;
			case R.id.runl:    runCurrentLine();              break;
			case R.id.runf:    theApp.runCurrentFile(console); break;
			case R.id.vocab:   showHelp();                    break;
			case R.id.readme:  showTextFile("docs/android-readme.txt");	break;
			case R.id.aboutj:  showTextFile("docs/aboutj.txt"); break;
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
		jInterface.callJ("break_z_ ''");
	}

	public void quit() {
		int pid = android.os.Process.myPid();		//TODO: check for editors in need of saving
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
		jInterface.removeExecutionListener(this);
		if(isFinishing()) {
			jInterface.destroyJ();
		}
		super.onDestroy();
	}

	public void commandComplete(int code) {
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

		jInterface.reset();
		console.replaceText("");
		theApp.bootStrapSession(this,"''");
//		console.prompt();
		InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
		imm.restartInput(console);
	}
}