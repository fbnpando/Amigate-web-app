<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

// Determinar qué archivo de rutas API usar según el puerto
$apiRoutesFile = env('APP_ROUTES_FILE', 'api.php');
$apiRoutesPath = __DIR__.'/../routes/'.$apiRoutesFile;

// Si el archivo no existe, usar el default
if (!file_exists($apiRoutesPath)) {
    $apiRoutesPath = __DIR__.'/../routes/api.php';
}

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        api: $apiRoutesPath,
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        // Registro de middlewares de Spatie Permission
        $middleware->alias([
            'role' => \Spatie\Permission\Middleware\RoleMiddleware::class,
            'permission' => \Spatie\Permission\Middleware\PermissionMiddleware::class,
            'role_or_permission' => \Spatie\Permission\Middleware\RoleOrPermissionMiddleware::class,
            'check.site.access' => \App\Http\Middleware\CheckSiteAccess::class,
        ]);
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
