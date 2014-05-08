phantomcss = require('./../../node_modules/phantomcss/phantomcss.js')
phantomcss.init
  screenshotRoot: './spec/diff/screenshots'
  failedComparisonsRoot: './spec/diff/failures'
  libraryRoot: './node_modules/phantomcss'
  mismatchTolerance: 0.005

casper.start('./spec/diff/fixtures/defaults.html')
casper.viewport(1200, 800)
casper.then ->
  phantomcss.screenshot('body', 'defaults')

casper.then -> phantomcss.compareAll()
casper.then -> casper.test.done()
casper.run ->
  console.log("\nTHE END.")
  phantom.exit(phantomcss.getExitStatus())
