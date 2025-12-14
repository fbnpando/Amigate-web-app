<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. Usuarios (Main User Table)
        if (!Schema::hasTable('usuarios')) {
            Schema::create('usuarios', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->string('nombre');
                $table->string('email')->unique();
                $table->string('contrasena');
                $table->string('telefono')->nullable();
                $table->string('avatar_url')->nullable();
                $table->string('rol')->default('cliente');
                $table->integer('puntos_ayuda')->default(0);
                $table->boolean('activo')->default(true);
                $table->decimal('ubicacion_actual_lat', 10, 8)->nullable();
                $table->decimal('ubicacion_actual_lng', 11, 8)->nullable();
                $table->timestamp('fecha_registro')->useCurrent();
                $table->timestamps();
            });
        }

        // 1a. Users (Standard Laravel Table - seemingly used by Auth/Nova?)
        if (!Schema::hasTable('users')) {
            Schema::create('users', function (Blueprint $table) {
                $table->id();
                $table->string('name');
                $table->string('email')->unique();
                $table->timestamp('email_verified_at')->nullable();
                $table->string('password');
                $table->rememberToken();
                $table->timestamps();
            });
        }

        // 2. Password Reset Tokens
        if (!Schema::hasTable('password_reset_tokens')) {
            Schema::create('password_reset_tokens', function (Blueprint $table) {
                $table->string('email')->primary();
                $table->string('token');
                $table->timestamp('created_at')->nullable();
            });
        }

        // 3. Sessions
        if (!Schema::hasTable('sessions')) {
            Schema::create('sessions', function (Blueprint $table) {
                $table->string('id')->primary();
                $table->string('user_id')->nullable()->index(); // Changed to string/generic to support both UUID and Int IDs
                $table->string('ip_address', 45)->nullable();
                $table->text('user_agent')->nullable();
                $table->longText('payload');
                $table->integer('last_activity')->index();
            });
        }

        // 4. Categorias
        if (!Schema::hasTable('categorias')) {
            Schema::create('categorias', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->string('nombre');
                $table->string('icono')->nullable();
                $table->string('color')->nullable();
                $table->text('descripcion')->nullable();
                $table->boolean('activo')->default(true);
                $table->timestamps();
            });
        }

        // 5. Cuadrantes
        if (!Schema::hasTable('cuadrantes')) {
            Schema::create('cuadrantes', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->string('codigo');
                $table->string('fila');
                $table->integer('columna');
                $table->string('nombre')->nullable();
                $table->text('geometria')->nullable();
                $table->text('centro')->nullable();
                $table->decimal('lat_min', 10, 8);
                $table->decimal('lat_max', 10, 8);
                $table->decimal('lng_min', 11, 8);
                $table->decimal('lng_max', 11, 8);
                $table->string('ciudad')->nullable();
                $table->string('zona')->nullable();
                $table->json('barrios')->nullable();
                $table->boolean('activo')->default(true);
                $table->timestamp('created_at')->useCurrent();
                $table->decimal('centro_lat', 10, 8)->nullable();
                $table->decimal('centro_lng', 11, 8)->nullable();
                // $table->timestamps(); // Removed to match backup order exactly (updated_at missing in backup)
            });
             // Add polygon column using raw SQL to bypass Blueprint limitation
            DB::statement('ALTER TABLE cuadrantes ADD COLUMN area_geografica polygon');
        }

        // 6. Cuadrante Barrios
        if (!Schema::hasTable('cuadrante_barrios')) {
            Schema::create('cuadrante_barrios', function (Blueprint $table) {
                $table->id();
                $table->foreignUuid('cuadrante_id')->constrained('cuadrantes')->onDelete('cascade');
                $table->string('barrio_nombre');
                $table->timestamps();
            });
        }

        // 7. Grupos
        if (!Schema::hasTable('grupos')) {
            Schema::create('grupos', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->foreignUuid('cuadrante_id')->nullable()->constrained('cuadrantes')->onDelete('set null');
                $table->string('nombre');
                $table->text('descripcion')->nullable();
                $table->string('imagen_url')->nullable();
                $table->boolean('publico')->default(true);
                $table->boolean('requiere_aprobacion')->default(false);
                $table->integer('miembros_count')->default(0);
                $table->integer('reportes_activos_count')->default(0);
                $table->integer('reportes_resueltos_count')->default(0);
                $table->timestamps();
            });
        }

        // 8. Grupo Miembros
        if (!Schema::hasTable('grupo_miembros')) {
            Schema::create('grupo_miembros', function (Blueprint $table) {
                $table->uuid('id')->primary(); // Backup uses UUID
                $table->foreignUuid('grupo_id')->constrained('grupos')->onDelete('cascade');
                $table->foreignUuid('usuario_id')->constrained('usuarios')->onDelete('cascade');
                $table->string('rol')->default('miembro'); // admin, moderador, miembro
                $table->boolean('notificaciones_activas')->default(true);
                $table->timestamp('joined_at')->useCurrent();
                $table->timestamp('created_at')->useCurrent();
                $table->timestamp('updated_at')->nullable();
            });
        }

        // 9. Reportes
        if (!Schema::hasTable('reportes')) {
            Schema::create('reportes', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->foreignUuid('usuario_id')->constrained('usuarios')->onDelete('cascade');
                $table->foreignUuid('categoria_id')->constrained('categorias');
                $table->foreignUuid('cuadrante_id')->nullable()->constrained('cuadrantes');
                $table->string('tipo_reporte'); // perdido, encontrado, adopcion, etc.
                $table->string('titulo');
                $table->text('descripcion')->nullable();
                $table->decimal('ubicacion_exacta_lat', 10, 8)->nullable();
                $table->decimal('ubicacion_exacta_lng', 11, 8)->nullable();
                $table->string('direccion_referencia')->nullable();
                $table->timestamp('fecha_perdida')->nullable();
                $table->timestamp('fecha_reporte')->useCurrent();
                $table->string('estado')->default('activo'); // activo, resuelto, cerrado
                $table->string('prioridad')->default('normal');
                $table->integer('nivel_expansion')->default(1);
                $table->integer('max_expansion')->default(3);
                $table->timestamp('proxima_expansion')->nullable();
                $table->boolean('contacto_publico')->default(true);
                $table->string('telefono_contacto')->nullable();
                $table->string('email_contacto')->nullable();
                $table->decimal('recompensa', 10, 2)->nullable();
                $table->integer('vistas')->default(0);
                $table->timestamp('created_at')->nullable();
                $table->timestamp('updated_at')->nullable();
            });
        }

        // 10. Reporte Imagenes
        if (!Schema::hasTable('reporte_imagenes')) {
            Schema::create('reporte_imagenes', function (Blueprint $table) {
                $table->id(); // Backup actually uses BIGINT sequence for this one (checked backup: CREATE SEQUENCE public.reporte_imagenes_id_seq)
                $table->foreignUuid('reporte_id')->constrained('reportes')->onDelete('cascade');
                $table->string('ruta'); // Backup uses 'ruta', not 'url'
                $table->string('tipo')->nullable();
                $table->timestamps();
            });
        }

        // 11. Respuestas (Comentarios/Avistamientos)
        if (!Schema::hasTable('respuestas')) {
            Schema::create('respuestas', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->foreignUuid('reporte_id')->constrained('reportes')->onDelete('cascade');
                $table->foreignUuid('usuario_id')->constrained('usuarios')->onDelete('cascade');
                $table->string('tipo_respuesta')->nullable(); // Backup uses 'tipo_respuesta'
                $table->text('mensaje')->nullable();
                $table->string('ubicacion')->nullable();
                $table->string('direccion_referencia')->nullable();
                $table->json('imagenes')->nullable();
                $table->json('videos')->nullable();
                $table->boolean('verificada')->default(false);
                $table->boolean('util')->default(false);
                $table->timestamp('created_at')->useCurrent();
                $table->timestamp('updated_at')->nullable();
            });
        }

        // 12. Expansiones Reporte
        if (!Schema::hasTable('expansiones_reporte')) {
            Schema::create('expansiones_reporte', function (Blueprint $table) {
                $table->uuid('id')->primary(); // Backup uses UUID
                $table->foreignUuid('reporte_id')->constrained('reportes')->onDelete('cascade');
                $table->uuid('cuadrante_original_id');
                $table->uuid('cuadrante_expandido_id');
                $table->integer('nivel');
                $table->timestamp('fecha_expansion')->useCurrent();
                $table->timestamp('created_at')->useCurrent();
                $table->timestamp('updated_at')->nullable();
            });
        }

        // 13. Notificaciones
        if (!Schema::hasTable('notificaciones')) {
            Schema::create('notificaciones', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->foreignUuid('usuario_id')->constrained('usuarios')->onDelete('cascade');
                $table->string('tipo');
                $table->string('titulo');
                $table->text('mensaje')->nullable(); // Backup has 'mensaje'
                $table->json('datos')->nullable();
                $table->boolean('leida')->default(false);
                $table->boolean('enviada_push')->default(false);
                $table->boolean('enviada_email')->default(false);
                $table->timestamp('created_at')->useCurrent();
                $table->timestamp('updated_at')->nullable();
            });
        }

        // 13. Notificaciones
        if (!Schema::hasTable('notificaciones')) {
            Schema::create('notificaciones', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->foreignUuid('usuario_id')->constrained('usuarios')->onDelete('cascade');
                $table->string('titulo');
                $table->text('contenido');
                $table->string('tipo'); // sistema, reporte, grupo, etc.
                $table->string('referencia_id')->nullable(); // ID del reporte o entidad relacionada
                $table->string('referencia_tipo')->nullable();
                $table->boolean('leido')->default(false);
                $table->timestamp('fecha_envio')->useCurrent();
                $table->timestamps();
            });
        }

        // 14. Configuracion Sistema
        if (!Schema::hasTable('configuracion_sistema')) {
            Schema::create('configuracion_sistema', function (Blueprint $table) {
                $table->id();
                $table->string('clave')->unique();
                $table->text('valor');
                $table->string('grupo')->default('general');
                $table->string('tipo')->default('string'); // string, integer, boolean, json
                $table->timestamps();
            });
        }
        
         // 15. Configuracion Notificaciones Usuario (Restored just in case)
        if (!Schema::hasTable('configuracion_notificaciones_usuario')) {
            Schema::create('configuracion_notificaciones_usuario', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->foreignUuid('usuario_id')->constrained('usuarios')->onDelete('cascade');
                $table->boolean('push_activo')->default(true);
                $table->boolean('email_activo')->default(true);
                $table->boolean('sms_activo')->default(false);
                $table->timestamps();
            });
        }

        // 16. Personal Access Tokens
        if (!Schema::hasTable('personal_access_tokens')) {
            Schema::create('personal_access_tokens', function (Blueprint $table) {
                $table->id();
                $table->morphs('tokenable'); // Important: This creates tokenable_id as BIGINT by default, but we might need UUID support if users use UUIDs.
                $table->string('name');
                $table->string('token', 64)->unique();
                $table->text('abilities')->nullable();
                $table->timestamp('last_used_at')->nullable();
                $table->timestamp('expires_at')->nullable()->index();
                $table->timestamps();
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('personal_access_tokens');
        Schema::dropIfExists('configuracion_notificaciones_usuario');
        Schema::dropIfExists('configuracion_sistema');
        Schema::dropIfExists('notificaciones');
        Schema::dropIfExists('expansiones_reporte');
        Schema::dropIfExists('respuestas');
        Schema::dropIfExists('reporte_imagenes');
        Schema::dropIfExists('reportes');
        Schema::dropIfExists('grupo_miembros');
        Schema::dropIfExists('grupos');
        Schema::dropIfExists('cuadrante_barrios');
        Schema::dropIfExists('cuadrantes');
        Schema::dropIfExists('categorias');
        Schema::dropIfExists('sessions');
        Schema::dropIfExists('password_reset_tokens');
        Schema::dropIfExists('usuarios');
    }
};
