
{{-- resources/views/respuestas/index.blade.php --}}
@extends('layouts.app')

@section('title', 'Respuestas')
@section('page-title', 'Gestión de Respuestas')

@section('content')
<div class="card">
    <div class="card-header">
        <h5 class="mb-0"><i class="bi bi-chat-dots me-2"></i>Lista de Respuestas</h5>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-hover data-table">
                <thead>
                    <tr>
                        <th>Reporte</th>
                        <th>Usuario</th>
                        <th>Tipo</th>
                        <th>Mensaje</th>
                        <th>Estado</th>
                        <th>Fecha</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach($respuestas as $respuesta)
                    <tr>
                        <td>
                            <strong>{{ Str::limit($respuesta->reporte->titulo, 30) }}</strong>
                        </td>
                        <td>{{ $respuesta->usuario->nombre }}</td>
                        <td>
                            <span class="badge bg-secondary">{{ ucfirst($respuesta->tipo_respuesta) }}</span>
                        </td>
                        <td>{{ Str::limit($respuesta->mensaje, 50) }}</td>
                        <td>
                            @if($respuesta->verificada)
                                <span class="badge bg-success">
                                    <i class="bi bi-check-circle"></i> Verificada
                                </span>
                            @endif
                            @if($respuesta->util)
                                <span class="badge bg-info">
                                    <i class="bi bi-star"></i> Útil
                                </span>
                            @endif
                        </td>
                        <td>{{ $respuesta->created_at->format('d/m/Y H:i') }}</td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>
@endsection