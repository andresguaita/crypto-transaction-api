# Usa una imagen oficial de Ruby
FROM ruby:3.3.5

# Instala dependencias de sistema
RUN apt-get update -qq && apt-get install -y nodejs yarn postgresql-client

# Configura el directorio de trabajo en /app
WORKDIR /app

# Copia el archivo Gemfile y Gemfile.lock al contenedor
COPY Gemfile Gemfile.lock ./

# Instala las gemas necesarias
RUN bundle install

# Copia el resto de la aplicación al contenedor
COPY . .

# Expone el puerto 3000 para la aplicación Rails
EXPOSE 3000

# Comando por defecto para iniciar el servidor de Rails
CMD ["bash", "-c", "rm -f tmp/pids/server.  && bundle exec rails db:create && bundle exec rails db:migrate && bundle exec rails server -b '0.0.0.0' -p 3000"]
