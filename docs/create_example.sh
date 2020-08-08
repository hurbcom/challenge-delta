  
#!/bin/bash

rm -f how2use.cast
asciinema rec --command "bash example.sh" how2use.cast
cat how2use.cast | svg-term --window --out how2use.svg
