import { Pool } from 'pg';
import { dbHost, dbPort, dbName, dbUser, dbPass, dbSsl } from '../config';

const pool = new Pool({
    host: dbHost,
    port: dbPort,
    database: dbName,
    user: dbUser,
    password: dbPass,
    // Encrypts traffic but skips certificate verification (no RDS CA bundle yet).
    ssl: dbSsl ? { rejectUnauthorized: false } : false,
});

export default pool;
