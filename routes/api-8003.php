<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CuadranteController;
use App\Http\Controllers\GrupoController;

/*
|--------------------------------------------------------------------------
| API Routes - Puerto 8003: Geolocalización y Grupos
|--------------------------------------------------------------------------
| Optimizado para consultas geográficas y gestión de grupos
*/

// ============================================
// CUADRANTES
// ============================================
Route::prefix('cuadrantes')->group(function () {
    // Detectar cuadrante por ubicación (FRECUENTE)
    Route::post('detectar', [CuadranteController::class, 'detectarCuadrante']);
    
    // Obtener 25 cuadrantes cercanos (FRECUENTE)
    Route::post('cercanos', [CuadranteController::class, 'cuadrantesCercanos']);
    
    // Listar todos los cuadrantes
    Route::get('/', [CuadranteController::class, 'index']);
    
    // Crear cuadrante (desde HTML)
    Route::post('/', [CuadranteController::class, 'store']);
    
    // Agregar barrio a cuadrante
    Route::post('{cuadranteId}/barrios', [CuadranteController::class, 'agregarBarrio']);
    
    // Obtener 8 cuadrantes adyacentes
    Route::get('{cuadranteId}/adyacentes', [CuadranteController::class, 'cuadrantesAdyacentes']);
    
    // Obtener cuadrante específico
    Route::get('{id}', [CuadranteController::class, 'show']);
});

// ============================================
// GRUPOS
// ============================================
Route::prefix('grupos')->group(function () {
    // Unir usuario a grupo automáticamente (FRECUENTE)
    Route::post('unir-automatico', [GrupoController::class, 'unirUsuarioAutomatico']);
    
    // Verificar y cambiar grupo automáticamente según ubicación (FRECUENTE)
    Route::post('verificar-cambio-grupo', [GrupoController::class, 'verificarCambioGrupo']);
    
    // Obtener grupos por cuadrantes (FRECUENTE)
    Route::post('por-cuadrantes', [GrupoController::class, 'gruposPorCuadrantes']);
    
    // Obtener grupos del usuario (FRECUENTE)
    Route::get('usuario/{usuarioId}', [GrupoController::class, 'gruposDelUsuario']);
    
    // Listar todos los grupos
    Route::get('/', [GrupoController::class, 'index']);
    
    // Crear grupo (desde HTML)
    Route::post('/', [GrupoController::class, 'store']);
    
    // Salir de un grupo
    Route::post('salir', [GrupoController::class, 'salirDelGrupo']);
    
    // Obtener miembros de un grupo
    Route::get('{grupoId}/miembros', [GrupoController::class, 'miembrosDelGrupo']);
    
    // Obtener grupo específico
    Route::get('{id}', [GrupoController::class, 'show']);
});

// ============================================
// RUTA DE PRUEBA
// ============================================
Route::get('/ping', function () {
    return response()->json([
        'success' => true,
        'message' => 'API Puerto 8003 funcionando correctamente',
        'timestamp' => now(),
        'port' => 8003
    ]);
});

