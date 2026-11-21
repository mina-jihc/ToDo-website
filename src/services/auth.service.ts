import bcrypt from 'bcrypt';
import { prisma } from '../prisma';
import { Prisma } from '@prisma/client';
import { createAccessToken, createRefreshToken, verifyRefreshToken } from '../utils/jwt';
import { ConflictError, AuthError } from '../utils/errors';

export async function register(name: string, email: string, password: string) {
    try {
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = await prisma.app_users.create({
        data: { name, email, password: hashedPassword },
        select: { id: true, name: true, email: true, role: true },
    });
    const accessToken = createAccessToken(user.id, user.role);
    const refreshToken = createRefreshToken(user.id);
    await saveRefreshToken(user.id, refreshToken);
    return { user, accessToken, refreshToken }
} catch (err: unknown) {
  if (err instanceof Prisma.PrismaClientKnownRequestError && err.code === 'P2002') {
    console.log("ERROR CODE:", err.code);
    console.log("ERROR META:", err.meta);
    throw new ConflictError("Email already exists");
  }
  throw err;
}
}

export async function login(email: string, password: string) {
    const user = await prisma.app_users.findUnique({ where: { email }, select: { id: true, name: true, email: true, role: true, password: true }, });
    if (!user || !user.password) throw new AuthError('Invalid credentials');
    const ok = await bcrypt.compare(password, user.password);
    if (!ok) throw new AuthError('Invalid credentials');
    const { password: _, ...safeUser } = user;

    const accessToken = createAccessToken(user.id, user.role);
    const refreshToken = createRefreshToken(user.id);

    await saveRefreshToken(user.id, refreshToken);   

    return { user: safeUser, accessToken, refreshToken };
}

export async function saveRefreshToken(userId: number, token: string) { 
  return await prisma.refreshToken.create({
      data: { token, userId, expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000) }
    });
  }


export async function refreshTokens(oldToken: string) {
  const payload = verifyRefreshToken(oldToken);   

  const stored = await prisma.refreshToken.findUnique({
    where: { token: oldToken },
  });
  if (!stored) throw new AuthError("Invalid refresh token");

  if (stored.expiresAt < new Date()) {
    await prisma.refreshToken.delete({ where: { token: oldToken } });
    throw new AuthError("Refresh token expired");
  }

  const user = await prisma.app_users.findUnique({
    where: { id: payload.id },
    select: { id: true, name: true, email: true, role: true },
  });
  if (!user) throw new AuthError("User not found");

  await prisma.refreshToken.delete({ where: { token: oldToken } });

  const accessToken = createAccessToken(user.id, user.role);
  const refreshToken = createRefreshToken(user.id);
  await saveRefreshToken(user.id, refreshToken);

  return { user, accessToken, refreshToken };
}


export async function logout(token: string | undefined) {
  if (!token) return;
  await prisma.refreshToken.deleteMany({ where: { token } });
}