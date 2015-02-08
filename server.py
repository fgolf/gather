import tornado.ioloop
import tornado.escape as escape
from tornado.escape import _unicode
from tornado.util import unicode_type
from tornado.web import RequestHandler



application = tornado.web.Application([
    (r'/(.*)', tornado.web.StaticFileHandler, {'path': "html"})
])


if __name__ == "__main__":
    PORT=8888
    application.listen(PORT)
    print "Listening on port",PORT
    tornado.ioloop.IOLoop.instance().start()