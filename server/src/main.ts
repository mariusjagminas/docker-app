import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { readFileSync, existsSync, realpathSync } from 'fs';
import { join } from 'path';

const curentDir = realpathSync('.');
const keyPath = join(curentDir, 'cert', 'key.pem');
const certPath = join(curentDir, 'cert', 'cert.pem');
const options: any = {};

if (existsSync(keyPath) && existsSync(certPath)) {
  options.httpsOptions = {
    cert: readFileSync(certPath),
    key: readFileSync(keyPath),
  };

  console.log('Certificate loaded');
} else {
  console.log('HTTP');
}

async function bootstrap() {
  const app = await NestFactory.create(AppModule, options);
  await app.listen(3000);
}

bootstrap();
