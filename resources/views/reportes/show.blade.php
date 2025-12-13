

@extends('layouts.app')

@section('title', 'Ver Reporte')
@section('page-title', 'Detalle del Reporte')

@section('content')
<div class="row">
    <div class="col-md-10 mx-auto">
        <div class="card">
            <div class="card-header">
                <div class="row align-items-center">
                    <div class="col-md-8">
                        <h5 class="mb-0">
                            <span class="badge bg-{{ $reporte->tipo_reporte == 'perdido' ? 'danger' : 'success' }} me-2">
                                {{ ucfirst($reporte->tipo_reporte) }}
                            </span>
                            {{ $reporte->titulo }}
                        </h5>
                    </div>
                    <div class="col-md-4 text-end">
                        <a href="{{ route('reportes.edit', $reporte->id) }}" class="btn btn-warning btn-sm">
                            <i class="bi bi-pencil"></i> Editar
                        </a>
                        <a href="{{ route('reportes.index') }}" class="btn btn-secondary btn-sm">
                            <i class="bi bi-arrow-left"></i> Volver
                        </a>
                    </div>
                </div>
            </div>
            <div class="card-body">
                
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="text-muted small">Categoría</label>
                            <p>
                                <span class="badge fs-6" style="background-color: {{ $reporte->categoria->color }}">
                                    {{ $reporte->categoria->nombre }}
                                </span>
                            </p>
                        </div>
                        <div class="mb-3">
                            <label class="text-muted small">Usuario</label>
                            <p class="fw-bold">{{ $reporte->usuario->nombre }}</p>
                        </div>
                        <div class="mb-3">
                            <label class="text-muted small">Cuadrante</label>
                            <p class="fw-bold mb-0">
                                {{ $reporte->cuadrante->codigo }} - {{ $reporte->cuadrante->nombre }}
                            </p>
                            @if($reporte->cuadrante_sugerido && $reporte->cuadrante_sugerido->id !== $reporte->cuadrante->id)
                                <div class="text-danger small mt-1">
                                    <i class="bi bi-exclamation-triangle-fill"></i> Ubicación Real: 
                                    <strong>{{ $reporte->cuadrante_sugerido->codigo }}</strong>
                                </div>
                            @endif
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label class="text-muted small">Estado</label>
                            <p>
                                @switch($reporte->estado)
                                    @case('activo')
                                        <span class="badge bg-primary fs-6">Activo</span>
                                        @break
                                    @case('resuelto')
                                        <span class="badge bg-success fs-6">Resuelto</span>
                                        @break
                                    @default
                                        <span class="badge bg-secondary fs-6">{{ ucfirst($reporte->estado) }}</span>
                                @endswitch
                            </p>
                        </div>
                        <div class="mb-3">
                            <label class="text-muted small">Prioridad</label>
                            <p>
                                @switch($reporte->prioridad)
                                    @case('urgente')
                                        <span class="badge bg-danger fs-6">Urgente</span>
                                        @break
                                    @case('alta')
                                        <span class="badge bg-warning text-dark fs-6">Alta</span>
                                        @break
                                    @case('normal')
                                        <span class="badge bg-info fs-6">Normal</span>
                                        @break
                                    @default
                                        <span class="badge bg-secondary fs-6">Baja</span>
                                @endswitch
                            </p>
                        </div>
                        @if($reporte->recompensa)
                        <div class="mb-3">
                            <label class="text-muted small">Recompensa</label>
                            <p class="fw-bold text-success fs-5">
                                <i class="bi bi-cash"></i> Bs. {{ number_format($reporte->recompensa, 2) }}
                            </p>
                        </div>
                        @endif
                    </div>
                </div>

                <hr>

                
                <div class="mb-4">
                    <h6><i class="bi bi-file-text me-2"></i>Descripción</h6>
                    <p class="text-justify">{{ $reporte->descripcion }}</p>
                </div>

                @if($reporte->direccion_referencia)
                <div class="mb-4">
                    <h6><i class="bi bi-geo-alt me-2"></i>Ubicación</h6>
                    <p>{{ $reporte->direccion_referencia }}</p>
                </div>
                @endif

                
                @if($reporte->contacto_publico)
                <div class="mb-4">
                    <h6><i class="bi bi-telephone me-2"></i>Información de Contacto</h6>
                    <div class="row">
                        @if($reporte->telefono_contacto)
                        <div class="col-md-6">
                            <label class="text-muted small">Teléfono</label>
                            <p class="fw-bold">{{ $reporte->telefono_contacto }}</p>
                        </div>
                        @endif
                        @if($reporte->email_contacto)
                        <div class="col-md-6">
                            <label class="text-muted small">Email</label>
                            <p class="fw-bold">{{ $reporte->email_contacto }}</p>
                        </div>
                        @endif
                    </div>
                </div>
                @endif

                </div>

                <hr>

                <!-- Cronograma de Actividad -->
                <div class="mb-4">
                    <h5 class="mb-4"><i class="bi bi-hourglass-split me-2"></i>Cronograma de Actividad</h5>
                    
                    <div class="timeline position-relative">
                        @foreach($timeline as $evento)
                        <div class="timeline-item mb-4 position-relative ps-4 border-start border-2 border-{{ $evento['color'] }}">
                            <div class="position-absolute top-0 start-0 translate-middle rounded-circle bg-white border border-{{ $evento['color'] }} d-flex align-items-center justify-content-center" style="width: 32px; height: 32px;">
                                <i class="bi {{ $evento['icono'] }} text-{{ $evento['color'] }}"></i>
                            </div>
                            <div class="card border-{{ $evento['color'] }} shadow-sm">
                                <div class="card-body py-2">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <h6 class="card-title text-{{ $evento['color'] }} mb-0 fw-bold">{{ $evento['titulo'] }}</h6>
                                        <small class="text-muted" title="{{ $evento['fecha']->format('d/m/Y H:i:s') }}">
                                            {{ $evento['fecha']->diffForHumans() }}
                                        </small>
                                    </div>
                                    <p class="card-text small mb-1">{{ $evento['descripcion'] }}</p>
                                    @if($evento['usuario'])
                                        <footer class="blockquote-footer mt-1 mb-0 small">
                                            Por: {{ $evento['usuario']->nombre }}
                                        </footer>
                                    @endif
                                </div>
                            </div>
                        </div>
                        @endforeach
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<style>
.timeline-item:last-child {
    border-left: 0 !important;
    padding-left: 1.6rem !important; /* Ajuste para mantener alineación visual */
}
/* Asegurar que la línea conectora se vea bien */
.timeline-item {
    margin-left: 16px;
}
</style>
@endsection