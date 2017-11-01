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
		db.runCommand({ 'getLastError': 1 });
	} catch (e) {
		print(e);
	}

	return time + ' ' + db + '> ';
};

// Pretty print by default.
DBQuery.prototype._prettyShell = true

// Prints a listing of all collections in the database alongside with their
// sizes. It is a collection-level equivalent for `show dbs`.
function showCollectionSizes() {
	function formatSize(size) {
		// Based on http://stackoverflow.com/a/20732091/2580955.
		if (size == 0) {
			return '0 B';
		}
		var i = Math.floor(Math.log(size) / Math.log(1024));
		return (size / Math.pow(1024, i)).toFixed(1) * 1 + ' ' +
			['B', 'KB', 'MB', 'GB', 'TB'][i];
	};

	var stats = [];
	db.getCollectionNames().forEach(function (c) {
		stats.push(db[c].stats());
	});
	if (stats.length == 0) {
		return;
	}
	var longestNameLength = stats.sort(function (c1, c2) {
		return c2['ns'].length - c1['ns'].length;
	})[0]['ns'].length;
	stats.sort(function (c1, c2) {
		return c2['size'] - c1['size'];
	});
	for (var c in stats) {
		var size = formatSize(stats[c]['size']);
		var sizePadding = ' '.repeat(9 - size.length);
		var totalIndexSize = formatSize(stats[c]['totalIndexSize']);
		var totalIndexSizePadding = ' '.repeat(9 - totalIndexSize.length);
		var storageSize = formatSize(stats[c]['storageSize']);
		var storageSizePadding = ' '.repeat(9 - storageSize.length);
		print(stats[c]['ns'] + ': ' + ' '.repeat(longestNameLength - stats[c]['ns'].length + 1) +
			'size:' + sizePadding + size + '  ' +
			'totalIndexSize:' + totalIndexSizePadding + totalIndexSize + '  ' +
			'storageSize:' + storageSizePadding + storageSize
		);
	}
}
