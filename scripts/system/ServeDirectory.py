#!/usr/bin/python
import sys, argparse
import http.server
import socketserver

Parser = argparse.ArgumentParser()
Parser.add_argument('-p', '--port', help='Enter port number.', default=8080, required=True, type=int)

ext2conttype = {"jpg": "image/jpeg",
                "jpeg": "image/jpeg",
                "png": "image/png",
                "gif": "image/gif"}

if __name__ == '__main__':
	Args, _ = Parser.parse_known_args()

	Handler = http.server.SimpleHTTPRequestHandler
	Handler.extensions_map.update(ext2conttype)

	httpd = socketserver.TCPServer(("", Args.port), Handler)

	try:
		print('[ INFO ]: Serving at port', Args.port)
		httpd.serve_forever()
	except KeyboardInterrupt:
		pass
	print('[ INFO ]: Shutting down.')
	httpd.server_close()
