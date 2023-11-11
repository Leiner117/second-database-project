import express from 'express';
import sql from 'mssql';

const app = express();
const port = 3000;
const connectionString = 'Server=Localhost\\Leiner117;Database=TransGaby;Trusted_Connection=true;';
// Configuración de la conexión
const config = {
    server: 'localhost\\Leiner117',
    database: 'TransGaby',
    options: {
        trustedConnection: true
    }
};

app.get('/', async (req, res) => {
    try {
        // Intenta conectar a la base de datos
        let pool = await sql.connect(connectionString);
        res.send('Conexión a la base de datos establecida con éxito.');
    } catch (error) {
        console.error('No se pudo conectar a la base de datos:', error);
        res.send('No se pudo conectar a la base de datos.');
    }
});

app.listen(port, () => {
    console.log(`El servidor está corriendo en http://localhost:${port}`);
});