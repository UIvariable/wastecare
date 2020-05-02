const app = require('./app');
require('./connection');

//const PORT = process.env.PORT || 4000
const PORT = 4000

async function init() {
    await app.listen(PORT);
    console.log(`Server on localhost:${PORT}`);
}

init();