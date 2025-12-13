#!/bin/bash

# Salir si algún comando falla
set -e

# Crear .env si no existe
if [ ! -f .env ]; then
    echo "📄 No existe .env — creando desde .env.example"
    cp .env.example .env
else
    echo "✔️ Archivo .env ya existe — no se copia"
fi

echo "📦 Instalando dependencias de Composer..."
composer install --no-interaction --prefer-dist --optimize-autoloader

echo "🔑 Generando APP_KEY (si no existe)..."
php artisan key:generate --force || true

echo "⚙️ Aplicando permisos..."
chmod -R 777 storage bootstrap/cache

echo "🔧 Sincronizando secuencia de migraciones..."
php artisan tinker --execute="try { \DB::statement(\"SELECT setval('migrations_id_seq', (SELECT MAX(id) FROM migrations))\"); echo '✅ Secuencia de migraciones sincronizada.'.PHP_EOL; } catch (\Throwable \$e) { echo 'ℹ️ Salteando sincronización (probablemente primera ejecución).'.PHP_EOL; }"

echo "🗄️ Ejecutando migraciones..."
php artisan migrate --force || true

echo "🔗 Creando enlace simbólico de almacenamiento..."
php artisan storage:link || true

echo "🧹 Limpiando caché..."
php artisan optimize:clear

echo "🚀 Optimizando aplicación..."
php artisan optimize

echo "🌱 Ejecutando Seeder..."
php artisan db:seed --force || true

echo "🚀 Iniciando PHP-FPM..."
exec php-fpm
