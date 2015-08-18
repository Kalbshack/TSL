express = require "express"
app = express()

app.set "view engine", "jade"
app.set "views", "#{__dirname}/server/views"

app.use "/static", express.static("static")

app.get "/", (req, res) ->
    res.render "index"

server = app.listen 3000, () ->
    console.log "Läuft"
