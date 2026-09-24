# Payload app ready for DigitalOcean

This repository is now set up as a minimal Payload + Next.js application that can be deployed from GitHub to DigitalOcean App Platform.

## What is included

- Next.js application in `/home/runner/work/LICENSE/LICENSE/src/app`
- Payload config in `/home/runner/work/LICENSE/LICENSE/src/payload.config.ts`
- PostgreSQL adapter for production-style deployment
- Example environment file in `/home/runner/work/LICENSE/LICENSE/.env.example`

## Before deployment

1. Copy `.env.example` to `.env` for local work.
2. Set a real `PAYLOAD_SECRET`.
3. Create a PostgreSQL database.
4. Put the database connection string in `DATABASE_URL`.

## Local development

```bash
npm install
npm run generate:importmap
npm run generate:types
npm run dev
```

Then open:

- Frontend: `http://localhost:3000`
- Admin: `http://localhost:3000/admin`

## DigitalOcean App Platform

Use this repository directly in DigitalOcean.

### Build command

```bash
npm install && npm run generate:importmap && npm run generate:types && npm run build
```

### Run command

```bash
npm run start
```

### Required environment variables

- `DATABASE_URL`
- `PAYLOAD_SECRET`
- `NEXT_PUBLIC_SERVER_URL`

## Notes

- This app is set up for PostgreSQL because it is easier to pair with DigitalOcean managed databases.
- You can connect the repo to DigitalOcean instead of uploading files manually.
