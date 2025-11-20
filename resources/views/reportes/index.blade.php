{{-- resources/views/reportes/index.blade.php --}}
@extends('layouts.app')

@section('title', 'Reportes')
@section('page-title', 'Gestión de Reportes')

@section('content')
<div class="card">
    <div class="card-header">
        <div class="row align-items-center">
            <div class="col-md-6">
                <h5 class="mb-0"><i class="bi bi-file-earmark-text me-2"></i>Lista de Reportes</h5>
            </div>
            <div class="col-md-6 text-end">
                <a href="{{ route('reportes.create') }}" class="btn btn-primary">
                    <i class="bi bi-plus-circle me-1"></i> Nuevo Reporte
                </a>
            </div>
        </div>
    </div>
    <div class="card-body">
        <!-- Filtros -->
        <div class="row mb-3">
            <div class="col-md-3">
                <select class="form-select" id="filtroTipo">
                    <option value="">Todos los tipos</option>
                    <option value="perdido">Perdidos</option>
                    <option value="encontrado">Encontrados</option>
                </select>
            </div>
            <div class="col-md-3">
                <select class="form-select" id="filtroEstado">
                    <option value="">Todos los estados</option>
                    <option value="activo">Activos</option>
                    <option value="resuelto">Resueltos</option>
                    <option value="inactivo">Inactivos</option>
                </select>
            </div>
            <div class="col-md-3">
                <select class="form-select" id="filtroCategoria">
                    <option value="">Todas las categorías</option>
                    @foreach($categorias ?? [] as $categoria)
                        <option value="{{ $categoria->id }}">{{ $categoria->nombre }}</option>
                    @endforeach
                </select>
            </div>
            <div class="col-md-3">
                <button class="btn btn-secondary w-100" onclick="limpiarFiltros()">
                    <i class="bi bi-x-circle"></i> Limpiar Filtros
                </button>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover data-table">
                <thead>
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
                    @foreach($reportes as $reporte)
                    <tr>
                        <td>
                            <strong>{{ Str::limit($reporte->titulo, 40) }}</strong>
                            @if($reporte->recompensa)
                                <br><small class="text-success"><i class="bi bi-cash"></i> Bs. {{ number_format($reporte->recompensa, 2) }}</small>
                            @endif
                        </td>
                        <td>
                            <span class="badge bg-{{ $reporte->tipo_reporte == 'perdido' ? 'danger' : 'success' }}">
                                <i class="bi bi-{{ $reporte->tipo_reporte == 'perdido' ? 'x-circle' : 'check-circle' }}"></i>
                                {{ ucfirst($reporte->tipo_reporte) }}
                            </span>
                        </td>
                        <td>
                            <span class="badge" style="background-color: {{ $reporte->categoria->color ?? '#6c757d' }}">
                                {{ $reporte->categoria->nombre ?? 'N/A' }}
                            </span>
                        </td>
                        <td>{{ $reporte->usuario->nombre ?? 'N/A' }}</td>
                        <td>
                            @switch($reporte->estado)
                                @case('activo')
                                    <span class="badge bg-primary">Activo</span>
                                    @break
                                @case('resuelto')
                                    <span class="badge bg-success">Resuelto</span>
                                    @break
                                @case('inactivo')
                                    <span class="badge bg-secondary">Inactivo</span>
                                    @break
                                @default
                                    <span class="badge bg-dark">{{ ucfirst($reporte->estado) }}</span>
                            @endswitch
                        </td>
                        <td>
                            @switch($reporte->prioridad)
                                @case('urgente')
                                    <span class="badge bg-danger">Urgente</span>
                                    @break
                                @case('alta')
                                    <span class="badge bg-warning text-dark">Alta</span>
                                    @break
                                @case('normal')
                                    <span class="badge bg-info">Normal</span>
                                    @break
                                @default
                                    <span class="badge bg-secondary">Baja</span>
                            @endswitch
                        </td>
                        <td>
                            <i class="bi bi-eye"></i> {{ $reporte->vistas }}
                        </td>
                        <td>
                            <small>{{ $reporte->created_at->format('d/m/Y') }}</small>
                        </td>
                        <td>
                            <div class="btn-group btn-group-sm">
                                <a href="{{ route('reportes.show', $reporte->id) }}" class="btn btn-info" title="Ver">
                                    <i class="bi bi-eye"></i>
                                </a>
                                <a href="{{ route('reportes.edit', $reporte->id) }}" class="btn btn-warning" title="Editar">
                                    <i class="bi bi-pencil"></i>
                                </a>
                                <form action="{{ route('reportes.destroy', $reporte->id) }}" method="POST" class="d-inline" onsubmit="return confirmarEliminacion(this)">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger" title="Eliminar">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>
</div>
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