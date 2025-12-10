{{-- resources/views/reportes/index.blade.php --}}
@extends('layouts.app')

@section('title', 'Reportes')
@section('page-title', 'Gestión de Reportes')

@section('content')
{{-- Estadísticas Generales --}}
<div class="row mb-4">
    <div class="col-xl-3 col-md-6 mb-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0">
                        <div class="rounded-circle bg-primary bg-opacity-10 p-3">
                            <i class="bi bi-file-earmark-text fs-4 text-primary"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-1 text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">Total Reportes</h6>
                        <h3 class="mb-0 fw-bold">{{ $reportes->count() }}</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6 mb-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0">
                        <div class="rounded-circle bg-success bg-opacity-10 p-3">
                            <i class="bi bi-check-circle fs-4 text-success"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-1 text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">Resueltos</h6>
                        <h3 class="mb-0 fw-bold">{{ $reportes->where('estado', 'resuelto')->count() }}</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6 mb-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0">
                        <div class="rounded-circle bg-danger bg-opacity-10 p-3">
                            <i class="bi bi-exclamation-triangle fs-4 text-danger"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-1 text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">Activos</h6>
                        <h3 class="mb-0 fw-bold">{{ $reportes->where('estado', 'activo')->count() }}</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-xl-3 col-md-6 mb-3">
        <div class="card border-0 shadow-sm h-100">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <div class="flex-shrink-0">
                        <div class="rounded-circle bg-warning bg-opacity-10 p-3">
                            <i class="bi bi-bar-chart fs-4 text-warning"></i>
                        </div>
                    </div>
                    <div class="flex-grow-1 ms-3">
                        <h6 class="text-muted mb-1 text-uppercase" style="font-size: 0.75rem; letter-spacing: 0.5px;">Tasa Resolución</h6>
                        <h3 class="mb-0 fw-bold">{{ $reportes->count() > 0 ? round(($reportes->where('estado', 'resuelto')->count() / $reportes->count()) * 100, 1) : 0 }}%</h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{{-- Panel Principal --}}
<div class="card border-0 shadow-sm">
    <div class="card-header bg-white border-0 py-3">
        <div class="row align-items-center">
            <div class="col">
                <h5 class="mb-0 fw-bold">
                    <i class="bi bi-file-earmark-text text-primary me-2"></i>
                    Catálogo de Reportes
                </h5>
                <p class="text-muted small mb-0 mt-1">Administra y gestiona todos los reportes del sistema</p>
            </div>
            <div class="col-auto">
                <a href="{{ route('reportes.create') }}" class="btn btn-primary px-4">
                    <i class="bi bi-plus-circle me-2"></i> Nuevo Reporte
                </a>
            </div>
        </div>
    </div>
    <div class="card-body p-4">
        <!-- Filtros -->
        <div class="row mb-4">
            <div class="col-md-3 mb-2">
                <label class="form-label small text-muted">Tipo de Reporte</label>
                <select class="form-select" id="filtroTipo">
                    <option value="">Todos los tipos</option>
                    <option value="perdido">Perdidos</option>
                    <option value="encontrado">Encontrados</option>
                </select>
            </div>
            <div class="col-md-3 mb-2">
                <label class="form-label small text-muted">Estado</label>
                <select class="form-select" id="filtroEstado">
                    <option value="">Todos los estados</option>
                    <option value="activo">Activos</option>
                    <option value="resuelto">Resueltos</option>
                    <option value="inactivo">Inactivos</option>
                </select>
            </div>
            <div class="col-md-3 mb-2">
                <label class="form-label small text-muted">Categoría</label>
                <select class="form-select" id="filtroCategoria">
                    <option value="">Todas las categorías</option>
                    @foreach($categorias ?? [] as $categoria)
                        <option value="{{ $categoria->id }}">{{ $categoria->nombre }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-3 mb-2">
                <label class="form-label small text-muted">&nbsp;</label>
                <button class="btn btn-outline-secondary w-100" onclick="limpiarFiltros()">
                    <i class="bi bi-x-circle me-1"></i> Limpiar Filtros
                </button>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover data-table align-middle">
                <thead class="table-light">
                    <tr>
                        <th>Título</th>
                        <th>Tipo</th>
                        <th>Categoría</th>
                        <th>Usuario</th>
                        <th>Estado</th>
                        <th>Prioridad</th>
                        <th>Vistas</th>
                        <th>Fecha</th>
                        <th width="150px">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($reportes as $reporte)
                    <tr>
                        <td>
                            <div class="d-flex align-items-start">
                                <div class="flex-shrink-0 me-2">
                                    <div class="rounded bg-primary bg-opacity-10 p-2">
                                        <i class="bi bi-file-earmark-text text-primary"></i>
                                    </div>
                                </div>
                                <div class="flex-grow-1">
                                    <strong class="d-block">{{ Str::limit($reporte->titulo, 40) }}</strong>
                            @if($reporte->recompensa)
                                        <small class="text-success">
                                            <i class="bi bi-cash-coin me-1"></i>Bs. {{ number_format($reporte->recompensa, 2) }}
                                        </small>
                            @endif
                                </div>
                            </div>
                        </td>
                        <td>
                            <span class="badge bg-{{ $reporte->tipo_reporte == 'perdido' ? 'danger' : 'success' }}-subtle text-{{ $reporte->tipo_reporte == 'perdido' ? 'danger' : 'success' }} border border-{{ $reporte->tipo_reporte == 'perdido' ? 'danger' : 'success' }}">
                                <i class="bi bi-{{ $reporte->tipo_reporte == 'perdido' ? 'x-circle' : 'check-circle' }}-fill me-1"></i>
                                {{ ucfirst($reporte->tipo_reporte) }}
                            </span>
                        </td>
                        <td>
                            <span class="badge rounded-pill" style="background-color: {{ $reporte->categoria->color ?? '#6c757d' }}20; color: {{ $reporte->categoria->color ?? '#6c757d' }}; border: 1px solid {{ $reporte->categoria->color ?? '#6c757d' }}">
                                <i class="bi bi-tag-fill me-1"></i>{{ $reporte->categoria->nombre ?? 'N/A' }}
                            </span>
                        </td>
                        <td>
                            <div class="d-flex align-items-center">
                                @if($reporte->usuario->avatar_url ?? false)
                                    <img src="{{ $reporte->usuario->avatar_url }}" class="rounded-circle me-2" width="32" height="32" alt="Avatar">
                                @else
                                    <div class="rounded-circle bg-primary text-white d-flex align-items-center justify-content-center me-2" style="width: 32px; height: 32px; font-size: 12px;">
                                        {{ substr($reporte->usuario->nombre ?? 'U', 0, 1) }}
                                    </div>
                                @endif
                                <span>{{ $reporte->usuario->nombre ?? 'N/A' }}</span>
                            </div>
                        </td>
                        <td>
                            @switch($reporte->estado)
                                @case('activo')
                                    <span class="badge bg-primary-subtle text-primary border border-primary">Activo</span>
                                    @break
                                @case('resuelto')
                                    <span class="badge bg-success-subtle text-success border border-success">
                                        <i class="bi bi-check-circle-fill me-1"></i>Resuelto
                                    </span>
                                    @break
                                @case('inactivo')
                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary">Inactivo</span>
                                    @break
                                @default
                                    <span class="badge bg-dark-subtle text-dark border border-dark">{{ ucfirst($reporte->estado) }}</span>
                            @endswitch
                        </td>
                        <td>
                            @switch($reporte->prioridad)
                                @case('urgente')
                                    <span class="badge bg-danger-subtle text-danger border border-danger">
                                        <i class="bi bi-exclamation-triangle-fill me-1"></i>Urgente
                                    </span>
                                    @break
                                @case('alta')
                                    <span class="badge bg-warning-subtle text-warning border border-warning">Alta</span>
                                    @break
                                @case('normal')
                                    <span class="badge bg-info-subtle text-info border border-info">Normal</span>
                                    @break
                                @default
                                    <span class="badge bg-secondary-subtle text-secondary border border-secondary">Baja</span>
                            @endswitch
                        </td>
                        <td>
                            <div class="d-flex align-items-center">
                                <i class="bi bi-eye text-muted me-1"></i>
                                <span class="fw-semibold">{{ $reporte->vistas ?? 0 }}</span>
                            </div>
                        </td>
                        <td>
                            <small class="text-muted">
                                <i class="bi bi-calendar3 me-1"></i>{{ $reporte->created_at->format('d/m/Y') }}<br>
                                <i class="bi bi-clock me-1"></i>{{ $reporte->created_at->format('H:i') }}
                            </small>
                        </td>
                        <td>
                            <div class="btn-group btn-group-sm">
                                <a href="{{ route('reportes.show', $reporte->id) }}" class="btn btn-outline-info" title="Ver">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <a href="{{ route('reportes.edit', $reporte->id) }}" class="btn btn-outline-warning" title="Editar">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form action="{{ route('reportes.destroy', $reporte->id) }}" method="POST" class="d-inline" onsubmit="return confirmarEliminacion(this)">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-outline-danger" title="Eliminar">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    @empty
                    <tr>
                        <td colspan="9" class="text-center py-5">
                            <div class="mb-3">
                                <i class="bi bi-inbox fs-1 text-muted"></i>
                            </div>
                            <h5 class="text-muted">No hay reportes registrados</h5>
                            <p class="text-muted small">Comienza creando tu primer reporte</p>
                            <a href="{{ route('reportes.create') }}" class="btn btn-primary mt-2">
                                <i class="bi bi-plus-circle me-2"></i> Crear Reporte
                            </a>
                        </td>
                    </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>

<style>
    .table tbody tr {
        transition: all 0.2s ease;
    }
    
    .table tbody tr:hover {
        background-color: #f8f9fa;
        transform: scale(1.01);
    }
</style>
@endsection

@push('scripts')
<script>
    function limpiarFiltros() {
        document.getElementById('filtroTipo').value = '';
        document.getElementById('filtroEstado').value = '';
        document.getElementById('filtroCategoria').value = '';
    }
</script>
@endpush