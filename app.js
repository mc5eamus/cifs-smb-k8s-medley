'use strict';
const chokidar = require('chokidar');

const mediaPath = "/tmp"
console.log('setting up chokidar for ' + mediaPath);
var watcher = chokidar.watch(mediaPath, {persistent: true, usePolling: true, interval: 500});

watcher
    .on('add', function(path) {
      console.log('File', path, 'has been added');
    })
    .on('change', function(path) {console.log('File', path, 'has been changed');})
    .on('unlink', function(path) {console.log('File', path, 'has been removed');})
    .on('error', function(error) {console.error('Error happened', error);})
    
