<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Web\DashboardController;
use App\Http\Controllers\Web\UsuarioWebController;
use App\Http\Controllers\Web\ReporteWebController;
use App\Http\Controllers\Web\CategoriaWebController;
use App\Http\Controllers\Web\ConfiguracionWebController;
use App\Http\Controllers\GrupoController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

// Redirect root to dashboard
Route::get('/', function () {
    return redirect()->route('dashboard');
});

// Dashboard
Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

// Usuarios
Route::resource('usuarios', UsuarioWebController::class);

// Reportes
Route::resource('reportes', ReporteWebController::class);

// Categorías
Route::resource('categorias', CategoriaWebController::class);

// Cuadrantes
Route::prefix('cuadrantes')->name('cuadrantes.')->group(function () {
    Route::get('/', function () {
        $cuadrantes = \App\Models\Cuadrante::withCount('reportes')->get();
        return view('cuadrantes.index', compact('cuadrantes'));
    })->name('index');
});

// Grupos - ACTUALIZADO
Route::prefix('grupos')->name('grupos.')->group(function () {
    Route::get('/', [GrupoController::class, 'index'])->name('index');
    Route::get('/{id}', [GrupoController::class, 'show'])->name('show');
    Route::post('/{id}/join', [GrupoController::class, 'join'])->name('join');
    Route::post('/{id}/leave', [GrupoController::class, 'leave'])->name('leave');
});

// Respuestas
Route::prefix('respuestas')->name('respuestas.')->group(function () {
    Route::get('/', function () {
        $respuestas = \App\Models\Respuesta::with(['reporte', 'usuario'])->orderBy('created_at', 'desc')->get();
        return view('respuestas.index', compact('respuestas'));
    })->name('index');
});

// Notificaciones
Route::prefix('notificaciones')->name('notificaciones.')->group(function () {
    Route::get('/', function () {
        $notificaciones = \App\Models\Notificacion::with('usuario')->orderBy('created_at', 'desc')->paginate(50);
        return view('notificaciones.index', compact('notificaciones'));
    })->name('index');
});

// Configuración
Route::get('/configuracion', [ConfiguracionWebController::class, 'index'])->name('configuracion.index');