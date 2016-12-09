//------------------------------------------------------------------------------
// File:   $HOME/.mongorc.js
// Author: Petr Zemek <s3rvac@gmail.com>
//------------------------------------------------------------------------------

// A custom prompt showing the current time and the selected database.
prompt = function() {
	time = (new Date()).toLocaleTimeString();

	if (typeof db == 'undefined') {
		return time + ' (nodb)> ';
	}

	// Check the last database operation.
	try {
		db.runCommand({ "getLastError": 1 });
	} catch (e) {
		print(e);
	}

	return time + ' ' + db + '> ';
};

// Pretty print by default.
DBQuery.prototype._prettyShell = true
