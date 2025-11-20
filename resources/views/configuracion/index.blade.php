
{{-- resources/views/configuracion/index.blade.php --}}
@extends('layouts.app')

@section('title', 'Configuración')
@section('page-title', 'Configuración del Sistema')

@section('content')
<div class="card">
    <div class="card-header">
        <h5 class="mb-0"><i class="bi bi-gear me-2"></i>Configuración del Sistema</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Clave</th>
                        <th>Valor</th>
                        <th>Descripción</th>
                        <th>Tipo</th>
                        <th>Actualizado</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($configuraciones as $config)
                    <tr>
                        <td><code>{{ $config->clave }}</code></td>
                        <td><strong>{{ $config->valor }}</strong></td>
                        <td>{{ $config->descripcion }}</td>
                        <td><span class="badge bg-secondary">{{ $config->tipo }}</span></td>
                        <td>{{ $config->updated_at->format('d/m/Y H:i') }}</td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection