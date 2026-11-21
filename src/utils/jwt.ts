import jwt from "jsonwebtoken";

function getSecret(value: string | undefined, name: string): string {
  if (!value) throw new Error(`${name} is not set in .env`);
  return value;
}

export function createAccessToken(id: number, role: string): string {
  const secret = getSecret(process.env.JWT_ACCESS_SECRET, "JWT_ACCESS_SECRET");
  return jwt.sign({ id, role }, secret, { expiresIn: "15m" });
}

export function createRefreshToken(id: number): string {
  const secret = getSecret(process.env.JWT_REFRESH_SECRET, "JWT_REFRESH_SECRET");
  return jwt.sign({ id }, secret, { expiresIn: "7d" });
}

export function verifyAccessToken(token: string): { id: number; role: string } {
  const secret = getSecret(process.env.JWT_ACCESS_SECRET, "JWT_ACCESS_SECRET");
  return jwt.verify(token, secret) as { id: number; role: string };
}

export function verifyRefreshToken(token: string): { id: number } {
  const secret = getSecret(process.env.JWT_REFRESH_SECRET, "JWT_REFRESH_SECRET");
  return jwt.verify(token, secret) as { id: number };
}