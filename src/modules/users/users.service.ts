import { type Users } from '@prisma/client';
import prisma from '@/lib/prisma';
import LogMessage from '@/decorators/log-message.decorator';

export default class UserService {
  @LogMessage<[Users]>({ message: 'test-decorator' })

  public createUser(data: Users) {
    return prisma.users.create({ data });
  }

  public getUser(data: Users) {
    return prisma.users.findUnique({
      where: {
        id: data.id
      }
    });
  }
}
