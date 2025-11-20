
{{-- resources/views/cuadrantes/index.blade.php --}}
@extends('layouts.app')

@section('title', 'Cuadrantes')
@section('page-title', 'Gestión de Cuadrantes')

@section('content')
<div class="card">
    <div class="card-header">
        <h5 class="mb-0"><i class="bi bi-grid-3x3 me-2"></i>Lista de Cuadrantes</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover data-table">
                <thead>
                    <tr>
                        <th>Código</th>
                        <th>Nombre</th>
                        <th>Ciudad</th>
                        <th>Zona</th>
                        <th>Coordenadas</th>
                        <th>Reportes</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($cuadrantes as $cuadrante)
                    <tr>
                        <td><strong>{{ $cuadrante->codigo }}</strong></td>
                        <td>{{ $cuadrante->nombre }}</td>
                        <td>{{ $cuadrante->ciudad }}</td>
                        <td>{{ $cuadrante->zona ?? 'N/A' }}</td>
                        <td>
                            <small class="text-muted">
                                Lat: {{ $cuadrante->lat_min }} - {{ $cuadrante->lat_max }}<br>
                                Lng: {{ $cuadrante->lng_min }} - {{ $cuadrante->lng_max }}
                            </small>
                        </td>
                        <td>
                            <span class="badge bg-info">{{ $cuadrante->reportes_count }} reportes</span>
                        </td>
                        <td>
                            @if($cuadrante->activo)
                                <span class="badge bg-success">Activo</span>
                            @else
                                <span class="badge bg-danger">Inactivo</span>
                            @endif
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection
