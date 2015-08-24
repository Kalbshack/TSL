express = require "express"
fs = require "fs"
io = require "socket.io"
net = require "net"

if fs.existsSync 'test.sock'
    console.log 'deleting socket'
    fs.unlinkSync 'test.sock'

sockServer = net.createServer (socket) ->
    console.log "Started Socket"
    socket.write 'Hello World \r\n'

    socket.on 'connect', () ->
        console.log 'client connected'

    socket.on 'close', () ->
        console.log 'client disconnected'

    socket.on 'data', (data) ->
        execute data[0]

sockServer.listen './test.sock'

fs.chownSync 'test.sock', 1000, 1000

app = express()

app.set "view engine", "jade"
app.set "views", "#{__dirname}/server/views"

app.use "/static", express.static("static")

app.get "/", (req, res) ->
    res.render "index"

server = app.listen 3000, () ->
    console.log "Läuft"

sockServer = io.listen server


sockServer.on 'connection', (client) ->
    myclient = client
    console.log 'new io client connected'

    client.on 'res', () ->
        console.log 'res from client'
        sockServer.emit 'exe', 150


execute = (data) ->
    sockServer.emit "exe", data
