import tornado.ioloop
import tornado.escape as escape
from tornado.escape import _unicode
from tornado.util import unicode_type
from tornado.web import RequestHandler

import random
import math


class MainHandler(RequestHandler):
    def get(self):
        data = []
        buckets = {}
        for i in range(1000000):
            x = math.floor(random.random()*1000)
            b = buckets.get(x,0)
            b+=1
            buckets[x] = b
        for k,v in buckets.iteritems():
            d={'x':k,'value':v}
            data.append(d)

        self.write(escape.json_encode(data))



application = tornado.web.Application([
    (r"/api/main", MainHandler),
    (r'/(.*)', tornado.web.StaticFileHandler, {'path': "html"})
])


if __name__ == "__main__":
    PORT=8888
    application.listen(PORT)
    print "Listening on port",PORT
    tornado.ioloop.IOLoop.instance().start()