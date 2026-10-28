import fs from 'fs/promises';
import type { ToDo } from '../types.js'

const dbPath = process.env.DB_PATH || './backend/data.json';

export const readDB = async (): Promise<ToDo[]> => {
    try {
        const data = await fs.readFile(dbPath, 'utf-8');
        return await JSON.parse(data)
    } catch {
        return [];
    }
}

export const writeDB = async (data: ToDo[]) => {
    await fs.writeFile(dbPath, JSON.stringify(data, null, 2));
}