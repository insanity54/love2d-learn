import WebSocket, { WebSocketServer } from 'ws';
import tmi from 'tmi.js';

let chat;
const CONNECT_TO_TWITCH = false
const DEBUG = false

const wss = new WebSocketServer({
  port: 5211,
  perMessageDeflate: {
    zlibDeflateOptions: {
      // See zlib defaults.
      chunkSize: 1024,
      memLevel: 7,
      level: 3
    },
    zlibInflateOptions: {
      chunkSize: 10 * 1024
    },
    // Other options settable:
    clientNoContextTakeover: true, // Defaults to negotiated value.
    serverNoContextTakeover: true, // Defaults to negotiated value.
    serverMaxWindowBits: 10, // Defaults to negotiated value.
    // Below options specified as default values.
    concurrencyLimit: 10, // Limits zlib concurrency for perf.
    threshold: 1024 // Size (in bytes) below which messages
    // should not be compressed if context takeover is disabled.
  }
});

const chatMessageHandler = (ws, channel, tags, message, self) => {
  // console.log(`chatMessageHandler ${JSON.stringify(tags)}`);
  // console.log(`display-name=${tags['display-name']} color=${tags['color']}`);

  // in production the players will do commands like
  // !shoot 1
  // !shoot 2
  // !shoot 3
  // etc.
  //
  // but here in development we pick a random one
  const targets = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
  ]
  const randomTarget = targets[Math.floor(Math.random()*targets.length)]
  ws.send(`shoot ${randomTarget} ${tags['display-name']} ${tags['color']}`);

}

function join(ws, ch) {
  if (!chat) {
    const channel = ch.split(' ')[0];
    console.log(`[game.node] joining twitch channel='${channel}'`)
    if (!channel) {
      console.error(`[game.node] channel name was missing.`)
    } else if (channel.length < 3) {
      console.error(`[game.node] channel name must be at least 3 characters`)
    }
    chat = new tmi.Client({
      options: { debug: DEBUG },
      channels: [channel]
    });
    chat.connect();
    chat.on('message', (channel, tags, message, self) => chatMessageHandler(ws, channel, tags, message, self));
  }
}



wss.on('connection', function connection(ws) {
  console.log('[game.node] connection!')
  ws.on('error', console.error);

  ws.on('message', function message(data) {
    console.log('[game.node] received: %s', data);
    const dataString = data.toString()
    const [command, ...args] = dataString.split(' ');

    if (CONNECT_TO_TWITCH) {
      if (command === 'join') {
        join(ws, args[0]);
      }
    }
    
  });

  ws.send('this is a test something sent from game.node');



});

console.log("[game.node] start")
// // detect and close broken connections
// const interval = setInterval(function ping() {
//   wss.clients.forEach(function each(ws) {
//     if (ws.isAlive === false) return ws.terminate();
//     ws.isAlive = false;
//     ws.ping();
//   });
// }, 1000);

// wss.on('close', function close() {
//   clearInterval(interval);
// })