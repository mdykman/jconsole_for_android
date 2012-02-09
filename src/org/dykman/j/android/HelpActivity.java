package org.dykman.j.android;

import java.io.File;

import android.app.Activity;
import android.os.Bundle;
import android.webkit.WebView;

public class HelpActivity extends Activity {

	
	public HelpActivity() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.help);
		JConsoleApp app = (JConsoleApp) getApplication();
		WebView wv = (WebView) findViewById(R.id.help);
		File index = new File(app.getRoot(),
			getResources().getString(R.string.help_start));
		wv.loadUrl("file:/" + index.getAbsolutePath() );
	}
}
