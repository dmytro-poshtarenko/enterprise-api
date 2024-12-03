import { IsEmail, IsOptional, IsString } from 'class-validator';

export class CreateUserDto {
  @IsEmail()
  email: string;

  @IsString()
  name: string;

  @IsOptional()
  phone: string;
}

export class GetUserDto {
  @IsString()
  id: string;
}
