import { NextFunction } from 'connect';
import express from 'express';

const app = express();
const port = 3000;

// const render = (req: Request, res: Response) => {
//   res.send("./views/index.html")
// }

app.listen(port, () => {
  console.log(`Timezones by location application is running on port ${port}.`);
})

app.get("/", (req, res) => { res.redirect("/1.0") })
app.get('/1.0', (req, res) => { res.sendFile("./views/index.html", { root: __dirname }) });
app.get('/2.0', (req, res) => { res.sendFile("./views/index.html", { root: __dirname }) });
app.get("/main.js", (req, res) => { res.sendFile("./views/main.js", { root: __dirname }) })
app.get("/main.css", (req, res) => { res.sendFile("./views/main.css", { root: __dirname }) })

app.get("/images/lain", (req, res) => { res.sendFile("images/lain.jpg", { root: __dirname }) })
app.get("/images/audrey_tang", (req, res) => { res.sendFile("images/audrey_tang.jpeg", { root: __dirname }) })
app.get("/images/chino-chan", (req, res) => { res.sendFile("images/chino-chan.jpg", { root: __dirname }) })
app.get("/images/anya_forger", (req, res) => { res.sendFile("images/anya_forger.png", { root: __dirname }) })
app.get("/images/shima_rin", (req, res) => { res.sendFile("images/shima_rin.png", { root: __dirname }) })