<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Configuración de Puertos Múltiples
    |--------------------------------------------------------------------------
    |
    | Configuración para distribuir las rutas de la API en diferentes puertos
    | para optimizar el rendimiento.
    |
    */

    'ports' => [
        8000 => [
            'name' => 'Operaciones de Escritura y Críticas',
            'routes_file' => 'api-8000.php',
            'description' => 'Auth, crear reportes/respuestas, operaciones administrativas',
        ],
        8001 => [
            'name' => 'Lectura de Reportes',
            'routes_file' => 'api-8001.php',
            'description' => 'Consulta de reportes (MUY FRECUENTE)',
        ],
        8002 => [
            'name' => 'Notificaciones',
            'routes_file' => 'api-8002.php',
            'description' => 'Polling de notificaciones (MUY FRECUENTE)',
        ],
        8003 => [
            'name' => 'Geolocalización y Grupos',
            'routes_file' => 'api-8003.php',
            'description' => 'Consultas geográficas y grupos (FRECUENTE)',
        ],
        8004 => [
            'name' => 'Lectura de Respuestas',
            'routes_file' => 'api-8004.php',
            'description' => 'Consulta de respuestas (FRECUENTE)',
        ],
    ],

    /*
    |--------------------------------------------------------------------------
    | Puerto por Defecto
    |--------------------------------------------------------------------------
    |
    | Puerto que se usará cuando no se especifique APP_ROUTES_FILE
    |
    */
    'default_port' => 8000,
    'default_routes_file' => 'api-8000.php',
];

