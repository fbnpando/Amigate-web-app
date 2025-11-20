{{-- resources/views/grupos/show.blade.php --}}
@extends('layouts.app')

@section('title', $grupo->nombre)
@section('page-title', $grupo->nombre)

@section('content')
<div class="row">
    <!-- Columna Izquierda: Info del Grupo -->
    <div class="col-lg-4 mb-4">
        <div class="card shadow-sm">
            <!-- Header del Grupo -->
            <div class="card-header bg-primary text-white">
                <div class="d-flex align-items-center">
                    <div class="avatar-circle me-3">
                        @if($grupo->imagen_url)
                            <img src="{{ $grupo->imagen_url }}" alt="{{ $grupo->nombre }}" class="rounded-circle" style="width: 60px; height: 60px; object-fit: cover;">
                        @else
                            <div class="bg-white text-primary rounded-circle d-flex align-items-center justify-content-center" style="width: 60px; height: 60px; font-size: 24px; font-weight: bold;">
                                {{ substr($grupo->nombre, 0, 1) }}
                            </div>
                        @endif
                    </div>
                    <div class="flex-grow-1">
                        <h5 class="mb-0">{{ $grupo->nombre }}</h5>
                        <small>{{ $grupo->miembros_count }} miembros</small>
                    </div>
                </div>
            </div>

            <!-- Información del Grupo -->
            <div class="card-body">
                <h6 class="text-muted mb-3"><i class="bi bi-info-circle me-2"></i>Información</h6>
                
                <div class="mb-3">
                    <strong>Cuadrante:</strong>
                    <div class="mt-1">
                        <span class="badge bg-primary">{{ $grupo->cuadrante->codigo }}</span>
                        <span class="text-muted">{{ $grupo->cuadrante->nombre }}</span>
                    </div>
                </div>

                @if($grupo->descripcion)
                <div class="mb-3">
                    <strong>Descripción:</strong>
                    <p class="text-muted mt-1">{{ $grupo->descripcion }}</p>
                </div>
                @endif

                <div class="mb-3">
                    <strong>Tipo de Grupo:</strong>
                    <div class="mt-1">
                        @if($grupo->publico)
                            <span class="badge bg-success"><i class="bi bi-unlock me-1"></i>Público</span>
                        @else
                            <span class="badge bg-warning text-dark"><i class="bi bi-lock me-1"></i>Privado</span>
                        @endif
                        
                        @if($grupo->requiere_aprobacion)
                            <span class="badge bg-info"><i class="bi bi-check-circle me-1"></i>Con Aprobación</span>
                        @endif
                    </div>
                </div>

                <div class="mb-3">
                    <strong>Creado:</strong>
                    <div class="text-muted mt-1">
                        {{ $grupo->created_at->format('d/m/Y H:i') }}
                        <small>({{ $grupo->created_at->diffForHumans() }})</small>
                    </div>
                </div>

                <!-- Estadísticas -->
                <div class="row text-center mt-4">
                    <div class="col-4">
                        <div class="stat-box">
                            <h3 class="text-primary mb-0">{{ $grupo->miembros_count }}</h3>
                            <small class="text-muted">Miembros</small>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="stat-box">
                            <h3 class="text-warning mb-0">{{ $grupo->reportes_activos_count }}</h3>
                            <small class="text-muted">Activos</small>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="stat-box">
                            <h3 class="text-success mb-0">{{ $grupo->reportes_resueltos_count }}</h3>
                            <small class="text-muted">Resueltos</small>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Lista de Miembros -->
            <div class="card-footer">
                <h6 class="mb-3"><i class="bi bi-people-fill me-2"></i>Miembros ({{ $grupo->miembros_count }})</h6>
                <div class="miembros-list" style="max-height: 300px; overflow-y: auto;">
                    @foreach($grupo->miembros as $miembro)
                    <div class="d-flex align-items-center mb-2 p-2 hover-bg-light rounded">
                        <div class="me-2">
                            @if($miembro->avatar_url)
                                <img src="{{ $miembro->avatar_url }}" alt="{{ $miembro->nombre }}" class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover;">
                            @else
                                <div class="bg-secondary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; font-size: 16px;">
                                    {{ substr($miembro->nombre, 0, 1) }}
                                </div>
                            @endif
                        </div>
                        <div class="flex-grow-1">
                            <strong>{{ $miembro->nombre }}</strong>
                            @if($miembro->pivot->rol === 'admin')
                                <span class="badge bg-danger badge-sm">Admin</span>
                            @elseif($miembro->pivot->rol === 'moderador')
                                <span class="badge bg-warning badge-sm">Moderador</span>
                            @endif
                        </div>
                    </div>
                    @endforeach
                </div>
            </div>
        </div>
    </div>

    <!-- Columna Derecha: Reportes (Estilo Chat) -->
    <div class="col-lg-8">
        <div class="card shadow-sm" style="height: calc(100vh - 200px);">
            <!-- Header de Reportes -->
            <div class="card-header bg-light border-bottom">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0">
                        <i class="bi bi-chat-left-dots me-2"></i>Reportes del Grupo
                    </h5>
                    <div class="btn-group btn-group-sm" role="group">
                        <button type="button" class="btn btn-outline-primary active" data-filter="todos">
                            Todos ({{ $reportes->total() }})
                        </button>
                        <button type="button" class="btn btn-outline-danger" data-filter="perdido">
                            Perdidos ({{ $reportes->where('tipo_reporte', 'perdido')->count() }})
                        </button>
                        <button type="button" class="btn btn-outline-success" data-filter="encontrado">
                            Encontrados ({{ $reportes->where('tipo_reporte', 'encontrado')->count() }})
                        </button>
                    </div>
                </div>
            </div>

            <!-- Lista de Reportes (Estilo Chat) -->
            <div class="card-body overflow-auto" id="reportes-container" style="height: calc(100% - 120px); background: #f5f5f5;">
                @forelse($reportes as $reporte)
                <div class="reporte-item mb-3 p-3 bg-white rounded shadow-sm hover-shadow" data-tipo="{{ $reporte->tipo_reporte }}">
                    <!-- Header del Reporte -->
                    <div class="d-flex justify-content-between align-items-start mb-2">
                        <div class="d-flex align-items-center">
                            <div class="me-2">
                                @if($reporte->usuario->avatar_url)
                                    <img src="{{ $reporte->usuario->avatar_url }}" alt="{{ $reporte->usuario->nombre }}" class="rounded-circle" style="width: 40px; height: 40px; object-fit: cover;">
                                @else
                                    <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; font-size: 16px;">
                                        {{ substr($reporte->usuario->nombre, 0, 1) }}
                                    </div>
                                @endif
                            </div>
                            <div>
                                <strong>{{ $reporte->usuario->nombre }}</strong>
                                <br>
                                <small class="text-muted">{{ $reporte->created_at->diffForHumans() }}</small>
                            </div>
                        </div>
                        <div>
                            @if($reporte->tipo_reporte === 'perdido')
                                <span class="badge bg-danger"><i class="bi bi-exclamation-triangle me-1"></i>Perdido</span>
                            @else
                                <span class="badge bg-success"><i class="bi bi-check-circle me-1"></i>Encontrado</span>
                            @endif
                            
                            @if($reporte->estado === 'resuelto')
                                <span class="badge bg-info"><i class="bi bi-check-all me-1"></i>Resuelto</span>
                            @endif
                        </div>
                    </div>

                    <!-- Categoría -->
                    <div class="mb-2">
                        <span class="badge" style="background-color: {{ $reporte->categoria->color }}">
                            <i class="bi bi-{{ $reporte->categoria->icono }} me-1"></i>{{ $reporte->categoria->nombre }}
                        </span>
                        
                        @if($reporte->prioridad === 'urgente')
                            <span class="badge bg-danger"><i class="bi bi-fire me-1"></i>Urgente</span>
                        @elseif($reporte->prioridad === 'alta')
                            <span class="badge bg-warning text-dark"><i class="bi bi-arrow-up me-1"></i>Alta</span>
                        @endif
                    </div>

                    <!-- Título y Descripción -->
                    <h6 class="mb-2"><strong>{{ $reporte->titulo }}</strong></h6>
                    <p class="mb-2 text-muted">{{ Str::limit($reporte->descripcion, 150) }}</p>

                    <!-- Imágenes -->
                    @if($reporte->tieneImagenes())
                    <div class="mb-2">
                        <div class="row g-2">
                            @foreach(array_slice($reporte->imagenes, 0, 3) as $index => $imagen)
                            <div class="col-4">
                                <img src="{{ asset('storage/' . $imagen) }}" alt="Imagen {{ $index + 1 }}" class="img-fluid rounded" style="height: 100px; object-fit: cover; width: 100%; cursor: pointer;" onclick="verImagen('{{ asset('storage/' . $imagen) }}')">
                            </div>
                            @endforeach
                            @if($reporte->cantidadImagenes() > 3)
                            <div class="col-4">
                                <div class="bg-dark text-white rounded d-flex align-items-center justify-content-center" style="height: 100px;">
                                    <span>+{{ $reporte->cantidadImagenes() - 3 }}</span>
                                </div>
                            </div>
                            @endif
                        </div>
                    </div>
                    @endif

                    <!-- Footer con información adicional -->
                    <div class="d-flex justify-content-between align-items-center mt-2 pt-2 border-top">
                        <div class="text-muted small">
                            <i class="bi bi-geo-alt me-1"></i>{{ $reporte->direccion_referencia ?? 'Sin ubicación' }}
                        </div>
                        <div>
                            @if($reporte->recompensa)
                            <span class="badge bg-warning text-dark me-2">
                                <i class="bi bi-currency-dollar me-1"></i>Bs. {{ number_format($reporte->recompensa, 2) }}
                            </span>
                            @endif
                            
                            <span class="badge bg-secondary me-2">
                                <i class="bi bi-eye me-1"></i>{{ $reporte->vistas }} vistas
                            </span>
                            
                            <span class="badge bg-info">
                                <i class="bi bi-chat me-1"></i>{{ $reporte->respuestas_count }} respuestas
                            </span>
                        </div>
                    </div>

                    <!-- Botón Ver Detalles -->
                    <div class="mt-2">
                        <a href="{{ route('reportes.show', $reporte->id) }}" class="btn btn-sm btn-outline-primary w-100">
                            <i class="bi bi-eye me-1"></i>Ver Detalles Completos
                        </a>
                    </div>
                </div>
                @empty
                <div class="text-center py-5">
                    <i class="bi bi-inbox display-1 text-muted"></i>
                    <p class="text-muted mt-3">No hay reportes en este grupo aún</p>
                </div>
                @endforelse
            </div>

            <!-- Paginación -->
            @if($reportes->hasPages())
            <div class="card-footer bg-white border-top">
                <div class="d-flex justify-content-center">
                    {{ $reportes->links() }}
                </div>
            </div>
            @endif
        </div>
    </div>
</div>

<!-- Modal para ver imagen completa -->
<div class="modal fade" id="imagenModal" tabindex="-1">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Imagen</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body text-center">
                <img id="imagenModalSrc" src="" class="img-fluid" alt="Imagen completa">
            </div>
        </div>
    </div>
</div>

@endsection

@push('styles')
<style>
.hover-bg-light:hover {
    background-color: #f8f9fa;
}

.hover-shadow:hover {
    box-shadow: 0 0.125rem 0.5rem rgba(0, 0, 0, 0.15) !important;
    transform: translateY(-2px);
    transition: all 0.3s ease;
}

.stat-box {
    padding: 10px;
}

.reporte-item {
    transition: all 0.3s ease;
}

#reportes-container {
    scroll-behavior: smooth;
}

#reportes-container::-webkit-scrollbar {
    width: 8px;
}

#reportes-container::-webkit-scrollbar-track {
    background: #f1f1f1;
}

#reportes-container::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 4px;
}

#reportes-container::-webkit-scrollbar-thumb:hover {
    background: #555;
}
</style>
@endpush

@push('scripts')
<script>
// Filtros de reportes
document.querySelectorAll('[data-filter]').forEach(btn => {
    btn.addEventListener('click', function() {
        const filter = this.dataset.filter;
        
        // Actualizar botones activos
        document.querySelectorAll('[data-filter]').forEach(b => b.classList.remove('active'));
        this.classList.add('active');
        
        // Filtrar reportes
        document.querySelectorAll('.reporte-item').forEach(item => {
            if (filter === 'todos' || item.dataset.tipo === filter) {
                item.style.display = 'block';
            } else {
                item.style.display = 'none';
            }
        });
    });
});

// Ver imagen en modal
function verImagen(src) {
    document.getElementById('imagenModalSrc').src = src;
    const modal = new bootstrap.Modal(document.getElementById('imagenModal'));
    modal.show();
}

// Auto-scroll al último reporte (opcional)
// document.getElementById('reportes-container').scrollTop = document.getElementById('reportes-container').scrollHeight;
</script>
@endpush