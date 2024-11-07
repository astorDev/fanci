FROM vosarat/flutter-beta AS build

COPY . /app
WORKDIR /app

RUN flutter clean && flutter build web --target lib/playground.dart --release

FROM nginx

COPY --from=build /app/build/web /usr/share/nginx/html