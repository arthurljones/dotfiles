ifconfig | grep -P 'inet(?!6)' | grep -v '127.0' | awk '{print $2}' | sed 's/addr://' 
