# burst-dummypool
A dummypool for testing/benchmarking your burstcoin miner.

# Usage
Place the files on a apache-webroot (.htaccess needs some other settings if you place it within a subdirectory).

Then add "http://your.webserver.com/111" to your miners settings.

The last part of the URL ("/111") defines the scoop you want to benchmark against.

By now only around 3000 scoops can be used with this dummypool, as some of the scoops weren't found by parsing the last 8000 blocks.


# Public test-dummypool
As this will use some computing power I'd be happy if I could add more dummypools to this list.

For now it is:
- http://dummypool.megash.it
