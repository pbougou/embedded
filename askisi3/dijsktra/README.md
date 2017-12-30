* Compile with:
	* dynamic array: gcc-4.8 -DDYN_ARR -Wall -Wextra -g -Wno-unused-but-set-variable -o dijkstra dijkstra.c  -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations
	* single linked list: gcc-4.8 -DSLL -Wall -Wextra -g -Wno-unused-but-set-variable -o dijkstra dijkstra.c  -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations
	* double linked list: gcc-4.8 -DDLL -Wall -Wextra -g -Wno-unused-but-set-variable -o dijkstra dijkstra.c  -pthread -lcdsl -L./../synch_implementations -I./../synch_implementations
