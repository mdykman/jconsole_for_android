package org.dykman.j.android;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

public class HelpActivity extends Activity {

	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.help);
		TextView wv = (TextView) findViewById(R.id.help);
		Bundle b = getIntent().getExtras();
		String s = b.getString("file");
		setTitle(s);
		String base = b.getString("base");
		File f = new File(base,s);
		try {
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(new FileInputStream(f)));
			StringBuilder sb = new StringBuilder();
			String line;
			while((line = reader.readLine())!=null) {
				sb.append(line).append("\n");
			}
			wv.setText(sb.toString());
		} catch(IOException e) {
			wv.setText("The was an error reading the requested file " + s);
			Log.e(JActivity.LogTag,"error loading file",e);
		}
		
	}
}
