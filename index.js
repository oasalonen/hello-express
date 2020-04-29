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
const staticPath = __dirname === '.' 
    ? 'public'                          // workaround for Azure App Service
    : path.join(__dirname, 'public');   // this is how it should work...
// Use virtual static folder that points to public. Otherwise IIS Node interferes.
app.use('/static', express.static(staticPath));

app.get('/openapi', (req, res) => {
    res.sendFile(path.join(staticPath, '/swagger.yaml'));
});

app.listen(port, () => console.log(`Hello Express listening at http://localhost:${port}`));