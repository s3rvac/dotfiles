//------------------------------------------------------------------------------
// File:   $HOME/.mongoshrc.js
// Author: Petr Zemek <s3rvac@petrzemek.net>
//------------------------------------------------------------------------------

// Prints a listing of all collections in the database alongside with their
// sizes. It is a collection-level equivalent for `show databases`.
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
		var s = db[c].stats();
		s['name'] = c;
		stats.push(s);
	});
	if (stats.length == 0) {
		return;
	}
	var longestNameLength = stats.sort(function (c1, c2) {
		return c2['name'].length - c1['name'].length;
	})[0]['name'].length;
	stats.sort(function (c1, c2) {
		return c2['size'] - c1['size'];
	});
	for (var c in stats) {
		var name = stats[c]['name'];
		var namePadding = ' '.repeat(longestNameLength - stats[c]['name'].length + 2);
		var size = formatSize(stats[c]['size']);
		var sizePadding = ' '.repeat(9 - size.length);
		var totalIndexSize = formatSize(stats[c]['totalIndexSize']);
		var totalIndexSizePadding = ' '.repeat(9 - totalIndexSize.length);
		var storageSize = formatSize(stats[c]['storageSize']);
		var storageSizePadding = ' '.repeat(9 - storageSize.length);
		print(name + namePadding +
			'size:' + sizePadding + size + '  ' +
			'totalIndexSize:' + totalIndexSizePadding + totalIndexSize + '  ' +
			'storageSize:' + storageSizePadding + storageSize
		);
	}
}
