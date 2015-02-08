import tornado.ioloop
import tornado.escape as escape
from tornado.escape import _unicode
from tornado.util import unicode_type
from tornado.web import RequestHandler


class MainHandler(RequestHandler):
    def get(self):
        self.write(escape.json_encode([10,11,12,20,30]))


application = tornado.web.Application([
    (r"/api/main", MainHandler),
    (r'/(.*)', tornado.web.StaticFileHandler, {'path': "html"})
])


if __name__ == "__main__":
    PORT=8888
    application.listen(PORT)
    print "Listening on port",PORT
    tornado.ioloop.IOLoop.instance().start()