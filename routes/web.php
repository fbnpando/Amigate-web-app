<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\ProductoController;

Route::get('/cuadrantes', function () {
    return view('cuadrantes');
});

