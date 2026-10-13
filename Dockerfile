FROM node:22-alpine

WORKDIR /app

COPY package.json package-lock.json ./

# Render injects NODE_ENV=production as a build arg, which makes npm skip
# typescript/@types. Force a full install so `npm run build` can run tsc.
RUN npm ci --include=dev

COPY . .
RUN npm run build

EXPOSE 3000

CMD ["node", "dist/index.js"]
