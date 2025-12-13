<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. usuarios
        if (!Schema::hasTable('usuarios')) {
            Schema::create('usuarios', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->string('nombre');
                $table->string('email')->unique();
                $table->string('telefono')->nullable();
                $table->string('avatar_url')->nullable();
                $table->integer('puntos_ayuda')->default(0);
                $table->boolean('activo')->default(true);
                $table->timestamp('fecha_registro')->useCurrent();
                $table->string('rol')->nullable();
                $table->string('contrasena')->nullable();
                $table->decimal('ubicacion_actual_lat', 10, 8)->nullable();
                $table->decimal('ubicacion_actual_lng', 11, 8)->nullable();
                $table->timestamps();
            });
        }

        // 2. categorias
        if (!Schema::hasTable('categorias')) {
            Schema::create('categorias', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->string('nombre');
                $table->string('icono')->nullable();
                $table->string('color')->nullable();
                $table->string('descripcion')->nullable();
                $table->boolean('activo')->default(true);
                $table->timestamp('created_at')->useCurrent();
            });
        }

        // 3. cuadrantes
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
                $table->decimal('centro_lat', 10, 8)->nullable();
                $table->decimal('centro_lng', 11, 8)->nullable();
                $table->timestamp('created_at')->useCurrent();
            });
        }

        // 4. cuadrante_barrios
        if (!Schema::hasTable('cuadrante_barrios')) {
            Schema::create('cuadrante_barrios', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->uuid('cuadrante_id');
                $table->string('nombre_barrio');
                $table->timestamp('created_at')->useCurrent();

                $table->foreign('cuadrante_id')->references('id')->on('cuadrantes')->onDelete('cascade');
            });
        }

        // 5. grupos
        if (!Schema::hasTable('grupos')) {
            Schema::create('grupos', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->uuid('cuadrante_id')->index(); // Assuming index is useful
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

        // 6. grupo_miembros
        if (!Schema::hasTable('grupo_miembros')) {
            Schema::create('grupo_miembros', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->uuid('grupo_id');
                $table->uuid('usuario_id');
                $table->string('rol')->default('miembro');
                $table->boolean('notificaciones_activas')->default(true);
                $table->timestamp('joined_at')->useCurrent();
                $table->timestamps();

                $table->foreign('grupo_id')->references('id')->on('grupos')->onDelete('cascade');
                $table->foreign('usuario_id')->references('id')->on('usuarios')->onDelete('cascade');
            });
        }

        // 7. reportes
        if (!Schema::hasTable('reportes')) {
            Schema::create('reportes', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->uuid('usuario_id');
                $table->uuid('categoria_id');
                $table->uuid('cuadrante_id');
                $table->string('tipo_reporte');
                $table->string('titulo');
                $table->text('descripcion')->nullable();
                $table->decimal('ubicacion_exacta_lat', 10, 8)->nullable();
                $table->decimal('ubicacion_exacta_lng', 11, 8)->nullable();
                $table->string('direccion_referencia')->nullable();
                $table->timestamp('fecha_perdida')->nullable();
                $table->timestamp('fecha_reporte')->useCurrent();
                $table->string('estado')->default('activo');
                $table->string('prioridad')->default('normal');
                $table->integer('nivel_expansion')->default(1);
                $table->integer('max_expansion')->default(3);
                $table->timestamp('proxima_expansion')->nullable();
                $table->boolean('contacto_publico')->default(true);
                $table->string('telefono_contacto')->nullable();
                $table->string('email_contacto')->nullable();
                $table->decimal('recompensa', 10, 2)->nullable();
                $table->integer('vistas')->default(0);
                $table->timestamps();

                $table->foreign('usuario_id')->references('id')->on('usuarios')->onDelete('cascade');
                $table->foreign('categoria_id')->references('id')->on('categorias')->onDelete('cascade');
                // Allow cuadrante deletion to set null or cascade? Backup uses IDs so cascade likely ok
                $table->foreign('cuadrante_id')->references('id')->on('cuadrantes')->onDelete('cascade'); 
            });
        }

        // 8. reporte_imagenes
        if (!Schema::hasTable('reporte_imagenes')) {
            Schema::create('reporte_imagenes', function (Blueprint $table) {
                $table->id();
                $table->uuid('reporte_id');
                $table->string('ruta');
                $table->string('tipo')->nullable();
                $table->timestamps();

                $table->foreign('reporte_id')->references('id')->on('reportes')->onDelete('cascade');
            });
        }

        // 9. respuestas
        if (!Schema::hasTable('respuestas')) {
            Schema::create('respuestas', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->uuid('reporte_id');
                $table->uuid('usuario_id');
                $table->string('tipo_respuesta')->nullable();
                $table->text('mensaje')->nullable();
                $table->string('ubicacion')->nullable();
                $table->string('direccion_referencia')->nullable();
                $table->json('imagenes')->nullable();
                $table->json('videos')->nullable();
                $table->boolean('verificada')->default(false);
                $table->boolean('util')->default(false);
                $table->timestamps();

                $table->foreign('reporte_id')->references('id')->on('reportes')->onDelete('cascade');
                $table->foreign('usuario_id')->references('id')->on('usuarios')->onDelete('cascade');
            });
        }

        // 10. expansiones_reporte
        if (!Schema::hasTable('expansiones_reporte')) {
            Schema::create('expansiones_reporte', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->uuid('reporte_id');
                $table->uuid('cuadrante_original_id');
                $table->uuid('cuadrante_expandido_id');
                $table->integer('nivel');
                $table->timestamp('fecha_expansion')->nullable();
                $table->timestamps();

                $table->foreign('reporte_id')->references('id')->on('reportes')->onDelete('cascade');
            });
        }

        // 11. notificaciones
        if (!Schema::hasTable('notificaciones')) {
            Schema::create('notificaciones', function (Blueprint $table) {
                $table->uuid('id')->primary();
                $table->uuid('usuario_id');
                $table->string('tipo');
                $table->string('titulo');
                $table->text('mensaje')->nullable();
                $table->json('datos')->nullable();
                $table->boolean('leida')->default(false);
                $table->boolean('enviada_push')->default(false);
                $table->boolean('enviada_email')->default(false);
                $table->timestamps();

                $table->foreign('usuario_id')->references('id')->on('usuarios')->onDelete('cascade');
            });
        }

        // 12. configuracion_sistema
        if (!Schema::hasTable('configuracion_sistema')) {
            Schema::create('configuracion_sistema', function (Blueprint $table) {
                $table->string('clave')->primary();
                $table->text('valor')->nullable();
                $table->string('descripcion')->nullable();
                $table->string('tipo')->default('string');
                $table->timestamps();
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
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
        Schema::dropIfExists('usuarios');
    }
};
