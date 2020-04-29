const path = require('path');
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => res.send('Hello World!'));

app.get('/boom', (req, res) => {
    null.boom();
    res.send('ok');
});

// Serve static content
const staticPath = path.join(__dirname, '..', 'static');
app.use(express.static(staticPath));

app.listen(port, () => console.log(`Hello Express listening at http://localhost:${port}`));