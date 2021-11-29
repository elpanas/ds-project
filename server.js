require('dotenv').config();
const express = require('express'), // framework nodejs
    mongoose = require('mongoose'), // framework per mongoDB
    restbath = require('./routes/restbath'),
    url = process.env.DB_URI,
    port = process.env.PORT || 3000,
    connectionOptions = { 
        useNewUrlParser: true,
        useUnifiedTopology: true, 
        useCreateIndex: true, 
        autoIndex: false,
        useFindAndModify: false
    }

const app = express();

app.use(express.json()); 

// db connection
mongoose.connect(url, connectionOptions)
    .then(() => console.log('Connected to MongoDB...'))
    .catch(err => console.error('Could not connect to MongoDB...', err));

app.get('/', (req, res) => {
    res.send('BeachU Web Service');
});

app.use('/api/bath', restbath);

app.listen(port, () => console.log(`Listening on port ${port}...`));
