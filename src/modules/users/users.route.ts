import { Router } from 'express';
import Controller from './users.controller';
import { CreateUserDto, GetUserDto } from '@/dto/user.dto';
import RequestValidator from '@/middlewares/request-validator';
import { verifyAuthToken } from '@/middlewares/auth';

const users: Router = Router();
const controller = new Controller();

users.post(
  '/create',
  verifyAuthToken,
  RequestValidator.validate(CreateUserDto),
  controller.createUser
);

users.get(
  '/get',
  verifyAuthToken,
  RequestValidator.validate(GetUserDto),
  controller.getUser
);

export default users;
