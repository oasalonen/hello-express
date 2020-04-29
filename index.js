const path = require('path');
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => res.send('Hello World!'));

app.get('/boom', (req, res) => {
    null.boom();
    res.send('ok');
});

// Serve static content
// const staticPath = __dirname === '.' 
//     ? 'D:\\home\\site\\wwwroot\\public' // workaround for Azure App Service
//     : path.join(__dirname, 'public');   // this is how it should work...
// app.use(express.static(staticPath));

app.listen(port, () => console.log(`Hello Express listening at http://localhost:${port}`));